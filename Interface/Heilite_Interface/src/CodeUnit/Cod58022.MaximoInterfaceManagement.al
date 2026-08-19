codeunit 58022 "Maximo Interface Management"
{
    // Heilite Navision Old Id - 50034

    // version HEI.51

    // HEI.01 FDD-PURGAPINT002 IBM LAZARE02 14.09.2017 # New codeunit for Maximo integration
    // HEI.02 FDD-PURGAPINT002 IBM HORTOC01 27.09.2017 # Bug fixes
    // HEI.03 IBM HORTOC01 27.06.2018 - process Maximo Transfer Receipts
    // HEI.04 PURGAP028 IBM LAZARE02 09.07.2018 - new field Send to Maximo
    // HEI.05 FDD-PURGAP026 IBM NASTAA02 27.07.2018 # Item Selection Heilite-Maximo Interface
    //   # Used Table 50094 - Maximo Item Category Filter for filtering instead of deleted Field "Maximo Item Category Filter"
    //   # New Function "FindItemFilters" created to filter the Items
    // HEI.06 Defect #2638 IBM NASTAA02 12.09.2018 # CMG Code not updated
    //   # Used "CMG Code FND" instead of "CMG ID" which is linked to "Dimension Values"
    // HEI.07 FDD-PURGAP029 IBM HORTOC01 14.12.2018 # undo purchase receipt
    // HEI.09 FDD-PURGAP027 - Maximo POs approval flow, IBM.POENAB02 , 28.02.2019
    //   # Modified function ProcessPRCreation
    // HEI.10 FDD-PURGAP028 IBM GAVANM01 22.03.2019 # Maximo Goods Receipt
    //   # Added code to function "ProcessPurchaseReceipt"
    // HEI.11 FDD-CHG0270634 IBM ISYED01 25.04.2019
    //   # Added code to function Check mandatory dimensions in Purchase  documents
    // HEI.12 FDD-PURGAP027 IBM NASTAA02 11.06.2019 # Maximo POs Approval Flow
    //   # Field "PQ Approver" has been moved to an extension Table
    // HEI.13 HB351 FDD-PURGAP028 CHG0270792 IBM GAVANM01 26.07.2019 # Maximo Goods Receipt
    //   # Added code to function "ProcessPurchaseReceipt"
    // HEI.14 HB351 FDD-PURGAP028 CHG0270792 IBM GAVANM01 17.10.2019 # Maximo Goods Receipt
    //   # comment code in function "ProcessPurchaseReceipt"
    // HEI.15 FDD- HT821 IBM SHANKJ03 11.02.2020
    //  # Added coding o update Maximo status from intreface table to purchase header table.
    // HEI.16 CHG2042951 IBM POENAB02 10.04.2020 # Procurement of Services Maximo - HeiLite
    //  # Modified functions: ProcessPRCreation, ProcessPurchaseReceipt, ProcessTransferReceipt, CreatePORequest
    // HEI.17 CHG2052621 IBM SHANKJ03 16.07.2020
    //   # Modified fucnion : createItemRequest
    // HEI.18 CHG2024349 IBM.GUNERE01 10.08.2020 # ProcessPRCreation, CreatePORequest funcs. modified
    // HEI.19 CHG2061790 IBM NANDIS01 14.09.2020 HB1364 Maximo Partial GR(Posting Date)
    //   # Modify function - ProcessPurchaseReceipt
    // HEI.20 CHG2083029 HB1688 IBM.GUNERE01 29.01.2021 # ProcessPurchaseReceipt func. modified
    // HEI.21 CHG2077676 IBM POENAB02 10.03.2021 HB1174 Include locations in ItemMD HeiLite->Maximo interface
    //   # Modified functions CreateItemRequest, CreateItemEntry
    //   # New functions: CreateItemRequestGroupHeader, CreateItemRequestGrouped, CreateItemEntryGrouped
    // HEI.22 HB1986 - CHG2095257 IBM NANDIS01 16.03.2021 - Maximo Unit Cost interface Redesign
    //   # New function created CreateUnitCostRedesigned for Maximo Unit cost interface
    // HEI.23 CHG2103218 IBM NANDIS01 22.03.2021 - Consumptions interfaced several times
    //   # Stop posting of ILE for consumption received from MAXIMO-GOOD -ISSUE interface - modified function - ProcessGoodsIssue
    // HEI.24 FDD-HB1195 CHG2070051 IBM GUNERE01 04.02.2021 # ProcessPRCreation func. modified
    // HEI.25 CHG2095242 IBM NANDIS01 20.04.2021 - Unit of Measure conversion Maximo-HeiLite interface
    //   # New Function - CreateItemUOMRequest created and called after Maximo Item data log
    // HEI.26 FDD-HB1195 CHG2070051 IBM GUNERE01 07.07.2021 # CreatePORequest func. modified
    // HEI.27 FDD-HB1195 CHG2070051 IBM NANDIS01 Import Purchasing & Receiving process HeiLite-Maximo integration
    //   Different tag other than HEI.24 and HEI.26 used, as TO posting is handled separately
    //   New function - ProcessTransferShipmentReceipt for processing of auto shipment and receipt of TOs
    //   modification done in function - ProcessPurchaseReceipt
    // HEI.28 CHG2117742 IBM.GUNERE01 07.09.2021 # UndoPurchaseReceipt func. modified
    // HEI.30 FDD - HB1797 CHG2086227 IBM NANDIS01 24.08.2021 - LOG_GR Acknowledgement Message to Global Maximo (aka req.2 of HB1688)
    //   # Change the Maximo Purch Rcpt to Sync from Async
    // HEI.31 CHG2123789 IBM SHIVAS05 27.08.2021-Skipping the reopen and release As well as document date updation
    //   # Modification done in function - ProcessPurchaseReceipt
    // HEI.32 CHG2103752 IBM BHATTA09 07.09.2021
    //   # Code added for Maximo PO Final Delivery functionality
    // HEI.33 CHG2124414 FDD HB2378 Maximo HL VL Contract link for CMG items
    //   #Code added under function - ProcessPRCreation
    // HEI.36 FDD-HB2378 CHG2124414 IBM NANDIS01 28-04-2022 - Maximo HL VL Contract link for CMG items
    //   # Unit price will be fetched from item card if xml has 0 value
    // HEI.37 CHG2162410 IBM NANDIS01 17-06-2022 - Diesel & Heavy Fuel Oils Maximo PRs are not replicated
    //   # Corrective change to fix "CLOSED" issue of contracts
    // HEI.39 CHG2161030 FDD-HB2982 IBM NANDIS01 22-07-2022 # Update of Posting Date from Shipment date Maximo
    //   # Posting date of TO should be changed as per request from Maximo PURCH RCPT interface - CHange in function ProcessTransferShipmentReceipt
    // HEI.40 CHG2162410 IBM NANDIS01 01-08-2022 - Diesel & Heavy Fuel Oils Maximo PRs are not replicated
    //   # Fix after FAT to clear variable
    // HEI.41 CHG2161030 FDD-HB2982 IBM NANDIS01 04-08-2022 # Update of Posting Date from Shipment date Maximo
    //   # Fix after FAT, as posting date is getting updated on ware trans shipment and war trans rcpt level
    // HEI.34 FDD-HB2060 CHG2103752 IBM NANDIS01 21-02-2022 - Final delivery and PO closure HL  Global Maximo
    //   # Two new tags introduced in Maximo Purchase Receipt - DeliveryFinalized and RECEIPTSCOMPLETE
    // HEI.35 FDD-HB2060 CHG2103752 IBM NANDIS01 02-03-2022 - Final delivery and PO closure HL  Global Maximo
    //   # Update Delivery Finalized when RECEIPTSCOMPLETE is checked in Purchase Line
    // HEI.38 FDD-HB2060 CHG2103752 IBM NANDIS01 23-06-2022 - Final delivery and PO closure HL  Global Maximo
    //   # blocked code in function - ProcessPurchaseReceipt
    // HEI.42 CHG2173193 IBM NANDIS01 13-09-2022 #Please help to fix the interface issues on the GR's created in Maximo.
    //   # Quantity should be updated on contract level
    // HEI.44 HB3985-CHG2257892 IBM PATHAA02 25-07-24 Send Unit Cost To Maximo | Sending More Than One Technical Zone to Maximo
    //   # Modified Function-CreateUnitCostRedesigned() to Include all Technical Zones
    // HEI.46 CHG2270836 CHOUDS08 05.12.2024 BASE Reprocess Enhancement for Entries in Error Interface Report
    //   # Used function IsValidDate() from Inventory Period Table(5814) to update the Posting Date to current date when posting date falls in a closed
    // HEI.45 CHG2261139 SAHAL01 03.12.2024 Item Code Issues - one item on multiple lines
    //   # Added Code
    // HEI.47 CHG2295010 CHOUDS08 16.03.2024  Maximo Error interface Burundi // item 0020012027
    //   # Modified Function-CreateAndPostTransferWhsShpmnt() to work for warehouse shipment lines deleted scenario by using Source No instead of Line No
    // HEI.50 CHG2314530 SHARMP16 07.08.2025 CC Interface issue between Heilite Base & Maximo - Development
    //   # Code Added on ProcessTransferShipmentReceipt
    //   # Code Added on CreateAndPostTransferWhsShpmnt
    //   # Code Added on CreateAndPostTransferWhsReceipt
    // HEI.51 CHG2314530 SHARMP16 12.08.2025 CC Interface issue between Heilite Base & Maximo - Development
    //   # Change Error tag ProcessTransferShipmentReceipt
    // HEI.49 CHG2311960 SHARMP16 22.07.2025 CC incident link to INC5040545 - Development
    //   # Code to update the amount excluding VAT disappear when we change the VAT- INC5132780 on ProcessPRCreation()
    // HEI.52 CHG2322546 SAHAL01 17.09.2025 Maximo goods Issue cannot reprocess the entries in Error Interface report
    //   # Added Code


    // BC upgrade BHARDA11 >>
    // 1. Remove Drink-IT Fields and related code (Language."ISO Language Text","Auto Receive after Qlty. Test","Whse. Receipt No. (Open)",WarehouseRequest."Warehouse Rcpt/Shpt No.",Item."Auto Receive after Qlty. Test")
    // 2. Remove Drink-IT Functions and related code(SetHideValidationDialog ,Fct_Batchprocessing,DocStatusOpen)
    // 3. Create variable HenekenBcCustomFun: Codeunit "Heineken BC Custom Functions" and use thi in the place of this ArchiveManagement.ArchivePurchDocumentOnReopen.
    // BC Upgrade BHARDA11 <<

    // BC Upgrade PATELS08 >>
    // # Added Tag HEI.49 to documentation and added code to procedure 'ProcessPRCreation'
    // # Added Tag HEI.52 to documentation and added code in procedure 'ProcessGoodsIssue'
    // BC Upgrade PATELS08 <<
    //BC UPGRADE ATHUKS01 FDD_STP11 >>
    //1.Uncommented code for Process MaximoPurchasReceipt added fields ("Whse. Receipt No. (Open)",WarehouseRequest."Warehouse Rcpt/Shpt No.")
    //2.PurchLine2ReceiptLine Method is removed in Whse.-Create Source Document in BC & Method is moved to PurchasesWarehouseMgt Codeunit.
    //BC UPGRADE ATHUKS01 FDD_STP11<<

    // BC Upgrade PATELP08>>
    // Changed name of table from "Last Send Interface Values" to "Last Send Interface Values FND"
    // BC Upgrade PATELP08<<

    trigger OnRun();
    begin
    end;

    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        GLSetup: Record "General Ledger Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        CompanyInformation: Record "Company Information";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        DimensionManagement: Codeunit DimensionManagement;
        GeneralInterfaceSetupRead: Boolean;
        GLSetupRead: Boolean;
        PurchSetupRead: Boolean;
        CompanyInformationRead: Boolean;
        POAlreadyCreatedForPRErr: Label 'PR %1 line no. %2 has already been processed to PO %3.';
        MaximoConsProdOrderQst: Label '%1 is used for Maximo consumptions. Do you want to continue?';
        UserFromInterface: Text;
        // DomainName: Text;//BC Upgrade SHARMP16 08july2026
        // Position: Integer;//BC Upgrade SHARMP16 08july2026
        CCCDimenssionErr: Label 'PR %1 creation CCC code dimension cant be empty.';
        SimulateModeErr: Label 'Simulate Mode';
        VLContractforItem: Boolean;

    // BC Upgrade NANDIS03 >>
    // [EventSubscriber(ObjectType::Table, 50004, 'OnAfterInsertEvent', '', false, false)]
    [EventSubscriber(ObjectType::Table, Database::"Interface Log Header INT", 'OnAfterInsertEvent', '', false, false)]
    // BC Upgrade NANDIS03 <<
    local procedure T50004OnAfterInsert(var Rec: Record "Interface Log Header INT"; RunTrigger: Boolean);
    var
        Vendor: Record Vendor;
        Item: Record Item;
        InterfaceEntryCompDetail: Record "Interface Entry Comp.DetailINT";
    begin
        GetGeneralInterfaceSetup();
        if (not (Rec."Interface Code" in [GeneralInterfaceSetup."Material Interface",//HEI.08
                                         GeneralInterfaceSetup."Vendor Interface",//HEI.08
                                         GeneralInterfaceSetup."Vendors Global Interface",
                                         GeneralInterfaceSetup."Vend. Local Purch. Interface",
                                         GeneralInterfaceSetup."Vend. Local Finance Interface",
                                         GeneralInterfaceSetup."Items Global Interface",
                                         GeneralInterfaceSetup."Items Local Finance Interface",
                                         GeneralInterfaceSetup."Items Local Planning Interface",
                                         GeneralInterfaceSetup."Items Local Site Interface"])) or
          Rec."Delete Record"
        then
            exit;

        case Rec."Source Type" of
            DATABASE::Vendor:
                begin
                    if Rec."Source No." <> '' then begin
                        Vendor.GET(Rec."Source No.");
                        //HEI.04>>
                        if Vendor."Send To Maximo FND" then
                            //HEI.04<<
                            CreateVendorRequest(Vendor, false);
                    end else begin
                        InterfaceEntryCompDetail.SETRANGE("Header Entry No.", Rec."Interface Entry No.");
                        InterfaceEntryCompDetail.SETRANGE("Table ID", Rec."Source Type");
                        InterfaceEntryCompDetail.SETRANGE("Field ID", Vendor.FIELDNO("Global Vendor Number FND"));
                        if InterfaceEntryCompDetail.FINDFIRST() then begin
                            Vendor.SETRANGE("Global Vendor Number FND", InterfaceEntryCompDetail.Value);
                            Vendor.FINDFIRST();
                            //HEI.04>>
                            if Vendor."Send To Maximo FND" then
                                //HEI.04<<
                                CreateVendorRequest(Vendor, false);
                        end;
                    end;
                end;
            DATABASE::Item:
                begin
                    if Rec."Source No." <> '' then begin
                        Item.SETRANGE("No.", Rec."Source No.");
                        //HEI.05>>
                        // Item.SETFILTER("Item Category Code",GeneralInterfaceSetup."Maximo Item Category Filter");
                        if Item.FINDFIRST() then
                            //HE.25>>
                            //IF FindItemFilters(Item) THEN
                            if FindItemFilters(Item) then begin
                                //HEI.25<<
                                //HEI.05<<
                                CreateItemRequest(Item, false);
                                //HEI.25>>
                                CreateItemUOMRequest(Item, false);
                            end;
                        //HEI.25<<
                    end else begin
                        InterfaceEntryCompDetail.SETRANGE("Header Entry No.", Rec."Interface Entry No.");
                        InterfaceEntryCompDetail.SETRANGE("Table ID", Rec."Source Type");
                        InterfaceEntryCompDetail.SETRANGE("Field ID", Item.FIELDNO("No. 2"));
                        if InterfaceEntryCompDetail.FINDFIRST() then begin
                            Item.SETRANGE("No. 2", InterfaceEntryCompDetail.Value);
                            //HEI.05>>
                            // Item.SETFILTER("Item Category Code",GeneralInterfaceSetup."Maximo Item Category Filter");
                            if Item.FINDFIRST() then
                                //HEI.25>>
                                //IF FindItemFilters(Item) THEN
                                if FindItemFilters(Item) then begin
                                    //HEI.25<<
                                    //HEI.05<<
                                    CreateItemRequest(Item, false);
                                    //HEI.25>>
                                    CreateItemUOMRequest(Item, false);
                                end;
                            //HEI.25<<
                        end;
                    end;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 23, 'OnAfterDeleteEvent', '', false, false)]
    local procedure T23OnAfterDelete(var Rec: Record Vendor; RunTrigger: Boolean);
    begin
        if Rec.ISTEMPORARY then
            exit;

        CreateVendorRequest(Rec, true);
    end;

    [EventSubscriber(ObjectType::Table, 27, 'OnAfterDeleteEvent', '', false, false)]
    local procedure T27OnAfterDelete(var Rec: Record Item; RunTrigger: Boolean);
    var
        ItemCategory: Record "Item Category";
    begin
        if Rec.ISTEMPORARY then
            exit;

        GetGeneralInterfaceSetup();
        //HEI.05>>
        // ItemCategory.SETFILTER(Code,'%1&%2',GeneralInterfaceSetup."Maximo Item Category Filter",Rec."Item Category Code");
        //IF NOT ItemCategory.ISEMPTY THEN
        if FindItemFilters(Rec) then
            //HEI.05<<
            CreateItemRequest(Rec, true);
    end;

    procedure CreateVendorRequest(Vendor: Record Vendor; DeleteRecord: Boolean);
    var
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InterfaceSetup: Record "Interface Setup INT";
    begin
        //Maximo vendor request
        GetGLSetup();
        GetGeneralInterfaceSetup();
        GetCompanyInformation();

        InterfaceSetup.GET(GeneralInterfaceSetup."Maximo Vendor Interface");
        if not InterfaceSetup.Enabled then
            exit;

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderOut."Interface Code" := GeneralInterfaceSetup."Maximo Vendor Interface";
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
        InterfaceEntryHeaderOut."Buy-from Vendor No." := Vendor."No.";
        InterfaceEntryHeaderOut."Pay-to Vendor No." := Vendor."Pay-to Vendor No.";
        InterfaceEntryHeaderOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        InterfaceEntryHeaderOut."Source Type" := DATABASE::Vendor;
        InterfaceEntryHeaderOut."Source No." := Vendor."No." + '-' + CompanyInformation."Legal Entity Code FND";
        InterfaceEntryHeaderOut."Global No." := Vendor."Global Vendor Number FND";
        InterfaceEntryHeaderOut.Name := Vendor.Name;
        InterfaceEntryHeaderOut.Address := Vendor.Address;
        InterfaceEntryHeaderOut."Address 2" := Vendor."Address 2";
        InterfaceEntryHeaderOut."House Number" := Vendor."House Number FND";
        InterfaceEntryHeaderOut."House Number Supplement" := Vendor."House Number Supplement FND";
        InterfaceEntryHeaderOut."Post Code" := Vendor."Post Code";
        InterfaceEntryHeaderOut.City := Vendor.City;
        InterfaceEntryHeaderOut.County := Vendor.County;
        InterfaceEntryHeaderOut."Country/Region Code" := Vendor."Country/Region Code";
        //InterfaceEntryHeaderOut.Contact := Vendor.Contact;
        InterfaceEntryHeaderOut.Contact := Vendor."E-Mail";
        if Vendor."Currency Code" <> '' then
            InterfaceEntryHeaderOut."Currency Code" := Vendor."Currency Code"
        else
            InterfaceEntryHeaderOut."Currency Code" := GLSetup."LCY Code";
        if Vendor.Blocked <> Vendor.Blocked::" " then
            InterfaceEntryHeaderOut.Blocked := true;
        InterfaceEntryHeaderOut."Delete Record" := DeleteRecord;
        InterfaceEntryHeaderOut."Payment Terms Code" := Vendor."Payment Terms Code";
        InterfaceEntryHeaderOut."E-Mail" := Vendor."E-Mail";
        InterfaceEntryHeaderOut."Phone No." := Vendor."Phone No.";
        InterfaceEntryHeaderOut."Fax No." := Vendor."Fax No.";
        InterfaceEntryHeaderOut."Shipment Method" := Vendor."Shipment Method Code";
        InterfaceEntryHeaderOut.INSERT(true);
    end;

    procedure CreateItemRequest(Item: Record Item; DeleteRecord: Boolean);
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        Language: Record Language;
        ItemTranslation: Record "Item Translation";
        DefaultLanguageCode: Code[10];
        LineEntryNo: Integer;
        ItemRec: Record Item;
        ItemAttribueRec: Record "Item Attribute";
        ItemAttriValRec: Record "Item Attribute Value";
        ItemValMappRec: Record "Item Attribute Value Mapping";
        GeneralLedSetupRec: Record "General Ledger Setup";
        lStockkeepingUnit: Record "Stockkeeping Unit";
        lLocTemp: Record Location temporary;
        lLoc: Record Location;
        lZone: Record Zone;
    begin
        //Maximo item request
        GetGeneralInterfaceSetup();
        GetCompanyInformation();

        InterfaceSetup.GET(GeneralInterfaceSetup."Maximo Item Interface");
        if not InterfaceSetup.Enabled then
            exit;

        //HEI.21>>
        lLocTemp.RESET();
        lStockkeepingUnit.RESET();
        lStockkeepingUnit.SETCURRENTKEY("Item No.", "Location Code", "Variant Code");
        lStockkeepingUnit.SETRANGE("Item No.", Item."No.");
        if lStockkeepingUnit.findset(false) then
            repeat
                if lLoc.GET(lStockkeepingUnit."Location Code") then begin
                    lZone.RESET();
                    lZone.SETRANGE("Location Code", lLoc.Code);
                    lZone.SETRANGE("Use As Technical Zone FND", true);
                    if lZone.FINDFIRST() then begin
                        lLocTemp.RESET();
                        if not lLocTemp.GET(lLoc.Code) then begin
                            lLocTemp.TRANSFERFIELDS(lLoc);
                            if lLocTemp.INSERT() then;
                        end;
                        ;
                    end;
                end;
            until lStockkeepingUnit.NEXT() = 0;
        //HEI.21<<

        //HEI.21>>
        if lLocTemp.ISEMPTY then begin
            //HEI.21<<
            CLEAR(InterfaceEntryHeaderOut);
            InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
            InterfaceEntryHeaderOut."Interface Code" := GeneralInterfaceSetup."Maximo Item Interface";
            InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
            InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
            InterfaceEntryHeaderOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
            InterfaceEntryHeaderOut."Source Type" := DATABASE::Item;
            InterfaceEntryHeaderOut."Source No." := Item."No." + '-' + CompanyInformation."Legal Entity Code FND";
            InterfaceEntryHeaderOut.Description := Item."Description 2";
            InterfaceEntryHeaderOut.Blocked := Item.Blocked;
            InterfaceEntryHeaderOut."Delete Record" := DeleteRecord;
            //HEI.17 >>
            GeneralInterfaceSetup.RESET();
            ;
            GeneralInterfaceSetup.GET();
            GeneralInterfaceSetup.TESTFIELD("CMG Attribute ID");
            ItemValMappRec.RESET();
            ItemValMappRec.SETRANGE("No.", Item."No.");
            ItemValMappRec.SETRANGE("Item Attribute ID", GeneralInterfaceSetup."CMG Attribute ID");
            if ItemValMappRec.FINDFIRST() then begin
                ItemAttriValRec.RESET();
                ItemAttriValRec.SETRANGE("Attribute ID", GeneralInterfaceSetup."CMG Attribute ID");
                ItemAttriValRec.SETRANGE(ID, ItemValMappRec."Item Attribute Value ID");
                if ItemAttriValRec.FINDFIRST() then
                    InterfaceEntryHeaderOut."CMG Code" := ItemAttriValRec.Value;
            end;
            //HEi.17 <<
            //HEI.21>>
            InterfaceEntryHeaderOut."Location Code" := '';
            //HEI.21<<
            InterfaceEntryHeaderOut.INSERT(true);
            LineEntryNo := LineEntryNo + 1;
            if Language.GET(GeneralInterfaceSetup."Maximo Default Language Code") then
                DefaultLanguageCode := Language.Code;
            // CreateItemEntry(InterfaceEntryHeaderOut,Item,DeleteRecord,Language."ISO Language Text",Item."Description 2",LineEntryNo); // BC Upgrade BHARDA11 ----Drink-IT Field(Language."ISO Language Text")
            CreateItemEntry(InterfaceEntryHeaderOut, Item, DeleteRecord, Language."ISO Language Text1 FND", Item."Description 2", LineEntryNo);

            //HEI.21>>
            CLEAR(ItemTranslation);
            Language.RESET();
            Language.SETFILTER(Code, '<>%1', DefaultLanguageCode);
            Language.SETRANGE("Use In Maximo FND", true);
            if Language.findset() then
                repeat
                    ItemTranslation.SETRANGE("Item No.", Item."No.");
                    ItemTranslation.SETRANGE("Language Code", Language.Code);
                    if ItemTranslation.FINDFIRST() then begin
                        LineEntryNo := LineEntryNo + 1;
                        // CreateItemEntry(InterfaceEntryHeaderOut, Item, DeleteRecord, Language."ISO Language Text", ItemTranslation.Description, LineEntryNo);// BC Upgrade BHARDA11 ----Drink-IT Field(Language."ISO Language Text")
                        CreateItemEntry(InterfaceEntryHeaderOut, Item, DeleteRecord, Language."ISO Language Text1 FND", ItemTranslation.Description, LineEntryNo);// BC Upgrade BHARDA11 ----Drink-IT Field(Language."ISO Language Text")
                    end;
                until Language.NEXT() = 0;

        end;
        //HEI.21<<
        //HEI.21>>
        lLocTemp.RESET();
        if not lLocTemp.ISEMPTY then begin
            if lLocTemp.FINDFIRST() then
                repeat
                    CLEAR(InterfaceEntryHeaderOut);
                    InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
                    InterfaceEntryHeaderOut."Interface Code" := GeneralInterfaceSetup."Maximo Item Interface";
                    InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                    InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
                    InterfaceEntryHeaderOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
                    InterfaceEntryHeaderOut."Source Type" := DATABASE::Item;
                    InterfaceEntryHeaderOut."Source No." := Item."No." + '-' + CompanyInformation."Legal Entity Code FND";
                    InterfaceEntryHeaderOut.Description := Item."Description 2";
                    InterfaceEntryHeaderOut.Blocked := Item.Blocked;
                    InterfaceEntryHeaderOut."Delete Record" := DeleteRecord;
                    GeneralInterfaceSetup.RESET();
                    ;
                    GeneralInterfaceSetup.GET();
                    GeneralInterfaceSetup.TESTFIELD("CMG Attribute ID");
                    ItemValMappRec.RESET();
                    ItemValMappRec.SETRANGE("No.", Item."No.");
                    ItemValMappRec.SETRANGE("Item Attribute ID", GeneralInterfaceSetup."CMG Attribute ID");
                    if ItemValMappRec.FINDFIRST() then begin
                        ItemAttriValRec.RESET();
                        ItemAttriValRec.SETRANGE("Attribute ID", GeneralInterfaceSetup."CMG Attribute ID");
                        ItemAttriValRec.SETRANGE(ID, ItemValMappRec."Item Attribute Value ID");
                        if ItemAttriValRec.FINDFIRST() then
                            InterfaceEntryHeaderOut."CMG Code" := ItemAttriValRec.Value;
                    end;
                    InterfaceEntryHeaderOut."Location Code" := lLocTemp.Code;
                    InterfaceEntryHeaderOut.INSERT(true);
                    LineEntryNo := LineEntryNo + 1;
                    if Language.GET(GeneralInterfaceSetup."Maximo Default Language Code") then
                        DefaultLanguageCode := Language.Code;
                    // CreateItemEntry(InterfaceEntryHeaderOut, Item, DeleteRecord, Language."ISO Language Text", Item."Description 2", LineEntryNo); // BC Upgrade BHARDA11 ----Drink-IT Field(Language."ISO Language Text")
                    CreateItemEntry(InterfaceEntryHeaderOut, Item, DeleteRecord, Language."ISO Language Text1 FND", Item."Description 2", LineEntryNo); // BC Upgrade BHARDA11 ----Drink-IT Field(Language."ISO Language Text")

                    CLEAR(ItemTranslation);
                    Language.RESET();
                    Language.SETFILTER(Code, '<>%1', DefaultLanguageCode);
                    Language.SETRANGE("Use In Maximo FND", true);
                    if Language.findset() then
                        repeat
                            ItemTranslation.SETRANGE("Item No.", Item."No.");
                            ItemTranslation.SETRANGE("Language Code", Language.Code);
                            if ItemTranslation.FINDFIRST() then begin
                                LineEntryNo := LineEntryNo + 1;
                                CreateItemEntry(InterfaceEntryHeaderOut, Item, DeleteRecord, Language."ISO Language Text1 FND", ItemTranslation.Description, LineEntryNo); // BC Upgrade BHARDA11 ----Drink-IT Field(Language."ISO Language Text")
                            end;
                        until Language.NEXT() = 0;
                until lLocTemp.NEXT() = 0;
        end;
        //HEI.21<<

        //HEI.21>>
        /*
        CLEAR(ItemTranslation);
        Language.RESET;
        Language.SETFILTER(Code,'<>%1',DefaultLanguageCode);
        Language.SETRANGE("Use In Maximo FND",TRUE);
        IF Language.FINDSET THEN
          REPEAT
            ItemTranslation.SETRANGE("Item No.",Item."No.");
            ItemTranslation.SETRANGE("Language Code",Language.Code);
            IF ItemTranslation.FINDFIRST THEN BEGIN
              LineEntryNo := LineEntryNo + 1;
              CreateItemEntry(InterfaceEntryHeaderOut,Item,DeleteRecord,Language."ISO Language Text",ItemTranslation.Description,LineEntryNo);
            END;
          UNTIL Language.NEXT = 0;
        */
        //HEI.21<<

    end;

    local procedure CreateItemEntry(InterfaceEntryHeaderOut: Record "Interface Entry Header INT"; Item: Record Item; DeleteRecord: Boolean; LanguageCode: Code[10]; Description: Text; LineEntryNo: Integer);
    var
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        ItemTrackingCode: Record "Item Tracking Code";
    begin
        GetGeneralInterfaceSetup();
        GetCompanyInformation();

        CLEAR(InterfaceEntryLineOut);
        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
        InterfaceEntryLineOut."Entry No." := LineEntryNo;
        InterfaceEntryLineOut.Type := InterfaceEntryLineOut.Type::Item;
        InterfaceEntryLineOut."No." := Item."No.";
        InterfaceEntryLineOut."Global No." := Item."No. 2";
        InterfaceEntryLineOut."Language Code" := LanguageCode;
        InterfaceEntryLineOut.Description := Description;
        InterfaceEntryLineOut."Unit of Measure Code" := InterfaceFrameworkMgt.GetUnitOfMeasureCommercialISOCode(Item."Base Unit of Measure");
        InterfaceEntryLineOut."Purch. Unit of Measure" := InterfaceFrameworkMgt.GetUnitOfMeasureCommercialISOCode(Item."Purch. Unit of Measure");
        // InterfaceEntryLineOut."Auto Receive after Qlty. Test" := Item."Auto Receive after Qlty. Test"; // BC Upgrade BHARDA11 ----Drink-IT Field("Auto Receive after Qlty. Test")
        if ItemTrackingCode.GET(Item."Item Tracking Code") then
            InterfaceEntryLineOut."Item Tracking Code" := 'LOT'
        else
            InterfaceEntryLineOut."Item Tracking Code" := 'NOLOT';
        InterfaceEntryLineOut."Item Segmentation" := Item."Item Segmentation FND";
        InterfaceEntryLineOut."Certification Required" := Item."Certification Required FND";
        InterfaceEntryLineOut."Rotating Item" := Item."Rotating Item FND";
        InterfaceEntryLineOut."Machine Reference No." := Item."Machine Reference Number FND";
        InterfaceEntryLineOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        InterfaceEntryLineOut.Blocked := Item.Blocked;
        InterfaceEntryLineOut."Delete Record" := DeleteRecord;
        //HEi.17 >>
        InterfaceEntryLineOut."CMG Code" := InterfaceEntryHeaderOut."CMG Code";
        //HEI.17 <<
        //HEI.21>>
        InterfaceEntryLineOut."Location Code" := InterfaceEntryHeaderOut."Location Code";
        InterfaceEntryLineOut."E-Mail 2" := InterfaceEntryHeaderOut."Source No.";
        //HEI.21<<
        InterfaceEntryLineOut.INSERT(true);
    end;

    procedure ProcessPRCreation(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        PurchaseOrderLine: Record "Purchase Line";
        BlanketOrderLine: Record "Purchase Line";
        PurchaseLinePrice: Record "Purchase Line Price FND";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        Vendor: Record Vendor;
        Item: Record Item;
        TempPurchHeader: Record "Purchase Header" temporary;
        PurchLineNo: Integer;
        NextLineNo: Integer;
        lApprovalEntry: Record "Approval Entry";
        UserFromInterface: Text;
        // DomainName: Text;//BC Upgrade SHARMP16 08july2026
        // Position: Integer;//BC Upgrade SHARMP16 08july2026
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        lItem: Record Item;
        lCMGMapping: Record "CMG Mapping FND";
        lText50000: Label 'Dimension Value Code %1 is defined more than once in CMG Mappings!';
        lComposedGLAcc: Code[20];
        lGeneralInterfaceSetup: Record "General Interface Setup INT";
        lText50001: Label 'Field %1 is not setup in table %2!';
        lText50002: Label 'Dimension Value Code %1 or Item %1 does not exist!';
        lGLAccount: Record "G/L Account";
        lText50003: Label 'GL Account %1 does not exist!';
        PurchaseHeaderRec_Max: Record "Purchase Header";
        ArchiveManagement: Codeunit ArchiveManagement;
        ReleasePurchDoc: Codeunit "Release Purchase Document";
        BlanketOrderHdr: Record "Purchase Header";
        lDefDimension: Record "Default Dimension";
        StoreItemDim: Code[20];
        LineNo: Integer;
        lBlanketPurchOrdLines: Record "Purchase Line";
        lPurchBlankOrderLn: Record "Purchase Line";
        lPurchBlankOrderHdr: Record "Purchase Header";
        UpdateBlanketOdLn: Record "Purchase Line";
        HenekenBcCustomFun: Codeunit "Heineken BC Custom Functions"; // BC Upgrade BHARDA11 
    begin
        //Maximo PR to NAV PQ
        GetGeneralInterfaceSetup();
        GetGLSetup();

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.findset() then
            repeat
                if not Vendor.GET(GetNoFromMaximoNo(InterfaceEntryLine."Buy-from Vendor No.")) then
                    Vendor.GET(GeneralInterfaceSetup."Maximo Default PR Vendor No.");

                PurchaseOrderLine.SETRANGE("Document Type", PurchaseOrderLine."Document Type"::Order);
                PurchaseOrderLine.SETRANGE("Maximo Requisition No. FND", InterfaceEntryHeader."External Requisition No.");
                PurchaseOrderLine.SETRANGE("Maximo Requis. Line No. FND", InterfaceEntryLine."External Requisition Line No.");
                if PurchaseOrderLine.FINDFIRST() then
                    ERROR(POAlreadyCreatedForPRErr, InterfaceEntryHeader."External Requisition No.",
                                                   InterfaceEntryLine."External Requisition Line No.",
                                                   PurchaseOrderLine."Document No.");
                //HEI.15 >>
                PurchaseHeaderRec_Max.RESET();
                PurchaseHeaderRec_Max.SETRANGE("Document Type", InterfaceEntryHeader."Source Subtype");
                PurchaseHeaderRec_Max.SETRANGE("Maximo Requisition No. FND", InterfaceEntryHeader."External Requisition No.");
                PurchaseHeaderRec_Max.SETRANGE("Buy-from Vendor No.", Vendor."No.");
                if PurchaseHeaderRec_Max.FINDFIRST() then begin
                    if PurchaseHeaderRec_Max.Status = PurchaseHeaderRec_Max.Status::Released then begin
                        // ArchiveManagement.ArchivePurchDocumentOnReopen(PurchaseHeaderRec_Max); // BC Upgrade BHARDA11 ::Blocked
                        HenekenBcCustomFun.ArchivePurchDocumentOnReopen(PurchaseHeaderRec_Max); // BC Upgrade BHARDA11 ::Added
                        // ReleasePurchDoc.DocStatusOpen(PurchaseHeaderRec_Max, PurchaseHeaderRec_Max); // BC Upgrade BHARDA11 ----Drink-IT Function(DocStatusOpen)
                        if InterfaceEntryHeader."Maximo Status" = InterfaceEntryHeader."Maximo Status"::Canceled then begin
                            ArchiveManagement.AutoArchivePurchDocument(PurchaseHeaderRec_Max);
                            PurchaseHeaderRec_Max.DELETE();
                            exit;
                        end;
                    end;
                end; //ELSE
                     //    EXIT;

                //HEI.15 <<

                //HEI.33>>
                VLContractforItem := false;
                StoreItemDim := '';
                //HEI.33<<
                PurchaseHeader.RESET();
                PurchaseHeader.SETRANGE("Document Type", InterfaceEntryHeader."Source Subtype");
                PurchaseHeader.SETRANGE("Maximo Requisition No. FND", InterfaceEntryHeader."External Requisition No.");
                PurchaseHeader.SETRANGE("Buy-from Vendor No.", Vendor."No.");
                CLEAR(BlanketOrderLine);
                BlanketOrderLine.SETRANGE("Document Type", BlanketOrderLine."Document Type"::"Blanket Order");
                BlanketOrderLine.SETRANGE("Buy-from Vendor No.", Vendor."No.");
                //HEI.16>>
                /*
                BlanketOrderLine.SETRANGE(Type,InterfaceEntryLine.Type);
                BlanketOrderLine.SETRANGE("No.",GetNoFromMaximoNo(InterfaceEntryLine."No."));
                */
                lComposedGLAcc := '';
                lItem.RESET();
                if lItem.GET(GetNoFromMaximoNo(InterfaceEntryLine."No.")) then begin
                    BlanketOrderLine.SETRANGE(Type, InterfaceEntryLine.Type);
                    BlanketOrderLine.SETRANGE("No.", GetNoFromMaximoNo(InterfaceEntryLine."No."));
                    //HEI.33>>
                    lDefDimension.RESET();
                    if lDefDimension.GET(DATABASE::Item, lItem."No.", GLSetup."Shortcut Dimension 5 Code") then
                        StoreItemDim := lDefDimension."Dimension Value Code";
                    //HEI.33<<
                end else begin
                    lGeneralInterfaceSetup.GET();
                    if lGeneralInterfaceSetup.Services = '' then
                        ERROR(lText50001, lGeneralInterfaceSetup.FIELDCAPTION(Services), lGeneralInterfaceSetup.TABLECAPTION);

                    lGeneralInterfaceSetup.GET();
                    lCMGMapping.RESET();
                    lCMGMapping.SETRANGE("Dimension Value Code", GetNoFromMaximoNo(InterfaceEntryLine."No."));
                    if lCMGMapping.FINDFIRST() then begin
                        if lCMGMapping.COUNT > 1 then
                            ERROR(lText50000, lCMGMapping."Dimension Value Code");
                        if not lGLAccount.GET(lCMGMapping."CIL3 Code" + lGeneralInterfaceSetup.Services) then
                            ERROR(lText50003, lCMGMapping."CIL3 Code" + lGeneralInterfaceSetup.Services);
                        BlanketOrderLine.SETRANGE(Type, BlanketOrderLine.Type::"G/L Account");
                        BlanketOrderLine.SETRANGE("No.", lCMGMapping."CIL3 Code" + lGeneralInterfaceSetup.Services);
                        //HEI.33>>
                        BlanketOrderLine.SETRANGE("CMG Code FND", GetNoFromMaximoNo(InterfaceEntryLine."No."));
                        //HEI.33<<
                        lComposedGLAcc := lCMGMapping."CIL3 Code" + lGeneralInterfaceSetup.Services;
                    end else
                        ERROR(lText50002, GetNoFromMaximoNo(InterfaceEntryLine."No."));
                end;
                //HEI.16<<
                BlanketOrderLine.SETRANGE("Block Line Ordering FND", BlanketOrderLine."Block Line Ordering FND"::" ");
                BlanketOrderLine.SETRANGE("Delivery Finalized FND", false);
                BlanketOrderLine.SETRANGE("Currency Code", Vendor."Currency Code");
                BlanketOrderLine.CALCFIELDS("Valid From FND", "Valid To FND");
                BlanketOrderLine.SETFILTER("Valid From FND", '<=%1', InterfaceEntryHeader."Document Date");
                BlanketOrderLine.SETFILTER("Valid To FND", '%1|>=%2', 0D, InterfaceEntryHeader."Document Date");
                if BlanketOrderLine.COUNT = 1 then begin
                    BlanketOrderLine.FINDFIRST();
                    //HEI.33>>
                    //HEI.37>>
                    //IF BlanketOrderHdr.GET(BlanketOrderLine."Document Type"::"Blanket Order",BlanketOrderLine."Document No.") THEN;
                    if BlanketOrderHdr.GET(BlanketOrderLine."Document Type"::"Blanket Order", BlanketOrderLine."Document No.") then
                        //HEI.40>>
                        //IF NOT BlanketOrderHdr.Closed THEN
                        if not BlanketOrderHdr."Closed FND" then begin
                            //HEI.40<<
                            //HEI.37<<
                            //HEI.33<<
                            if not PurchaseLinePrice.BlanketOrderPriceExists(BlanketOrderLine) then
                                //HEI.33>>
                                if BlanketOrderHdr."Channel FND" <> 'D' then
                                    //HEI.33<<
                                    CLEAR(BlanketOrderLine);
                            //HEI.40>>
                        end else
                            CLEAR(BlanketOrderLine);
                    //HEI.40<<
                    //HEI.33>>
                    //END;
                end else begin
                    if BlanketOrderLine.COUNT > 1 then begin
                        BlanketOrderLine.SETCURRENTKEY(BlanketOrderLine."Valid To FND");
                        BlanketOrderLine.ASCENDING;
                        BlanketOrderLine.FINDFIRST();
                        //HEI.37>>
                        //IF BlanketOrderHdr.GET(BlanketOrderLine."Document Type"::"Blanket Order",BlanketOrderLine."Document No.") THEN;
                        if BlanketOrderHdr.GET(BlanketOrderLine."Document Type"::"Blanket Order", BlanketOrderLine."Document No.") then
                            //HEI.40>>
                            //IF NOT BlanketOrderHdr.Closed THEN
                            if not BlanketOrderHdr."Closed FND" then begin
                                //HEI.40<<
                                //HEI.37<<
                                if not PurchaseLinePrice.BlanketOrderPriceExists(BlanketOrderLine) then
                                    if BlanketOrderHdr."Channel FND" <> 'D' then
                                        CLEAR(BlanketOrderLine);
                                //HEI.40>>
                            end else
                                CLEAR(BlanketOrderLine);
                        //HEI.40<<
                    end;
                    //To connect VL Contract with Item's CMG
                    if (BlanketOrderLine.COUNT = 0) and (StoreItemDim <> '') then begin
                        lGeneralInterfaceSetup.GET();
                        if lGeneralInterfaceSetup.Services = '' then
                            ERROR(lText50001, lGeneralInterfaceSetup.FIELDCAPTION(Services), lGeneralInterfaceSetup.TABLECAPTION);

                        BlanketOrderLine.RESET();
                        BlanketOrderLine.SETCURRENTKEY(BlanketOrderLine."Valid To FND");
                        BlanketOrderLine.ASCENDING;
                        BlanketOrderLine.SETRANGE("Document Type", BlanketOrderLine."Document Type"::"Blanket Order");
                        BlanketOrderLine.SETRANGE("Buy-from Vendor No.", Vendor."No.");
                        BlanketOrderLine.SETRANGE(Type, BlanketOrderLine.Type::"G/L Account");
                        BlanketOrderLine.SETRANGE("CMG Code FND", StoreItemDim);
                        BlanketOrderLine.SETRANGE("Block Line Ordering FND", BlanketOrderLine."Block Line Ordering FND"::" ");
                        BlanketOrderLine.SETRANGE("Delivery Finalized FND", false);
                        BlanketOrderLine.SETRANGE("Currency Code", Vendor."Currency Code");
                        BlanketOrderLine.CALCFIELDS("Valid From FND", "Valid To FND");
                        BlanketOrderLine.SETFILTER("Valid From FND", '<=%1', InterfaceEntryHeader."Document Date");
                        BlanketOrderLine.SETFILTER("Valid To FND", '%1|>=%2', 0D, InterfaceEntryHeader."Document Date");
                        if BlanketOrderLine.FINDFIRST() then begin
                            //HEI.37>>
                            //IF BlanketOrderHdr.GET(BlanketOrderLine."Document Type"::"Blanket Order",BlanketOrderLine."Document No.") THEN;
                            if BlanketOrderHdr.GET(BlanketOrderLine."Document Type"::"Blanket Order", BlanketOrderLine."Document No.") then
                                //HEI.40>>
                                //IF NOT BlanketOrderHdr.Closed THEN
                                if not BlanketOrderHdr."Closed FND" then begin
                                    //HEI.40<<
                                    //HEI.37<<
                                    if not PurchaseLinePrice.BlanketOrderPriceExists(BlanketOrderLine) then
                                        if BlanketOrderHdr."Channel FND" <> 'D' then
                                            CLEAR(BlanketOrderLine);
                                    VLContractforItem := true;
                                    //HEI.40>>
                                end else
                                    CLEAR(BlanketOrderLine);
                            //HEI.40<<
                        end;
                    end;
                    //To connect VL Contract with Item's CMG
                    //Add line in PBO
                    if VLContractforItem then begin
                        LineNo := 0;
                        lBlanketPurchOrdLines.RESET();
                        lBlanketPurchOrdLines.SETRANGE("Document Type", lBlanketPurchOrdLines."Document Type"::"Blanket Order");
                        lBlanketPurchOrdLines.SETRANGE("Document No.", BlanketOrderLine."Document No.");
                        if lBlanketPurchOrdLines.FINDLAST() then
                            LineNo := lBlanketPurchOrdLines."Line No." + 10000;

                        lBlanketPurchOrdLines.RESET();
                        lBlanketPurchOrdLines.TRANSFERFIELDS(BlanketOrderLine);
                        lBlanketPurchOrdLines."Line No." := LineNo;
                        lBlanketPurchOrdLines.Type := lBlanketPurchOrdLines.Type::Item;
                        lBlanketPurchOrdLines."No." := lItem."No.";
                        lBlanketPurchOrdLines."Direct Unit Cost" := 0;
                        lBlanketPurchOrdLines."Initial Quantity FND" := InterfaceEntryLine.Quantity;
                        lBlanketPurchOrdLines.Quantity := InterfaceEntryLine.Quantity + lBlanketPurchOrdLines.Quantity;
                        if lBlanketPurchOrdLines.INSERT() then;
                        //HEI.40>>
                        //END;
                    end else
                        CLEAR(BlanketOrderLine);
                    //HEI.40<<
                end;
                //HEI.33<<
                PurchaseHeader.SETRANGE("Blanket Order No. FND", BlanketOrderLine."Document No.");
                if not PurchaseHeader.FINDFIRST() then begin
                    CLEAR(PurchaseHeader);
                    if not GUIALLOWED then
                        PurchaseHeader.SetHideValidationDialog(true);
                    PurchaseHeader.VALIDATE("Document Type", InterfaceEntryHeader."Source Subtype");
                    PurchaseHeader.INSERT(true);
                    PurchaseHeader.VALIDATE("Buy-from Vendor No.", Vendor."No.");
                    PurchaseHeader.VALIDATE("Document Date", InterfaceEntryHeader."Document Date");
                    PurchaseHeader.VALIDATE("Order Date", InterfaceEntryHeader."Document Date");
                    PurchaseHeader.VALIDATE("Location Code", InterfaceEntryLine."Location Code"); //HEI.24
                    if InterfaceEntryHeader."Currency Code" <> '' then
                        if InterfaceEntryHeader."Currency Code" <> GLSetup."LCY Code" then
                            PurchaseHeader.VALIDATE("Currency Code", InterfaceEntryHeader."Currency Code");
                    PurchaseHeader.VALIDATE("Maximo Requisition No. FND", InterfaceEntryHeader."External Requisition No.");
                    if BlanketOrderLine."Document No." <> '' then
                        PurchaseHeader.VALIDATE("Blanket Order No. FND", BlanketOrderLine."Document No.");
                    if (InterfaceEntryHeader."Requested Receipt Date" <> 0D) and (InterfaceEntryHeader."Requested Receipt Date" <> 20010101D) then
                        PurchaseHeader.VALIDATE("Requested Receipt Date", InterfaceEntryHeader."Requested Receipt Date");
                    if (InterfaceEntryLine."Expected Receipt Date" <> 0D) and
                       (InterfaceEntryLine."Expected Receipt Date" <> 20010101D) and
                       (PurchaseHeader."Expected Receipt Date" = 0D)
                    then
                        PurchaseHeader.VALIDATE("Expected Receipt Date", InterfaceEntryLine."Expected Receipt Date");
                    //HEI.09>>
                    UserFromInterface := InterfaceEntryHeader."External Contract Name";
                    // DomainName := 'HEIWAY\';
                    // Position := STRPOS(UserFromInterface, DomainName);//BC Upgrade SHARMP16 08july2026
                    //HEI.12>>
                    //IF PurchaseHeaderAdditional.GET(PurchaseHeader."Document Type",PurchaseHeader."No.") THEN

                    if PurchaseHeaderAdditional.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") then begin//HEI.15
                                                                                                                    // if Position = 0 then
                                                                                                                    //     //PurchaseHeader.VALIDATE("Payment User",DomainName + InterfaceEntryHeader."External Contract Name")
                                                                                                                    //     PurchaseHeaderAdditional.VALIDATE("PQ Approver", DomainName + InterfaceEntryHeader."External Contract Name")
                                                                                                                    // else//BC Upgrade SHARMP16 08july2026
                                                                                                                    //PurchaseHeader.VALIDATE("Payment User",InterfaceEntryHeader."External Contract Name");
                        PurchaseHeaderAdditional.VALIDATE("PQ Approver", InterfaceEntryHeader."External Contract Name");
                        //HEI.15 >>
                        PurchaseHeaderAdditional.VALIDATE("Maximo Status INT", InterfaceEntryHeader."Maximo Status");
                        //HEI.15 <<
                        PurchaseHeaderAdditional.MODIFY(true);
                        //HEI.12>>
                        //HEI.09<<
                        PurchaseHeader.MODIFY(true);
                    end else //HEI.15 >>
                        exit; //HEI.15 >>

                    CLEAR(TempPurchHeader);
                    TempPurchHeader := PurchaseHeader;
                    TempPurchHeader.INSERT();
                end;

                PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
                if PurchaseLine.FINDLAST() then
                    PurchLineNo := PurchaseLine."Line No.";
                PurchaseLine.SETRANGE("Maximo Requis. Line No. FND", InterfaceEntryLine."External Requisition Line No.");
                if not PurchaseLine.FINDFIRST() then begin
                    CLEAR(PurchaseLine);
                    if not GUIALLOWED then
                        // PurchaseLine.SetHideValidationDialog(true); // BC Upgrade BHARDA11 ----Drink-IT Function(SetHideValidationDialog)

                        PurchaseLine.VALIDATE("Document Type", PurchaseHeader."Document Type");
                    PurchaseLine.VALIDATE("Document No.", PurchaseHeader."No.");
                    PurchLineNo := PurchLineNo + 10000;
                    PurchaseLine."Line No." := PurchLineNo;
                    if InterfaceEntryLine."No." <> '' then begin
                        //HEI.16>>
                        /*
                        PurchaseLine.VALIDATE(Type,InterfaceEntryLine.Type);
                        Item.GET(GetNoFromMaximoNo(InterfaceEntryLine."No."));
                        PurchaseLine.VALIDATE("No.",Item."No.");
                        */
                        lItem.RESET();
                        if lItem.GET(GetNoFromMaximoNo(InterfaceEntryLine."No.")) then begin
                            PurchaseLine.VALIDATE(Type, InterfaceEntryLine.Type);
                            Item.GET(GetNoFromMaximoNo(InterfaceEntryLine."No."));
                            PurchaseLine.VALIDATE("No.", Item."No.");
                        end else begin
                            PurchaseLine.VALIDATE(Type, PurchaseLine.Type::"G/L Account");
                            PurchaseLine.VALIDATE("No.", lComposedGLAcc);
                            PurchaseLine.VALIDATE("CMG Code FND", InterfaceEntryLine."No."); //HEI.24
                            PurchaseLine.ValidateShortcutDimCode(5, InterfaceEntryLine."No."); //HEI.24
                        end;
                        //HEI.16<<
                    end;
                    PurchaseLine.Description := InterfaceEntryLine.Description;
                    PurchaseLine."Description 2" := InterfaceEntryLine."Description 2";
                    PurchaseLine.VALIDATE("Location Code", InterfaceEntryLine."Location Code");
                    if InterfaceEntryLine."Unit of Measure Code" <> '' then
                        PurchaseLine.VALIDATE("Unit of Measure Code", InterfaceFrameworkMgt.GetCommercialISOCodeUnitOfMeasure(InterfaceEntryLine."Unit of Measure Code"));
                    PurchaseLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                    //HEI.33>>
                    //Increase Qty in Contract if its Channel D with item
                    if VLContractforItem then begin
                        if lPurchBlankOrderLn.GET(BlanketOrderLine."Document Type"::"Blanket Order", BlanketOrderLine."Document No.", BlanketOrderLine."Line No.") then begin
                            if (lPurchBlankOrderLn.Type = lPurchBlankOrderLn.Type::Item) then
                                if lPurchBlankOrderHdr.GET(lPurchBlankOrderLn."Document Type", lPurchBlankOrderLn."Document No.") then
                                    if (lPurchBlankOrderHdr."Channel FND" = 'D') then begin
                                        lPurchBlankOrderLn.Quantity += InterfaceEntryLine.Quantity;
                                        lPurchBlankOrderLn.VALIDATE(Quantity);
                                        lPurchBlankOrderLn.MODIFY();
                                    end;
                        end;
                    end;
                    //HEI.33<<
                    PurchaseLine.VALIDATE("Direct Unit Cost", InterfaceEntryLine."Unit Amount");
                    //>> HEI.18
                    if InterfaceEntryLine."Machine Reference No." <> '' then
                        PurchaseLine.VALIDATE("Machine Reference Number FND", InterfaceEntryLine."Machine Reference No.");
                    //<< HEI.18
                    //HEI.11>>
                    if InterfaceEntryLine."Shortcut Dimension 2 Code" = '' then
                        ERROR(CCCDimenssionErr, PurchaseHeader."No.");
                    //HEI.11>>
                    PurchaseLine.VALIDATE("Shortcut Dimension 1 Code", InterfaceEntryLine."Shortcut Dimension 1 Code");
                    PurchaseLine.VALIDATE("Shortcut Dimension 2 Code", InterfaceEntryLine."Shortcut Dimension 2 Code");
                    PurchaseLine.VALIDATE("Maximo Requisition No. FND", InterfaceEntryHeader."External Requisition No.");
                    PurchaseLine.VALIDATE("Maximo Requis. Line No. FND", InterfaceEntryLine."External Requisition Line No.");
                    if BlanketOrderLine."Document No." <> '' then begin
                        PurchaseLine."Blanket Order No." := BlanketOrderLine."Document No.";
                        PurchaseLine.VALIDATE("Blanket Order Line No.", BlanketOrderLine."Line No.");
                        //HEI.42>>
                        if (PurchaseLine."Blanket Order Line No." <> 0) then begin
                            if UpdateBlanketOdLn.GET(UpdateBlanketOdLn."Document Type"::"Blanket Order", BlanketOrderLine."Document No.", BlanketOrderLine."Line No.") then begin
                                UpdateBlanketOdLn.VALIDATE(Quantity, UpdateBlanketOdLn.Quantity + InterfaceEntryLine.Quantity);
                                UpdateBlanketOdLn.MODIFY();
                            end;
                        end;
                        //HEI.42<<
                        //HEI.33>
                        //HEI.36>>
                        //IF VLContractforItem OR (PurchaseLine."Direct Unit Cost" = 0) THEN
                        //  PurchaseLine."Direct Unit Cost" := InterfaceEntryLine."Unit Amount";
                        if VLContractforItem or (PurchaseLine."Direct Unit Cost" = 0) then begin
                            PurchaseLine."Direct Unit Cost" := InterfaceEntryLine."Unit Amount";
                            if (PurchaseLine."Direct Unit Cost" = 0) then
                                if Item.GET(PurchaseLine."No.") then
                                    PurchaseLine."Direct Unit Cost" := Item."Unit Cost";
                        end;
                        //HEI.36<<
                        //HEI.33<<
                    end;
                    //HEI.02>>
                    if (InterfaceEntryLine."Requested Receipt Date" <> 0D) and (InterfaceEntryLine."Requested Receipt Date" <> 20010101D) then
                        PurchaseLine.VALIDATE("Requested Receipt Date", InterfaceEntryLine."Requested Receipt Date");
                    if (InterfaceEntryLine."Expected Receipt Date" <> 0D) and (InterfaceEntryLine."Expected Receipt Date" <> 20010101D) then
                        PurchaseLine.VALIDATE("Expected Receipt Date", InterfaceEntryLine."Expected Receipt Date");
                    PurchaseLine.VALIDATE("Zone Code FND", InterfaceEntryLine."Zone Code");
                    //HEI.02<<

                    // BC Upgrade PATELS08 >> Added code
                    // HEI.49 >>
                    IF (PurchaseLine."Direct Unit Cost" <> 0) THEN BEGIN
                        // BC Upgrade PATELS08 >> Blocked as dependency on DIT field
                        // PurchaseLine."Item Charge Value" := PurchaseLine."Direct Unit Cost";
                        // BC Upgrade PATELS08 <<
                        PurchaseLine.VALIDATE("Direct Unit Cost");
                    END;
                    // HEI.49 <<
                    // BC Upgrade PATELS08 <<

                    PurchaseLine.INSERT(true);
                end else begin
                    if not GUIALLOWED then;
                    // PurchaseLine.SetHideValidationDialog(true); // BC Upgrade BHARDA11 ----Drink-IT Fuction(SetHideValidationDialog)
                    if InterfaceEntryLine."No." <> '' then begin
                        //HEI.16>>
                        /*
                        PurchaseLine.VALIDATE(Type,InterfaceEntryLine.Type);
                        Item.GET(GetNoFromMaximoNo(InterfaceEntryLine."No."));
                        PurchaseLine.VALIDATE("No.",Item."No.");
                        */
                        lItem.RESET();
                        if lItem.GET(GetNoFromMaximoNo(InterfaceEntryLine."No.")) then begin
                            PurchaseLine.VALIDATE(Type, InterfaceEntryLine.Type);
                            Item.GET(GetNoFromMaximoNo(InterfaceEntryLine."No."));
                            PurchaseLine.VALIDATE("No.", Item."No.");
                        end
                        else begin
                            PurchaseLine.VALIDATE(Type, PurchaseLine.Type::"G/L Account");
                            PurchaseLine.VALIDATE("No.", lComposedGLAcc);
                            PurchaseLine.VALIDATE("CMG Code FND", InterfaceEntryLine."No."); //HEI.24
                            PurchaseLine.ValidateShortcutDimCode(5, InterfaceEntryLine."No."); //HEI.24
                        end;
                        //HEI.16<<
                    end;
                    PurchaseLine.Description := InterfaceEntryLine.Description;
                    PurchaseLine."Description 2" := InterfaceEntryLine."Description 2";
                    PurchaseLine.VALIDATE("Location Code", InterfaceEntryLine."Location Code");
                    if InterfaceEntryLine."Unit of Measure Code" <> '' then
                        PurchaseLine.VALIDATE("Unit of Measure Code", InterfaceFrameworkMgt.GetCommercialISOCodeUnitOfMeasure(InterfaceEntryLine."Unit of Measure Code"));
                    PurchaseLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                    PurchaseLine.VALIDATE("Direct Unit Cost", InterfaceEntryLine."Unit Amount");
                    PurchaseLine.VALIDATE("Shortcut Dimension 1 Code", InterfaceEntryLine."Shortcut Dimension 1 Code");
                    PurchaseLine.VALIDATE("Shortcut Dimension 2 Code", InterfaceEntryLine."Shortcut Dimension 2 Code");
                    PurchaseLine.VALIDATE("Maximo Requisition No. FND", InterfaceEntryHeader."External Requisition No.");
                    PurchaseLine.VALIDATE("Maximo Requis. Line No. FND", InterfaceEntryLine."External Requisition Line No.");
                    //HEI.02>>
                    if (InterfaceEntryLine."Requested Receipt Date" <> 0D) and (InterfaceEntryLine."Requested Receipt Date" <> 20010101D) then
                        PurchaseLine.VALIDATE("Requested Receipt Date", InterfaceEntryLine."Requested Receipt Date");
                    if (InterfaceEntryLine."Expected Receipt Date" <> 0D) and (InterfaceEntryLine."Expected Receipt Date" <> 20010101D) then
                        PurchaseLine.VALIDATE("Expected Receipt Date", InterfaceEntryLine."Expected Receipt Date");
                    PurchaseLine.VALIDATE("Zone Code FND", InterfaceEntryLine."Zone Code");
                    //HEI.02<<
                    //>> HEI.18
                    if InterfaceEntryLine."Machine Reference No." <> '' then
                        PurchaseLine.VALIDATE("Machine Reference Number FND", InterfaceEntryLine."Machine Reference No.");
                    //<< HEI.18

                    // BC Upgrade PATELS08 >> Added code
                    // HEI.49 >>
                    IF (PurchaseLine."Direct Unit Cost" <> 0) THEN BEGIN
                        // BC Upgrade PATELS08 >> Blocked as dependency on DIT field
                        // PurchaseLine."Item Charge Value" := PurchaseLine."Direct Unit Cost"; 
                        // BC Upgrade PATELS08 <<
                        PurchaseLine.VALIDATE("Direct Unit Cost");
                    END;
                    // HEI.49 <<
                    // BC Upgrade PATELS08 <<

                    PurchaseLine.MODIFY(true);
                end;
            until InterfaceEntryLine.NEXT() = 0;

        TempPurchHeader.RESET();
        if TempPurchHeader.findset() then
            repeat
                PurchaseHeader.GET(TempPurchHeader."Document Type", TempPurchHeader."No.");
                if TempPurchHeader."Blanket Order No. FND" <> '' then
                    CODEUNIT.RUN(CODEUNIT::"Purch.-Quote to Order", PurchaseHeader)
                else
                    CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeader);
            until TempPurchHeader.NEXT() = 0;

    end;

    [EventSubscriber(ObjectType::Codeunit, 415, 'OnAfterReleasePurchaseDoc', '', false, false)]
    local procedure OnAfterReleasePurchOrder(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean);
    begin
        if PreviewMode or
           (PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order) or
           (PurchaseHeader."Maximo Requisition No. FND" = '')
        then
            exit;

        CreatePORequest(PurchaseHeader, false, 0);
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure T39OnBeforeDelete(var Rec: Record "Purchase Line"; RunTrigger: Boolean);
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        if (Rec."Document Type" <> Rec."Document Type"::Order) or
           (Rec."Maximo Requisition No. FND" = '') or
           Rec.ISTEMPORARY
        then
            exit;

        PurchaseHeader.GET(Rec."Document Type", Rec."Document No.");
        if PurchaseHeader.Status = PurchaseHeader.Status::Released then
            CreatePORequest(PurchaseHeader, true, Rec."Line No.");
    end;

    local procedure CreatePORequest(PurchaseHeader: Record "Purchase Header"; DeleteRecord: Boolean; LineNoToDelete: Integer);
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        PurchaseLine: Record "Purchase Line";
        Vendor: Record Vendor;
        Item: Record Item;
        NextEntryNo: Integer;
        lGLAcc: Record "G/L Account";
        lCMGMapping: Record "CMG Mapping FND";
        lText50000: Label 'G/L Account %1 is defined more than once in CMG Mappings!';
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        //PO for Maximo
        GetGeneralInterfaceSetup();
        GetGLSetup();
        GetCompanyInformation();

        InterfaceSetup.GET(GeneralInterfaceSetup."Maximo PO Interface");
        if not InterfaceSetup.Enabled then
            exit;

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderOut."Interface Code" := GeneralInterfaceSetup."Maximo PO Interface";
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
        InterfaceEntryHeaderOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        InterfaceEntryHeaderOut."External Requisition No." := PurchaseHeader."Maximo Requisition No. FND";
        InterfaceEntryHeaderOut."Source Type" := DATABASE::"Purchase Line";
        InterfaceEntryHeaderOut."Source No." := PurchaseHeader."No.";
        InterfaceEntryHeaderOut."Document Date" := PurchaseHeader."Document Date";
        Vendor.GET(PurchaseHeader."Buy-from Vendor No.");
        InterfaceEntryHeaderOut."Buy-from Vendor No." := Vendor."No." + '-' + CompanyInformation."Legal Entity Code FND";
        if PurchaseHeader."Currency Code" <> '' then
            InterfaceEntryHeaderOut."Currency Code" := PurchaseHeader."Currency Code"
        else
            InterfaceEntryHeaderOut."Currency Code" := GLSetup."LCY Code";
        PurchaseHeader.CALCFIELDS(Amount, "Amount Including VAT");
        InterfaceEntryHeaderOut.Amount := PurchaseHeader.Amount;
        InterfaceEntryHeaderOut."VAT Amount" := PurchaseHeader."Amount Including VAT" - PurchaseHeader.Amount;
        InterfaceEntryHeaderOut."Amount Including VAT" := PurchaseHeader."Amount Including VAT";
        InterfaceEntryHeaderOut."Requested Receipt Date" := PurchaseHeader."Requested Receipt Date";
        InterfaceEntryHeaderOut."Expected Receipt Date" := PurchaseHeader."Expected Receipt Date";
        InterfaceEntryHeaderOut."Source Status" := PurchaseHeader.Status.AsInteger();
        InterfaceEntryHeaderOut."Your Reference" := PurchaseHeader."Your Reference";
        //>> HEI.26
        if PurchaseHeaderAdditional.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") then begin
            InterfaceEntryHeaderOut."Simulation Done" := PurchaseHeaderAdditional."Import Identifier";
            InterfaceEntryHeaderOut."Location Code" := PurchaseHeader."Shipment Method Code";
        end;
        InterfaceEntryHeaderOut."Global No." := PurchaseHeader."Location Code";
        //<< HEI.26
        if LineNoToDelete = 0 then
            InterfaceEntryHeaderOut."Delete Record" := DeleteRecord;
        InterfaceEntryHeaderOut.INSERT(true);

        PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
        if LineNoToDelete <> 0 then
            PurchaseLine.SETRANGE("Line No.", LineNoToDelete);
        if PurchaseLine.findset() then
            repeat
                CLEAR(InterfaceEntryLineOut);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                NextEntryNo := NextEntryNo + 1;
                InterfaceEntryLineOut."Entry No." := NextEntryNo;
                InterfaceEntryLineOut."Buy-from Vendor No." := PurchaseLine."Buy-from Vendor No." + '-' + CompanyInformation."Legal Entity Code FND";
                InterfaceEntryLineOut."Source Line No." := PurchaseLine."Line No.";
                InterfaceEntryLineOut.Type := InterfaceEntryLineOut.Type::Item;
                Item.GET(PurchaseLine."No.");
                InterfaceEntryLineOut."No." := Item."No." + '-' + CompanyInformation."Legal Entity Code FND";
                InterfaceEntryLineOut.Description := PurchaseLine.Description;
                InterfaceEntryLineOut."Description 2" := PurchaseLine."Description 2";
                InterfaceEntryLineOut."Location Code" := PurchaseLine."Location Code";
                InterfaceEntryLineOut.Quantity := PurchaseLine.Quantity;
                InterfaceEntryLineOut."Currency Code" := InterfaceEntryHeaderOut."Currency Code";
                InterfaceEntryLineOut."Unit Amount" := PurchaseLine."Direct Unit Cost";
                InterfaceEntryLineOut."Unit of Measure Code" := InterfaceFrameworkMgt.GetUnitOfMeasureCommercialISOCode(PurchaseLine."Unit of Measure Code");
                InterfaceEntryLineOut."Qty. per Unit of Measure" := PurchaseLine."Qty. per Unit of Measure";
                InterfaceEntryLineOut."VAT %" := PurchaseLine."VAT %";
                InterfaceEntryLineOut."Document Date" := PurchaseHeader."Document Date";
                InterfaceEntryLineOut."Requested Receipt Date" := PurchaseLine."Requested Receipt Date";
                InterfaceEntryLineOut."Expected Receipt Date" := PurchaseLine."Expected Receipt Date";
                InterfaceEntryLineOut."Shortcut Dimension 1 Code" := PurchaseLine."Shortcut Dimension 1 Code";
                InterfaceEntryLineOut."Shortcut Dimension 2 Code" := PurchaseLine."Shortcut Dimension 2 Code";
                InterfaceEntryLineOut."External Requisition No." := PurchaseLine."Maximo Requisition No. FND";
                InterfaceEntryLineOut."External Requisition Line No." := PurchaseLine."Maximo Requis. Line No. FND";
                InterfaceEntryLineOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
                InterfaceEntryLineOut."Delete Record" := DeleteRecord;
                //HEI.02>>
                InterfaceEntryLineOut."Zone Code" := PurchaseLine."Zone Code FND";
                //HEI.02<<
                InterfaceEntryLineOut."Over Percent" := PurchaseLine."Tolerance Received Over % FND";
                InterfaceEntryLineOut."Under Percent" := PurchaseLine."Tolerance Received Under % FND";
                InterfaceEntryLineOut."Machine Reference No." := PurchaseLine."Machine Reference Number FND"; //HEI.18
                PurchaseLine.CALCFIELDS("Import Identifier FND"); //HEI.26
                InterfaceEntryLineOut.Cancelled := PurchaseLine."Import Identifier FND"; //HEI.26
                InterfaceEntryLineOut.INSERT();
            until PurchaseLine.NEXT() = 0;

        //HEI.16>>
        PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::"G/L Account");
        if LineNoToDelete <> 0 then
            PurchaseLine.SETRANGE("Line No.", LineNoToDelete);
        if PurchaseLine.findset() then
            repeat
                CLEAR(InterfaceEntryLineOut);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                NextEntryNo := NextEntryNo + 1;
                InterfaceEntryLineOut."Entry No." := NextEntryNo;
                InterfaceEntryLineOut."Buy-from Vendor No." := PurchaseLine."Buy-from Vendor No." + '-' + CompanyInformation."Legal Entity Code FND";
                InterfaceEntryLineOut."Source Line No." := PurchaseLine."Line No.";
                InterfaceEntryLineOut.Type := InterfaceEntryLineOut.Type::"G/L Account";
                lGLAcc.GET(PurchaseLine."No.");
                lCMGMapping.RESET();
                lCMGMapping.SETRANGE("G/L Account", lGLAcc."No.");
                if lCMGMapping.FINDFIRST() then begin
                    if lCMGMapping.COUNT > 1 then
                        ERROR(lText50000, lCMGMapping."G/L Account");
                    InterfaceEntryLineOut."No." := lCMGMapping."Dimension Value Code" + '-' + CompanyInformation."Legal Entity Code FND";
                end;
                InterfaceEntryLineOut.Description := PurchaseLine.Description;
                InterfaceEntryLineOut."Description 2" := PurchaseLine."Description 2";
                InterfaceEntryLineOut."Location Code" := PurchaseLine."Location Code";
                InterfaceEntryLineOut.Quantity := PurchaseLine.Quantity;
                InterfaceEntryLineOut."Currency Code" := InterfaceEntryHeaderOut."Currency Code";
                InterfaceEntryLineOut."Unit Amount" := PurchaseLine."Direct Unit Cost";
                InterfaceEntryLineOut."Unit of Measure Code" := InterfaceFrameworkMgt.GetUnitOfMeasureCommercialISOCode(PurchaseLine."Unit of Measure Code");
                InterfaceEntryLineOut."Qty. per Unit of Measure" := PurchaseLine."Qty. per Unit of Measure";
                InterfaceEntryLineOut."VAT %" := PurchaseLine."VAT %";
                InterfaceEntryLineOut."Document Date" := PurchaseHeader."Document Date";
                InterfaceEntryLineOut."Requested Receipt Date" := PurchaseLine."Requested Receipt Date";
                InterfaceEntryLineOut."Expected Receipt Date" := PurchaseLine."Expected Receipt Date";
                InterfaceEntryLineOut."Shortcut Dimension 1 Code" := PurchaseLine."Shortcut Dimension 1 Code";
                InterfaceEntryLineOut."Shortcut Dimension 2 Code" := PurchaseLine."Shortcut Dimension 2 Code";
                InterfaceEntryLineOut."External Requisition No." := PurchaseLine."Maximo Requisition No. FND";
                InterfaceEntryLineOut."External Requisition Line No." := PurchaseLine."Maximo Requis. Line No. FND";
                InterfaceEntryLineOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
                InterfaceEntryLineOut."Delete Record" := DeleteRecord;
                InterfaceEntryLineOut."Zone Code" := PurchaseLine."Zone Code FND";
                InterfaceEntryLineOut."Over Percent" := PurchaseLine."Tolerance Received Over % FND";
                InterfaceEntryLineOut."Under Percent" := PurchaseLine."Tolerance Received Under % FND";
                InterfaceEntryLineOut."Machine Reference No." := PurchaseLine."Machine Reference Number FND"; //HEI.18
                InterfaceEntryLineOut.INSERT();
            until PurchaseLine.NEXT() = 0;
        //HEI.16<<
    end;

    procedure ProcessPurchaseReceipt(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        Item: Record Item;
        Location: Record Location;
        Zone: Record Zone;
        Bin: Record Bin;
        WhseReceiptHeader: Record "Warehouse Receipt Header";
        WhseReceiptLine: Record "Warehouse Receipt Line";
        WarehouseRequest: Record "Warehouse Request";
        WhseCreateSourceDocument: Codeunit "Whse.-Create Source Document";
        ReleasePurchaseDocument: Codeunit "Release Purchase Document";
        PostWhseReceiptLine: Boolean;
        PostPO: Boolean;
        lItem: Record Item;
        lCMGMapping: Record "CMG Mapping FND";
        lComposedGLAcc: Code[20];
        lGeneralInterfaceSetup: Record "General Interface Setup INT";
        lGLAccount: Record "G/L Account";
        InterfaceEntryHeaderCheckStatus: Record "Interface Entry Header INT";
        lText50000: Label 'Dimension Value Code %1 is defined more than once in CMG Mappings!';
        lText50001: Label 'Field %1 is not setup in table %2!';
        lText50002: Label 'Dimension Value Code %1 is not defined in CMG Mappings!';
        lText50003: Label 'GL Account %1 does not exist!';
        lText50004: Label 'Line %1 from document %2 was not found!';
        lrec_PnPSetup: Record "Purchases & Payables Setup";
        ImportIdentifierPO: Boolean;
        lrec_PurchHdrAddtnl: Record "Purchase Header Additional FND";
        lText50005: Label 'Zone Code - %1 sent for Import Identifier Receipt is not for in transit cross border';
        PurchasesWarehouseMgt: Codeunit "Purchases Warehouse Mgt.";
    begin
        //Maximo Purchase Receipt
        GetGeneralInterfaceSetup();
        //HEI.27>>
        lrec_PnPSetup.GET();
        //HEI.27<<
        /* // commented by HEI.14 >>
        //HEI.07>>
        InterfaceEntryLine.SETRANGE("Header Entry No.",InterfaceEntryHeader."Entry No.");
        InterfaceEntryLine.FINDFIRST;
        IF InterfaceEntryLine.Quantity < 0 THEN
          UndoPurchaseReceipt(InterfaceEntryHeader)//HEI.07
        ELSE BEGIN
          //HEI.07<<
        */ // commented by HEI.14 <<
        PurchaseHeader.SETRANGE("Document Type", InterfaceEntryHeader."Source Subtype");
        PurchaseHeader.SETRANGE("No.", InterfaceEntryHeader."Source No.");
        PurchaseHeader.FINDFIRST();
        //HEI.27>>
        ImportIdentifierPO := false;
        if (lrec_PurchHdrAddtnl.GET(PurchaseHeader."Document Type"::Order, PurchaseHeader."No.")) and (lrec_PurchHdrAddtnl."Import Identifier") then begin
            ImportIdentifierPO := true;
            lrec_PnPSetup.TESTFIELD("Zone Code for Import Proc. FND");
        end;
        //HEI.27<<
        //HEI.16>>
        //RECEIPT WITH ITEM NO.-->UPDATE PURCH LINE AND WRSHE RCPT LINE - QTY TO RCV TO ZERO
        InterfaceEntryLine.RESET();
        InterfaceEntryLine.CALCFIELDS("Maximo Source Type", "Maximo Source No.", "Posting Date Header");
        InterfaceEntryLine.SETRANGE("Maximo Source Type", InterfaceEntryHeader."Source Type");
        InterfaceEntryLine.SETRANGE("Maximo Source No.", InterfaceEntryHeader."Source No.");
        InterfaceEntryLine.SETRANGE("Posting Date Header", InterfaceEntryHeader."Posting Date");
        InterfaceEntryLine.SETRANGE("Description 2", 'Receipt');
        InterfaceEntryLine.SETFILTER("No.", '<>%1', '');
        if InterfaceEntryLine.findset() then begin
            PurchaseLine.RESET();
            PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
            if PurchaseLine.findset() then
                repeat
                    PurchaseLine.VALIDATE("Qty. to Receive", 0);
                    PurchaseLine.VALIDATE("Qty. to Invoice", 0);
                    PurchaseLine.MODIFY();
                    Location.GET(PurchaseLine."Location Code");
                    if Location."Require Receive" then begin
                        WhseReceiptLine.SETRANGE("Source Type", DATABASE::"Purchase Line");
                        WhseReceiptLine.SETRANGE("Source Subtype", PurchaseLine."Document Type");
                        WhseReceiptLine.SETRANGE("Source No.", PurchaseLine."Document No.");
                        WhseReceiptLine.SETRANGE("Source Line No.", PurchaseLine."Line No.");
                        if WhseReceiptLine.findset() then
                            repeat
                                WhseReceiptLine.VALIDATE("Qty. to Receive", 0);
                                WhseReceiptLine.MODIFY();
                            until WhseReceiptLine.NEXT() = 0;
                        WhseReceiptLine.RESET();
                    end;
                until PurchaseLine.NEXT() = 0;
        end;
        //HEI.16<<

        //HEI.10>>
        //RECEIPT ALL LINE-->UPDATE PURCH LINE AND WRSHE RCPT LINE - QTY TO RCV TO ZERO
        InterfaceEntryLine.RESET();
        InterfaceEntryLine.CALCFIELDS("Maximo Source Type", "Maximo Source No.", "Posting Date Header");
        InterfaceEntryLine.SETRANGE("Maximo Source Type", InterfaceEntryHeader."Source Type");
        InterfaceEntryLine.SETRANGE("Maximo Source No.", InterfaceEntryHeader."Source No.");
        InterfaceEntryLine.SETRANGE("Posting Date Header", InterfaceEntryHeader."Posting Date");
        InterfaceEntryLine.SETRANGE("Description 2", 'Receipt');
        if InterfaceEntryLine.findset() then
        //HEI.13>>
          begin
            PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
            if PurchaseLine.FINDFIRST() then
                repeat
                    //HEI.16>>
                    /*
                    Item.GET(GetNoFromMaximoNo(InterfaceEntryLine."No."));
                    PurchaseLine.SETRANGE("Document Type",PurchaseHeader."Document Type");
                    PurchaseLine.SETRANGE("Document No.",PurchaseHeader."No.");
                    PurchaseLine.SETRANGE("Line No.",InterfaceEntryLine."Source Line No.");
                    PurchaseLine.SETRANGE(Type,InterfaceEntryLine.Type);
                    PurchaseLine.SETRANGE("No.",Item."No.");
                    PurchaseLine.FINDFIRST;
                    */
                    //HEI.16<<
                    Location.GET(PurchaseLine."Location Code");
                    if Location."Require Receive" then begin
                        WhseReceiptLine.SETRANGE("Source Type", DATABASE::"Purchase Line");
                        WhseReceiptLine.SETRANGE("Source Subtype", PurchaseLine."Document Type");
                        WhseReceiptLine.SETRANGE("Source No.", PurchaseLine."Document No.");
                        WhseReceiptLine.SETRANGE("Source Line No.", PurchaseLine."Line No.");
                        if WhseReceiptLine.findset() then
                            repeat
                                WhseReceiptLine.VALIDATE("Qty. to Receive", 0);
                                WhseReceiptLine.MODIFY();
                            until WhseReceiptLine.NEXT() = 0;
                        WhseReceiptLine.RESET();
                    end else begin
                        PurchaseLine.VALIDATE("Qty. to Receive", 0);
                        PurchaseLine.MODIFY();
                    end;
                until PurchaseLine.NEXT() = 0;
        end;
        //HEI.13<<

        //RECEIPT WITH ITEM NO.-->VALIDATE POSTNG DT IN PURCH LINE
        InterfaceEntryLine.RESET();
        //HEI.16>>
        //InterfaceEntryLine.CALCFIELDS("Maximo Source Type","Maximo Source No.","Posting Date Header");
        InterfaceEntryLine.CALCFIELDS("Maximo Source Type", "Maximo Source No.", "Posting Date Header", "Interface Header Status");
        //HEI.35>>
        //InterfaceEntryLine.SETCURRENTKEY(Blocked);//HEI.38
        //InterfaceEntryLine.ASCENDING(FALSE);//HEI.38
        //HEI.35<<
        InterfaceEntryLine.SETFILTER("Interface Header Status", '<>%1', InterfaceEntryLine."Interface Header Status"::Error);
        //HEI.16<<
        InterfaceEntryLine.SETRANGE("Maximo Source Type", InterfaceEntryHeader."Source Type");
        InterfaceEntryLine.SETRANGE("Maximo Source No.", InterfaceEntryHeader."Source No.");
        InterfaceEntryLine.SETRANGE("Posting Date Header", InterfaceEntryHeader."Posting Date");
        InterfaceEntryLine.SETRANGE("Description 2", 'Receipt');
        //HEI.16>>
        InterfaceEntryLine.SETFILTER("No.", '<>%1', '');
        //HEI.16<<
        //HEI.10<<
        //InterfaceEntryLine.SETRANGE("Header Entry No.",InterfaceEntryHeader."Entry No.");  //HEI.10
        if InterfaceEntryLine.findset() then begin
            if (InterfaceEntryHeader."Posting Date" <> PurchaseHeader."Posting Date") or
                //(InterfaceEntryHeader."Document Date" <> PurchaseHeader."Document Date") OR //HEI.31
                (InterfaceEntryHeader."External Document No." <> PurchaseHeader."Vendor Shipment No.")
            then begin
                //ReleasePurchaseDocument.Reopen(PurchaseHeader); //HEI.31
                PurchaseHeader.VALIDATE("Posting Date", InterfaceEntryHeader."Posting Date");
                //PurchaseHeader.VALIDATE("Document Date",InterfaceEntryHeader."Document Date");//Hei.31
                PurchaseHeader.VALIDATE("Vendor Shipment No.", InterfaceEntryHeader."External Document No.");
                //CODEUNIT.RUN(CODEUNIT::"Release Purchase Document",PurchaseHeader);//Hei.31
            end;
            repeat
                //HEI.16>>
                lComposedGLAcc := '';
                lItem.RESET();
                if lItem.GET(GetNoFromMaximoNo(InterfaceEntryLine."No.")) then begin
                    //HEI.16<<
                    Item.GET(GetNoFromMaximoNo(InterfaceEntryLine."No."));
                    PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                    PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
                    PurchaseLine.SETRANGE("Line No.", InterfaceEntryLine."Source Line No.");
                    PurchaseLine.SETRANGE(Type, InterfaceEntryLine.Type);
                    PurchaseLine.SETRANGE("No.", Item."No.");
                    //>>HEI.34
                    //PurchaseLine.FINDFIRST;
                    //HEI.35>>
                    //IF PurchaseLine.FINDFIRST THEN BEGIN
                    //  IF InterfaceEntryLine.Blocked THEN BEGIN
                    //    PurchaseLine.VALIDATE("Delivery Finalized",TRUE);
                    //    PurchaseLine.MODIFY;
                    //  END;
                    //  IF InterfaceEntryLine."Delivery Finalized" THEN BEGIN
                    //    PurchaseLine.VALIDATE("Delivery Finalized",TRUE);
                    //    PurchaseLine.MODIFY;
                    //  END;
                    //END;
                    if PurchaseLine.FINDFIRST() then begin
                        if (InterfaceEntryLine.Blocked) or (InterfaceEntryLine."Delivery Finalized") then begin
                            PurchaseLine.VALIDATE("Delivery Finalized FND", true);
                            PurchaseLine.MODIFY();
                        end;
                    end;
                    //HEI.35<<
                    //<<HEI.34
                    Location.GET(PurchaseLine."Location Code");
                    if Location."Require Receive" then begin
                        WhseReceiptLine.SETRANGE("Source Type", DATABASE::"Purchase Line");
                        WhseReceiptLine.SETRANGE("Source Subtype", PurchaseLine."Document Type");
                        WhseReceiptLine.SETRANGE("Source No.", PurchaseLine."Document No.");
                        WhseReceiptLine.SETRANGE("Source Line No.", PurchaseLine."Line No.");  //HEI.10
                        if WhseReceiptLine.findset() then
                            repeat
                                //HEI.10>>
                                //    WhseReceiptLine.VALIDATE("Qty. to Receive",0);
                                //    WhseReceiptLine.MODIFY;
                                //HEI.10<<
                                //HEI.34>>
                                if InterfaceEntryLine.Blocked then begin
                                    WhseReceiptLine.VALIDATE("Qty. to Receive", 0);
                                end;
                            //HEI.34<<
                            until WhseReceiptLine.NEXT() = 0;
                        //BC UPGRADE ATHUKS01 FDD_STP11>>
                        WhseReceiptLine.RESET;
                        PurchaseLine.CALCFIELDS("Whse. Receipt No. (Open) FND");
                        if PurchaseLine."Whse. Receipt No. (Open) FND" <> '' then begin
                            //HEI.19>>
                            //WhseReceiptHeader.GET(PurchaseLine."Whse. Receipt No. (Open)");
                            if WhseReceiptHeader.GET(PurchaseLine."Whse. Receipt No. (Open) FND") then begin
                                WhseReceiptHeader.VALIDATE("Posting Date", WORKDATE);
                                WhseReceiptHeader.MODIFY
                            end;
                            //HEI.19<<
                            WhseReceiptLine.SETRANGE("No.", WhseReceiptHeader."No.");
                            WhseReceiptLine.SETRANGE("Source Type", DATABASE::"Purchase Line");
                            WhseReceiptLine.SETRANGE("Source Subtype", PurchaseLine."Document Type");
                            WhseReceiptLine.SETRANGE("Source No.", PurchaseLine."Document No.");
                            WhseReceiptLine.SETRANGE("Source Line No.", PurchaseLine."Line No.");
                            WhseReceiptLine.FINDFIRST;
                        end else begin
                            WarehouseRequest.SETRANGE(Type, WarehouseRequest.Type::Inbound);
                            WarehouseRequest.SETRANGE("Location Code", PurchaseLine."Location Code");
                            WarehouseRequest.SETRANGE("Source Type", DATABASE::"Purchase Line");
                            WarehouseRequest.SETRANGE("Source Subtype", PurchaseLine."Document Type");
                            WarehouseRequest.SETRANGE("Source No.", PurchaseLine."Document No.");
                            if WarehouseRequest.FINDFIRST then begin
                                if WarehouseRequest."Warehouse Rcpt/Shpt No. FND" <> '' then
                                    WhseReceiptHeader.GET(WarehouseRequest."Warehouse Rcpt/Shpt No. FND")
                                else begin
                                    CLEAR(WhseReceiptHeader);
                                    WhseReceiptHeader.INSERT(true);
                                    //HEI.19>>
                                    //WhseReceiptHeader.VALIDATE("Posting Date",InterfaceEntryHeader."Posting Date");
                                    WhseReceiptHeader.VALIDATE("Posting Date", WORKDATE);
                                    //HEI.19<<
                                    WhseReceiptHeader.VALIDATE("Vendor Shipment No.", InterfaceEntryHeader."External Document No.");
                                    WhseReceiptHeader.MODIFY;
                                end;
                            end else begin
                                CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeader);
                                CLEAR(WhseReceiptHeader);
                                WhseReceiptHeader.INSERT(true);
                                WhseReceiptHeader.VALIDATE("Posting Date", InterfaceEntryHeader."Posting Date");
                                WhseReceiptHeader.VALIDATE("Vendor Shipment No.", InterfaceEntryHeader."External Document No.");
                                WhseReceiptHeader.MODIFY;
                            end;
                            //WhseCreateSourceDocument.PurchLine2ReceiptLine(WhseReceiptHeader,PurchaseLine);
                            PurchasesWarehouseMgt.PurchLine2ReceiptLine(WhseReceiptHeader, PurchaseLine);  //BC UPGRADE ATHUKS01 FDD_STP11>>
                            //HEI.10>>
                            WhseReceiptLine.SETRANGE("No.", WhseReceiptHeader."No.");
                            WhseReceiptLine.SETRANGE("Source No.", PurchaseLine."Document No.");
                            WhseReceiptLine.SETRANGE("Source Line No.", PurchaseLine."Line No.");
                            if WhseReceiptLine.FINDFIRST then begin
                                WhseReceiptLine.VALIDATE("Qty. to Receive", 0);
                                WhseReceiptLine.MODIFY;
                            end;
                            WhseReceiptLine.RESET;
                            //HEI.10<<
                        end;
                        //BC UPGRADE ATHUKS01 FDD_STP11<<

                        WhseReceiptLine.SETRANGE("No.", WhseReceiptHeader."No.");
                        WhseReceiptLine.SETRANGE("Source No.", PurchaseLine."Document No.");
                        WhseReceiptLine.SETRANGE("Source Line No.", PurchaseLine."Line No.");
                        WhseReceiptLine.FINDFIRST();
                        //WhseReceiptLine.VALIDATE("Qty. to Receive",InterfaceEntryLine.Quantity);  //HEI.10
                        //HEI.16>>
                        //WhseReceiptLine.VALIDATE("Qty. to Receive",WhseReceiptLine."Qty. to Receive" + InterfaceEntryLine.Quantity);  //HEI.10
                        //HEI.34>>
                        if InterfaceEntryLine.Blocked then begin
                            WhseReceiptLine.VALIDATE("Qty. to Receive", 0);
                        end else
                            //HEI.34<<
                            WhseReceiptLine.VALIDATE("Qty. to Receive", InterfaceEntryLine.Quantity);
                        //HEI.16<<
                        //HEI.27>>
                        if ImportIdentifierPO then begin
                            if InterfaceEntryLine."Zone Code" <> lrec_PnPSetup."Zone Code for Import Proc. FND" then
                                ERROR(lText50005, InterfaceEntryLine."Zone Code");
                        end;
                        //HEI.27<<
                        //HEI.02>>
                        Zone.GET(Location.Code, InterfaceEntryLine."Zone Code");
                        if Location."Bin Mandatory" then
                            Zone.TESTFIELD("Default Receipt Bin Code FND");
                        Bin.GET(Location.Code, Zone."Default Receipt Bin Code FND");
                        Bin.TESTFIELD("Zone Code", InterfaceEntryLine."Zone Code");
                        WhseReceiptLine.VALIDATE("Zone Code", InterfaceEntryLine."Zone Code");
                        WhseReceiptLine.VALIDATE("Bin Code", Bin.Code);
                        //HEI.02<<
                        WhseReceiptLine.MODIFY(true);
                        //IF WhseReceiptLine."Qty. to Receive" <> 0 THEN HEI.10
                        //  CODEUNIT.RUN(CODEUNIT::"Whse.-Post Receipt",WhseReceiptLine); HEI.10
                        PostWhseReceiptLine := WhseReceiptLine."Qty. to Receive" <> 0; //HEI.10
                    end else begin
                        //PurchaseLine.VALIDATE("Qty. to Receive",InterfaceEntryLine.Quantity);  //HEI.10
                        PurchaseLine.VALIDATE("Qty. to Receive", PurchaseLine."Qty. to Receive" + InterfaceEntryLine.Quantity);   //HEI.10
                        PurchaseLine.VALIDATE("Qty. to Invoice", 0);
                        PurchaseLine.MODIFY();
                        //HEI.10>>
                        /*CODEUNIT.RUN(CODEUNIT::"Release Purchase Document",PurchaseHeader);
                        IF PurchaseLine."Qty. to Receive" <> 0 THEN BEGIN
                          PurchaseHeader.Receive := TRUE;
                          PurchaseHeader.Invoice := FALSE;
                          CODEUNIT.RUN(CODEUNIT::"Purch.-Post",PurchaseHeader);
                        END;*/
                        //HEI.10<<
                        PostPO := PurchaseLine."Qty. to Receive" <> 0; //HEI.10
                    end;
                    //HEI.16>>
                end
                else //CMG was received
                    begin
                    lGeneralInterfaceSetup.GET();
                    if lGeneralInterfaceSetup.Services = '' then
                        ERROR(lText50001, lGeneralInterfaceSetup.FIELDCAPTION(Services), lGeneralInterfaceSetup.TABLECAPTION);

                    PurchaseLine.RESET();
                    PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                    PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
                    PurchaseLine.SETRANGE("Line No.", InterfaceEntryLine."Source Line No.");
                    if PurchaseLine.FINDFIRST() then begin
                        //PurchaseLine.VALIDATE("Qty. to Receive",PurchaseLine."Qty. to Receive" + InterfaceEntryLine.Quantity);   //as part of HEI.10
                        PurchaseLine.VALIDATE("Qty. to Receive", InterfaceEntryLine.Quantity);   //as part of HEI.10
                        PurchaseLine.VALIDATE("Qty. to Invoice", 0);
                        PurchaseLine.MODIFY();

                        PostPO := PurchaseLine."Qty. to Receive" <> 0; //as part of HEI.10
                    end
                    else
                        ERROR(lText50004, InterfaceEntryLine."Source Line No.", PurchaseHeader."No.");
                end;
            //HEI.16<<
            until InterfaceEntryLine.NEXT() = 0;
            //HEI.10>>
            if PostWhseReceiptLine then begin //HEI.35
                                              //>> HEI.20
                WhseReceiptLine.RESET();
                WhseReceiptLine.SETRANGE("Source Type", DATABASE::"Purchase Line");
                WhseReceiptLine.SETRANGE("Source Subtype", PurchaseLine."Document Type");
                WhseReceiptLine.SETRANGE("Source No.", PurchaseLine."Document No.");
                WhseReceiptLine.SETFILTER("Qty. to Receive", '<>%1', 0);
                if WhseReceiptLine.findset() then
                    repeat
                        CODEUNIT.RUN(CODEUNIT::"Whse.-Post Receipt", WhseReceiptLine);
                    until WhseReceiptLine.NEXT() = 0;
            end; //HEI.35
                 //<< HEI.20
            if PostPO then begin
                CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeader);
                PurchaseHeader.Receive := true;
                PurchaseHeader.Invoice := false;
                CODEUNIT.RUN(CODEUNIT::"Purch.-Post", PurchaseHeader);
            end;
            //HEI.35>>
            if not PostWhseReceiptLine and not PostPO then
                COMMIT();
            //HEI.35<<
            //HEI.10<<
        end;
        //END;//HEI.07  // commented by HEI.14 <<
        //HEI.16>>
        PurchaseHeader.RESET();
        PurchaseHeader.SETRANGE("Document Type", InterfaceEntryHeader."Source Subtype");
        PurchaseHeader.SETRANGE("No.", InterfaceEntryHeader."Source No.");
        PurchaseHeader.FINDFIRST();

        InterfaceEntryLine.RESET();
        InterfaceEntryLine.CALCFIELDS("Maximo Source Type", "Maximo Source No.", "Posting Date Header", "Interface Header Status");
        InterfaceEntryLine.SETRANGE("Maximo Source Type", InterfaceEntryHeader."Source Type");
        InterfaceEntryLine.SETRANGE("Maximo Source No.", InterfaceEntryHeader."Source No.");
        InterfaceEntryLine.SETRANGE("Posting Date Header", InterfaceEntryHeader."Posting Date");
        InterfaceEntryLine.SETRANGE("Description 2", 'Receipt');
        InterfaceEntryLine.SETFILTER("No.", '=%1', '');
        if InterfaceEntryLine.findset() then begin
            PurchaseLine.RESET();
            PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
            if PurchaseLine.findset() then
                repeat
                    PurchaseLine.VALIDATE("Qty. to Receive", 0);
                    PurchaseLine.VALIDATE("Qty. to Invoice", 0);
                    PurchaseLine.MODIFY();
                until PurchaseLine.NEXT() = 0;
        end;

        InterfaceEntryLine.RESET();
        InterfaceEntryLine.CALCFIELDS("Maximo Source Type", "Maximo Source No.", "Posting Date Header", "Interface Header Status");
        InterfaceEntryLine.SETFILTER("Interface Header Status", '<>%1', InterfaceEntryLine."Interface Header Status"::Error);
        InterfaceEntryLine.SETRANGE("Maximo Source Type", InterfaceEntryHeader."Source Type");
        InterfaceEntryLine.SETRANGE("Maximo Source No.", InterfaceEntryHeader."Source No.");
        InterfaceEntryLine.SETRANGE("Posting Date Header", InterfaceEntryHeader."Posting Date");
        InterfaceEntryLine.SETRANGE("Description 2", 'Receipt');
        InterfaceEntryLine.SETFILTER("No.", '=%1', '');
        if InterfaceEntryLine.findset() then begin
            if (InterfaceEntryHeader."Posting Date" <> PurchaseHeader."Posting Date") or
                //(InterfaceEntryHeader."Document Date" <> PurchaseHeader."Document Date") OR //HEI.31
                (InterfaceEntryHeader."External Document No." <> PurchaseHeader."Vendor Shipment No.")
            then begin
                //ReleasePurchaseDocument.Reopen(PurchaseHeader);  //HEI.31
                PurchaseHeader.VALIDATE("Posting Date", InterfaceEntryHeader."Posting Date");
                //PurchaseHeader.VALIDATE("Document Date",InterfaceEntryHeader."Document Date");  //HEI.31
                PurchaseHeader.VALIDATE("Vendor Shipment No.", InterfaceEntryHeader."External Document No.");
                //CODEUNIT.RUN(CODEUNIT::"Release Purchase Document",PurchaseHeader);  //HEI.31
            end;
            repeat
                lComposedGLAcc := '';
                lItem.RESET();
                if lItem.GET(GetNoFromMaximoNo(InterfaceEntryLine."No.")) then begin
                    Item.GET(GetNoFromMaximoNo(InterfaceEntryLine."No."));
                    PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                    PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
                    PurchaseLine.SETRANGE("Line No.", InterfaceEntryLine."Source Line No.");
                    PurchaseLine.SETRANGE(Type, InterfaceEntryLine.Type);
                    PurchaseLine.SETRANGE("No.", Item."No.");
                    PurchaseLine.FINDFIRST();
                    Location.GET(PurchaseLine."Location Code");
                    if Location."Require Receive" then begin
                        WhseReceiptLine.SETRANGE("Source Type", DATABASE::"Purchase Line");
                        WhseReceiptLine.SETRANGE("Source Subtype", PurchaseLine."Document Type");
                        WhseReceiptLine.SETRANGE("Source No.", PurchaseLine."Document No.");
                        WhseReceiptLine.SETRANGE("Source Line No.", PurchaseLine."Line No.");
                        if WhseReceiptLine.findset() then
                            repeat

                            until WhseReceiptLine.NEXT() = 0;
                        // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Whse. Receipt No. (Open)",WarehouseRequest."Warehouse Rcpt/Shpt No.")
                        // WhseReceiptLine.RESET;
                        // PurchaseLine.CALCFIELDS("Whse. Receipt No. (Open)");
                        // if PurchaseLine."Whse. Receipt No. (Open)" <> '' then begin
                        //     WhseReceiptHeader.GET(PurchaseLine."Whse. Receipt No. (Open)");
                        //     WhseReceiptLine.SETRANGE("No.", WhseReceiptHeader."No.");
                        //     WhseReceiptLine.SETRANGE("Source Type", DATABASE::"Purchase Line");
                        //     WhseReceiptLine.SETRANGE("Source Subtype", PurchaseLine."Document Type");
                        //     WhseReceiptLine.SETRANGE("Source No.", PurchaseLine."Document No.");
                        //     WhseReceiptLine.SETRANGE("Source Line No.", PurchaseLine."Line No.");
                        //     WhseReceiptLine.FINDFIRST;
                        // end else begin
                        //     WarehouseRequest.SETRANGE(Type, WarehouseRequest.Type::Inbound);
                        //     WarehouseRequest.SETRANGE("Location Code", PurchaseLine."Location Code");
                        //     WarehouseRequest.SETRANGE("Source Type", DATABASE::"Purchase Line");
                        //     WarehouseRequest.SETRANGE("Source Subtype", PurchaseLine."Document Type");
                        //     WarehouseRequest.SETRANGE("Source No.", PurchaseLine."Document No.");
                        //     if WarehouseRequest.FINDFIRST then begin
                        //         if WarehouseRequest."Warehouse Rcpt/Shpt No." <> '' then
                        //             WhseReceiptHeader.GET(WarehouseRequest."Warehouse Rcpt/Shpt No.")
                        //         else begin
                        //             CLEAR(WhseReceiptHeader);
                        //             WhseReceiptHeader.INSERT(true);
                        //             WhseReceiptHeader.VALIDATE("Posting Date", InterfaceEntryHeader."Posting Date");
                        //             WhseReceiptHeader.VALIDATE("Vendor Shipment No.", InterfaceEntryHeader."External Document No.");
                        //             WhseReceiptHeader.MODIFY;
                        //         end;
                        //     end else begin
                        //         CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeader);
                        //         CLEAR(WhseReceiptHeader);
                        //         WhseReceiptHeader.INSERT(true);
                        //         WhseReceiptHeader.VALIDATE("Posting Date", InterfaceEntryHeader."Posting Date");
                        //         WhseReceiptHeader.VALIDATE("Vendor Shipment No.", InterfaceEntryHeader."External Document No.");
                        //         WhseReceiptHeader.MODIFY;
                        //     end;
                        //     WhseCreateSourceDocument.PurchLine2ReceiptLine(WhseReceiptHeader, PurchaseLine);
                        //     WhseReceiptLine.SETRANGE("No.", WhseReceiptHeader."No.");
                        //     WhseReceiptLine.SETRANGE("Source No.", PurchaseLine."Document No.");
                        //     WhseReceiptLine.SETRANGE("Source Line No.", PurchaseLine."Line No.");
                        //     if WhseReceiptLine.FINDFIRST then begin
                        //         WhseReceiptLine.VALIDATE("Qty. to Receive", 0);
                        //         WhseReceiptLine.MODIFY;
                        //     end;
                        //     WhseReceiptLine.RESET;
                        // end;
                        // BC Upgrade BHARDA11 << ----Drink-IT Field("Whse. Receipt No. (Open)",WarehouseRequest."Warehouse Rcpt/Shpt No.")
                        WhseReceiptLine.SETRANGE("No.", WhseReceiptHeader."No.");
                        WhseReceiptLine.SETRANGE("Source No.", PurchaseLine."Document No.");
                        WhseReceiptLine.SETRANGE("Source Line No.", PurchaseLine."Line No.");
                        WhseReceiptLine.FINDFIRST();
                        //HEI.34>>
                        if InterfaceEntryLine.Blocked then begin
                            WhseReceiptLine.VALIDATE("Qty. to Receive", 0);
                        end else
                            //HEI.34<<
                            WhseReceiptLine.VALIDATE("Qty. to Receive", WhseReceiptLine."Qty. to Receive" + InterfaceEntryLine.Quantity);
                        //HEI.27>>
                        if ImportIdentifierPO then begin
                            if InterfaceEntryLine."Zone Code" <> lrec_PnPSetup."Zone Code for Import Proc. FND" then
                                ERROR(lText50005, InterfaceEntryLine."Zone Code");
                        end;
                        //HEI.27<<
                        Zone.GET(Location.Code, InterfaceEntryLine."Zone Code");
                        if Location."Bin Mandatory" then
                            Zone.TESTFIELD("Default Receipt Bin Code FND");
                        Bin.GET(Location.Code, Zone."Default Receipt Bin Code FND");
                        Bin.TESTFIELD("Zone Code", InterfaceEntryLine."Zone Code");
                        WhseReceiptLine.VALIDATE("Zone Code", InterfaceEntryLine."Zone Code");
                        WhseReceiptLine.VALIDATE("Bin Code", Bin.Code);
                        WhseReceiptLine.MODIFY(true);
                        PostWhseReceiptLine := WhseReceiptLine."Qty. to Receive" <> 0;
                    end else begin
                        PurchaseLine.VALIDATE("Qty. to Receive", PurchaseLine."Qty. to Receive" + InterfaceEntryLine.Quantity);
                        PurchaseLine.VALIDATE("Qty. to Invoice", 0);
                        PurchaseLine.MODIFY();

                        PostPO := PurchaseLine."Qty. to Receive" <> 0;
                    end;

                end
                else //CMG was received
                    begin
                    lGeneralInterfaceSetup.GET();
                    if lGeneralInterfaceSetup.Services = '' then
                        ERROR(lText50001, lGeneralInterfaceSetup.FIELDCAPTION(Services), lGeneralInterfaceSetup.TABLECAPTION);

                    PurchaseLine.RESET();
                    PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                    PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
                    PurchaseLine.SETRANGE("Line No.", InterfaceEntryLine."Source Line No.");
                    if PurchaseLine.FINDFIRST() then begin
                        PurchaseLine.VALIDATE("Qty. to Receive", InterfaceEntryLine.Quantity);
                        PurchaseLine.VALIDATE("Qty. to Invoice", 0);
                        PurchaseLine.MODIFY();

                        PostPO := PurchaseLine."Qty. to Receive" <> 0;
                    end
                    else
                        ERROR(lText50004, InterfaceEntryLine."Source Line No.", PurchaseHeader."No.");
                end;
            until InterfaceEntryLine.NEXT() = 0;
            if PostPO then begin
                CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeader);
                PurchaseHeader.Receive := true;
                PurchaseHeader.Invoice := false;
                CODEUNIT.RUN(CODEUNIT::"Purch.-Post", PurchaseHeader);
            end;
        end;
        //HEI.16<<

    end;

    procedure ProcessPurchaseCancelReceipt(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        InterfaceEntryLine: Record "Interface Entry Line INT";
    begin
        //HEI.07>>
        UndoPurchaseReceipt(InterfaceEntryHeader)//HEI.07
        //HEI.07<<
    end;

    procedure ProcessGoodsIssue(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        SourceCodeSetup: Record "Source Code Setup";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        ItemJournalLine: Record "Item Journal Line";
        Item: Record Item;
        Location: Record Location;
        Zone: Record Zone;
        Bin: Record Bin;
        ProdOrderLine: Record "Prod. Order Line";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        IncomingDimSetID: Integer;
        lrec_ILE: Record "Item Ledger Entry";
        l_Text5000: Label 'The document - %1 is already posted in Item Ledger Entry for the item - %2';
        InvtPeriodL: Record "Inventory Period";
    begin
        //Maximo goods issue
        GetGeneralInterfaceSetup();
        SourceCodeSetup.GET();

        // BC Upgrade PATELS08 >>
        // HEI.52 >>
        GLSetup.GET();
        // HEI.52 <<
        // BC Upgrade PATELS08 <<

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.findset() then
            repeat
                Item.GET(GetNoFromMaximoNo(InterfaceEntryHeader."Source No."));
                //HEI.23>>
                lrec_ILE.RESET();
                lrec_ILE.SETRANGE(lrec_ILE."Document No.", InterfaceEntryHeader."External Order No.");
                lrec_ILE.SETRANGE(lrec_ILE."Item No.", Item."No.");
                lrec_ILE.SETRANGE(lrec_ILE."Location Code", InterfaceEntryLine."Location Code");
                lrec_ILE.SETRANGE(lrec_ILE.Quantity, -InterfaceEntryLine.Quantity);
                if not lrec_ILE.FINDFIRST() then begin
                    //HEI.23<<
                    CLEAR(ItemJournalLine);
                    ItemJournalLine.VALIDATE("Document No.", InterfaceEntryHeader."External Order No.");
                    //HEI.46>>
                    if not InvtPeriodL.IsValidDate(InterfaceEntryHeader."Posting Date") then
                        ItemJournalLine.VALIDATE("Posting Date", TODAY)
                    else begin
                        //HEI.46<<

                        // BC Upgrade PATELS08 >>
                        //HEI.52>>
                        IF (InterfaceEntryHeader."Posting Date" < TODAY) AND (InterfaceEntryHeader."Posting Date" < GLSetup."Allow Posting From") AND (GLSetup."Allow Posting From" <> 0D) THEN
                            ItemJournalLine.VALIDATE("Posting Date", TODAY)
                        ELSE BEGIN
                            //HEI.52<<
                            // BC Upgrade PATELS08 <<
                            ItemJournalLine.VALIDATE("Posting Date", InterfaceEntryHeader."Posting Date");
                            ItemJournalLine.VALIDATE("Document Date", InterfaceEntryHeader."Document Date");

                            // BC Upgrade PATELS08 >>
                            // HEI.52 >>
                        END;
                        // HEI.52 <<
                        // BC Upgrade PATELS08 <<

                        //HEI.46>>
                    end;
                    //HEI.46<<
                    ItemJournalLine.VALIDATE("Item No.", Item."No.");
                    ItemJournalLine.VALIDATE("Location Code", InterfaceEntryLine."Location Code");
                    ItemJournalLine.VALIDATE("Zone Code FND", InterfaceEntryLine."Zone Code");
                    Location.GET(InterfaceEntryLine."Location Code");
                    Zone.GET(Location.Code, InterfaceEntryLine."Zone Code");
                    if Location."Bin Mandatory" then begin
                        Zone.TESTFIELD("Default Receipt Bin Code FND");
                        Bin.GET(Location.Code, Zone."Default Receipt Bin Code FND");
                        Bin.TESTFIELD("Zone Code", InterfaceEntryLine."Zone Code");
                        ItemJournalLine.VALIDATE("Bin Code", Bin.Code);
                    end;
                    ItemJournalLine.VALIDATE("Entry Type", InterfaceEntryLine."Entry Type");
                    ItemJournalLine.Description := InterfaceEntryLine.Description;
                    if InterfaceEntryLine."Unit of Measure Code" <> '' then
                        ItemJournalLine.VALIDATE("Unit of Measure Code", InterfaceFrameworkMgt.GetCommercialISOCodeUnitOfMeasure(InterfaceEntryLine."Unit of Measure Code"));
                    ItemJournalLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                    ItemJournalLine.VALIDATE("Shortcut Dimension 1 Code", InterfaceEntryLine."Shortcut Dimension 1 Code");
                    ItemJournalLine.VALIDATE("Shortcut Dimension 2 Code", InterfaceEntryLine."Shortcut Dimension 2 Code");
                    IncomingDimSetID := GetLineDimensionSetID(InterfaceEntryLine);
                    ItemJournalLine."Dimension Set ID" := DimensionManagement.GetDeltaDimSetID(IncomingDimSetID, IncomingDimSetID, ItemJournalLine."Dimension Set ID");
                    ItemJournalLine."Source Code" := SourceCodeSetup."Item Journal";
                    ItemJournalLine.VALIDATE("Source No.", Item."No.");
                    ItemJournalLine."Order No." := GeneralInterfaceSetup."Maximo Consumption Prod. Order";
                    CheckCreateProdOrderLine(Item."No.");
                    ProdOrderLine.SETRANGE(Status, ProdOrderLine.Status::Released);
                    ProdOrderLine.SETRANGE("Prod. Order No.", GeneralInterfaceSetup."Maximo Consumption Prod. Order");
                    ProdOrderLine.SETRANGE("Item No.", Item."No.");
                    ProdOrderLine.FINDFIRST();
                    ItemJournalLine."Order Line No." := ProdOrderLine."Line No.";
                    ItemJnlPostLine.RUN(ItemJournalLine);
                    //HEI.23>>
                end else begin
                    ERROR(STRSUBSTNO(l_Text5000, InterfaceEntryHeader."External Order No.", Item."No."));
                end;
            //HEI.23<<
            until InterfaceEntryLine.NEXT() = 0;
    end;

    local procedure CheckCreateProdOrderLine(ItemNo: Code[20]);
    var
        ProdOrder: Record "Production Order";
        ProdOrderLine: Record "Prod. Order Line";
        NextLineNo: Integer;
    begin
        GetGeneralInterfaceSetup();
        GeneralInterfaceSetup.TESTFIELD("Maximo Consumption Prod. Order");
        ProdOrder.GET(ProdOrder.Status::Released, GeneralInterfaceSetup."Maximo Consumption Prod. Order");
        ProdOrderLine.SETRANGE(Status, ProdOrderLine.Status::Released);
        ProdOrderLine.SETRANGE("Prod. Order No.", GeneralInterfaceSetup."Maximo Consumption Prod. Order");
        ProdOrderLine.SETRANGE("Item No.", ItemNo);
        if not ProdOrderLine.ISEMPTY then
            exit;

        ProdOrderLine.SETRANGE("Item No.");
        if ProdOrderLine.FINDLAST() then
            NextLineNo := ProdOrderLine."Line No.";

        CLEAR(ProdOrderLine);
        ProdOrderLine.VALIDATE(Status, ProdOrder.Status);
        ProdOrderLine.VALIDATE("Prod. Order No.", ProdOrder."No.");
        NextLineNo := NextLineNo + 10000;
        ProdOrderLine."Line No." := NextLineNo;
        ProdOrderLine.VALIDATE("Item No.", ItemNo);
        ProdOrderLine.VALIDATE(Quantity, 100000);
        ProdOrderLine.INSERT();
    end;

    [EventSubscriber(ObjectType::Table, 5405, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure T5405OnBeforeDelete(var Rec: Record "Production Order"; RunTrigger: Boolean);
    begin
        GetGeneralInterfaceSetup();
        if Rec."No." = GeneralInterfaceSetup."Maximo Consumption Prod. Order" then
            if not CONFIRM(STRSUBSTNO(MaximoConsProdOrderQst, Rec."No.")) then
                ERROR('');
    end;

    [EventSubscriber(ObjectType::Table, 5405, 'OnBeforeValidateEvent', 'Status', false, false)]
    local procedure T5405OnBeforeValidateStatus(var Rec: Record "Production Order"; var xRec: Record "Production Order"; CurrFieldNo: Integer);
    begin
        if Rec."No." = '' then
            exit;

        GetGeneralInterfaceSetup();
        if Rec."No." = GeneralInterfaceSetup."Maximo Consumption Prod. Order" then
            if Rec.Status <> xRec.Status then
                if not CONFIRM(STRSUBSTNO(MaximoConsProdOrderQst, Rec."No.")) then
                    ERROR('');
    end;

    procedure ProcessStockAdjmt(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        SourceCodeSetup: Record "Source Code Setup";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        ItemJournalLine: Record "Item Journal Line";
        Location: Record Location;
        Zone: Record Zone;
        Bin: Record Bin;
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        IncomingDimSetID: Integer;
        OriginalQuantity: Decimal;
        OriginalQuantityBase: Decimal;
    begin
        //Maximo stock adjustment
        GetGeneralInterfaceSetup();
        SourceCodeSetup.GET();

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.findset() then
            repeat
                CLEAR(ItemJournalLine);
                ItemJournalLine.VALIDATE("Document No.", InterfaceEntryHeader."External Order No.");
                ItemJournalLine.VALIDATE("Posting Date", InterfaceEntryHeader."Posting Date");
                ItemJournalLine.VALIDATE("Item No.", GetNoFromMaximoNo(InterfaceEntryHeader."Source No."));
                ItemJournalLine.VALIDATE("Location Code", InterfaceEntryLine."Location Code");
                ItemJournalLine.VALIDATE("Zone Code FND", InterfaceEntryLine."Zone Code");
                Location.GET(InterfaceEntryLine."Location Code");
                Zone.GET(Location.Code, InterfaceEntryLine."Zone Code");
                if Location."Bin Mandatory" then begin
                    Zone.TESTFIELD("Default Receipt Bin Code FND");
                    Bin.GET(Location.Code, Zone."Default Receipt Bin Code FND");
                    Bin.TESTFIELD("Zone Code", InterfaceEntryLine."Zone Code");
                    ItemJournalLine.VALIDATE("Bin Code", Bin.Code);
                end;
                ItemJournalLine.VALIDATE("Entry Type", InterfaceEntryLine."Entry Type");
                ItemJournalLine.Description := InterfaceEntryLine.Description;
                if InterfaceEntryLine."Unit of Measure Code" <> '' then
                    ItemJournalLine.VALIDATE("Unit of Measure Code", InterfaceFrameworkMgt.GetCommercialISOCodeUnitOfMeasure(InterfaceEntryLine."Unit of Measure Code"));
                ItemJournalLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                ItemJournalLine.VALIDATE("Shortcut Dimension 1 Code", InterfaceEntryLine."Shortcut Dimension 1 Code");
                ItemJournalLine.VALIDATE("Shortcut Dimension 2 Code", InterfaceEntryLine."Shortcut Dimension 2 Code");
                IncomingDimSetID := GetLineDimensionSetID(InterfaceEntryLine);
                ItemJournalLine."Dimension Set ID" := DimensionManagement.GetDeltaDimSetID(IncomingDimSetID, IncomingDimSetID, ItemJournalLine."Dimension Set ID");
                ItemJournalLine."Source Code" := SourceCodeSetup."Item Journal";
                if Location."Bin Mandatory" then
                    PostWhseJnlLine(ItemJournalLine);
                ItemJnlPostLine.RUN(ItemJournalLine);
            until InterfaceEntryLine.NEXT() = 0;
    end;

    local procedure PostWhseJnlLine(ItemJnlLine: Record "Item Journal Line");
    var
        WhseJnlLine: Record "Warehouse Journal Line";
        WMSMgmt: Codeunit "WMS Management";
        WhseMgt: Codeunit "Whse. Management";
        WhseJnlPostLine: Codeunit "Whse. Jnl.-Register Line";
    begin
        if WMSMgmt.CreateWhseJnlLine(ItemJnlLine, 0, WhseJnlLine, false) then begin
            WhseJnlLine."Source Type" := DATABASE::"Item Journal Line";
            WhseJnlLine."Source Subtype" := WhseJnlLine."Source Subtype"::"0";
            WhseJnlLine."Source Document" := WhseMgt.GetSourceDocument(WhseJnlLine."Source Type", WhseJnlLine."Source Subtype");
            WhseJnlLine."Source No." := ItemJnlLine."Document No.";
            WhseJnlLine."Source Line No." := ItemJnlLine."Line No.";
            WMSMgmt.CheckWhseJnlLine(WhseJnlLine, 1, 0, false);
            WhseJnlPostLine.RUN(WhseJnlLine);
        end;
    end;

    procedure CreateUnitCost();
    var
        InterfaceSetup: Record "Interface Setup INT";
        Item: Record Item;
        SKU: Record "Stockkeeping Unit";
        Location: Record Location;
        Zone: Record Zone;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceLogHeader: Record "Interface Log Header INT";
        InterfaceLogLine: Record "Interface Log Line INT";
        UnitCost: Decimal;
        EntryNo: Integer;
        FirstOutboundEntry: Boolean;
        UnitCostChanged: Boolean;
    begin
        //HEI.22>>
        ////Send item unit cost to Maximo
        //GetGeneralInterfaceSetup;
        //GetCompanyInformation;

        //InterfaceSetup.GET(GeneralInterfaceSetup."Maximo Unit Cost Interface");
        //IF NOT InterfaceSetup.Enabled THEN
        //  EXIT;

        //InterfaceLogHeader.SETRANGE("Interface Code",InterfaceSetup.Code);
        //IF InterfaceLogHeader.FINDLAST THEN
        //  InterfaceLogLine.SETRANGE("Header Entry No.",InterfaceLogHeader."Entry No.")
        //ELSE
        //  FirstOutboundEntry := TRUE;

        //CLEAR(InterfaceEntryHeaderOut);
        //InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
        //InterfaceEntryHeaderOut."Interface Code" := GeneralInterfaceSetup."Maximo Unit Cost Interface";
        //InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        //InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
        //InterfaceEntryHeaderOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        //InterfaceEntryHeaderOut.INSERT(TRUE);

        ////HEI.05>>
        //// Item.SETFILTER("Item Category Code",GeneralInterfaceSetup."Maximo Item Category Filter");
        //IF Item.FINDSET THEN

        ////IF Item.GET(InterfaceEntryHeaderOut."Source No.") AND FindItemFilters(Item) THEN
        ////HEI.05<<
        //  REPEAT
        //    IF FindItemFilters(Item) THEN BEGIN
        //      UnitCostChanged := FALSE;
        //      InterfaceLogLine.SETRANGE("No.",Item."No." + '-' + CompanyInformation."Legal Entity Code FND");
        //      InterfaceLogLine.SETRANGE("Location Code");
        //      InterfaceLogLine.SETRANGE("Zone Code");

        //      IF Item."Costing Method" = Item."Costing Method"::Standard THEN
        //       UnitCost := Item."Standard Cost"
        //      ELSE
        //        UnitCost := Item."Unit Cost";
        //      Location.SETRANGE("Use As In-Transit",FALSE);
        //      Location.SETFILTER(Code,GeneralInterfaceSetup."Maximo Location Filter");
        //      IF Location.FINDSET THEN BEGIN
        //        REPEAT
        //          UnitCostChanged := FALSE;
        //          InterfaceLogLine.SETRANGE("Location Code",Location.Code);
        //          IF SKU.GET(Location.Code,Item."No.") THEN BEGIN
        //            IF Item."Costing Method" = Item."Costing Method"::Standard THEN
        //              UnitCost := SKU."Standard Cost"
        //            ELSE
        //              UnitCost := SKU."Unit Cost";
        //          END;
        //          Zone.SETRANGE("Location Code",Location.Code);
        //          IF Zone.FINDSET THEN BEGIN
        //            REPEAT
        //              IF Zone."Use As Technical Zone" THEN BEGIN
        //                UnitCostChanged := FALSE;
        //                InterfaceLogLine.SETRANGE("Zone Code",Zone.Code);
        //                IF (NOT FirstOutboundEntry) AND InterfaceLogLine.FINDLAST THEN BEGIN
        //                  IF UnitCost <> InterfaceLogLine."Unit Amount" THEN
        //                    UnitCostChanged := TRUE;
        //                END ELSE
        //                  IF UnitCost <> 0 THEN
        //                    UnitCostChanged := TRUE;

        //                IF UnitCostChanged THEN BEGIN
        //                  CLEAR(InterfaceEntryLineOut);
        //                  InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
        //                  EntryNo := EntryNo + 1;
        //                  InterfaceEntryLineOut."Entry No." := EntryNo;
        //                  InterfaceEntryLineOut.Type := InterfaceEntryLineOut.Type::Item;
        //                  InterfaceEntryLineOut."No." := Item."No." + '-' + CompanyInformation."Legal Entity Code FND";
        //                  InterfaceEntryLineOut."Location Code" := Location.Code;
        //                  InterfaceEntryLineOut."Zone Code" := Zone.Code;
        //                  InterfaceEntryLineOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        //                  InterfaceEntryLineOut."Unit Amount" := UnitCost;
        //                  InterfaceEntryLineOut."Unit of Measure Code" := InterfaceFrameworkMgt.GetUnitOfMeasureCommercialISOCode(Item."Base Unit of Measure");
        //                  InterfaceEntryLineOut.INSERT(TRUE);
        //                END;
        //              END;
        //            UNTIL Zone.NEXT = 0;
        //          END ELSE BEGIN
        //            IF (NOT FirstOutboundEntry) AND InterfaceLogLine.FINDLAST THEN BEGIN
        //              IF UnitCost <> InterfaceLogLine."Unit Amount" THEN
        //               UnitCostChanged := TRUE;
        //            END ELSE
        //              IF UnitCost <> 0 THEN
        //                UnitCostChanged := TRUE;

        //            IF UnitCostChanged THEN BEGIN
        //              CLEAR(InterfaceEntryLineOut);
        //              InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
        //              EntryNo := EntryNo + 1;
        //              InterfaceEntryLineOut."Entry No." := EntryNo;
        //              InterfaceEntryLineOut.Type := InterfaceEntryLineOut.Type::Item;
        //              InterfaceEntryLineOut."No." := Item."No." + '-' + CompanyInformation."Legal Entity Code FND";
        //              InterfaceEntryLineOut."Location Code" := Location.Code;
        //              InterfaceEntryLineOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        //              InterfaceEntryLineOut."Unit Amount" := UnitCost;
        //              InterfaceEntryLineOut."Unit of Measure Code" := InterfaceFrameworkMgt.GetUnitOfMeasureCommercialISOCode(Item."Base Unit of Measure");
        //              InterfaceEntryLineOut.INSERT(TRUE);
        //            END;
        //          END;
        //        UNTIL Location.NEXT = 0;
        //      END ELSE BEGIN
        //        IF (NOT FirstOutboundEntry) AND InterfaceLogLine.FINDLAST THEN BEGIN
        //          IF UnitCost <> InterfaceLogLine."Unit Amount" THEN
        //            UnitCostChanged := TRUE;
        //        END ELSE
        //          IF UnitCost <> 0 THEN
        //            UnitCostChanged := TRUE;

        //        IF UnitCostChanged THEN BEGIN
        //          CLEAR(InterfaceEntryLineOut);
        //          InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
        //          EntryNo := EntryNo + 1;
        //          InterfaceEntryLineOut."Entry No." := EntryNo;
        //          InterfaceEntryLineOut.Type := InterfaceEntryLineOut.Type::Item;
        //          InterfaceEntryLineOut."No." := Item."No." + '-' + CompanyInformation."Legal Entity Code FND";
        //          InterfaceEntryLineOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        //          InterfaceEntryLineOut."Unit Amount" := UnitCost;
        //          InterfaceEntryLineOut."Unit of Measure Code" := InterfaceFrameworkMgt.GetUnitOfMeasureCommercialISOCode(Item."Base Unit of Measure");
        //          InterfaceEntryLineOut.INSERT(TRUE);
        //        END;
        //      END;
        //    END;
        //  UNTIL Item.NEXT = 0;
        //HEI.22<<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterInsertEvent', '', false, false)]
    local procedure T39OnAfterInsert(var Rec: Record "Purchase Line"; RunTrigger: Boolean);
    begin
        if (Rec."Document Type" = Rec."Document Type"::"Blanket Order") and
           (Rec."SRM Contract No. FND" <> '') and
           (Rec."SRM Contract Line No. FND" <> '') and
           (Rec.Type = Rec.Type::Item) and
           (not Rec.ISTEMPORARY)
        then
            CreateVendorItemRequest(Rec."Buy-from Vendor No.", Rec."No.");
    end;

    local procedure CreateVendorItemRequest(VendorNo: Code[20]; ItemNo: Code[20]);
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        ItemVendor: Record "Item Vendor";
    begin
        //Maximo vendor item request
        GetGeneralInterfaceSetup();
        GetCompanyInformation();

        InterfaceSetup.GET(GeneralInterfaceSetup."Maximo Item Vendor Interface");
        if not InterfaceSetup.Enabled then
            exit;

        if VendorNo = GeneralInterfaceSetup."Ibecor Vendor No." then
            exit;

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderOut."Interface Code" := GeneralInterfaceSetup."Maximo Item Vendor Interface";
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
        InterfaceEntryHeaderOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        InterfaceEntryHeaderOut."Source Type" := DATABASE::"Item Vendor";
        InterfaceEntryHeaderOut."Source No." := ItemNo + '-' + CompanyInformation."Legal Entity Code FND";
        InterfaceEntryHeaderOut."Buy-from Vendor No." := VendorNo + '-' + CompanyInformation."Legal Entity Code FND";
        InterfaceEntryHeaderOut.INSERT(true);

        CLEAR(InterfaceEntryLineOut);
        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
        InterfaceEntryLineOut."Entry No." := 1;
        InterfaceEntryLineOut.Type := InterfaceEntryLineOut.Type::Item;
        InterfaceEntryLineOut."No." := ItemNo + '-' + CompanyInformation."Legal Entity Code FND";
        if ItemVendor.GET(VendorNo, ItemNo) then begin
            InterfaceEntryLineOut."Cross Reference No." := ItemVendor."Vendor Item No.";
            InterfaceEntryLineOut."Lead Time Calculation" := ItemVendor."Lead Time Calculation";
        end;
        InterfaceEntryLineOut.INSERT(true);
    end;

    procedure ProcessGoodsTransfer(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        InterfaceEntryLine: Record "Interface Entry Line INT";
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        TransferOrderPostShipment: Codeunit "TransferOrder-Post Shipment";
        TransferOrderPostReceipt: Codeunit "TransferOrder-Post Receipt";
    begin
        //Maximo transfers
        GetGeneralInterfaceSetup();

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.findset() then
            repeat
                CLEAR(TransferHeader);
                TransferHeader.INSERT(true);
                TransferHeader.VALIDATE("Transfer-from Code", InterfaceEntryLine."Location Code");
                TransferHeader.VALIDATE("Transfer-to Code", InterfaceEntryLine."New Location Code");
                TransferHeader.VALIDATE("Posting Date", InterfaceEntryHeader."Posting Date");
                TransferHeader.MODIFY(true);

                CLEAR(TransferLine);
                TransferLine."Document No." := TransferHeader."No.";
                TransferLine."Line No." := 10000;
                TransferLine.VALIDATE("Item No.", GetNoFromMaximoNo(InterfaceEntryHeader."Source No."));
                TransferLine.VALIDATE(Quantity, InterfaceEntryLine.Quantity);
                TransferLine.VALIDATE("Shortcut Dimension 1 Code", InterfaceEntryLine."Shortcut Dimension 1 Code");
                TransferLine.VALIDATE("Shortcut Dimension 2 Code", InterfaceEntryLine."Shortcut Dimension 2 Code");
                TransferLine.VALIDATE(Description, InterfaceEntryLine.Description);
                TransferLine.INSERT(true);

                TransferOrderPostShipment.RUN(TransferHeader);
            until InterfaceEntryLine.NEXT() = 0;
    end;

    local procedure GetLineDimensionSetID(InterfaceEntryLine: Record "Interface Entry Line INT"): Integer;
    var
        DimensionValue: Record "Dimension Value";
        DimensionSetEntry: Record "Dimension Set Entry";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
    begin
        GetGeneralInterfaceSetup();
        GetGLSetup();

        if InterfaceEntryLine."Shortcut Dimension 1 Code" <> '' then begin
            CLEAR(TempDimensionSetEntry);
            TempDimensionSetEntry."Dimension Set ID" := -1;
            TempDimensionSetEntry."Dimension Code" := GLSetup."Shortcut Dimension 1 Code";
            TempDimensionSetEntry."Dimension Value Code" := InterfaceEntryLine."Shortcut Dimension 1 Code";
            DimensionValue.GET(GLSetup."Shortcut Dimension 1 Code", InterfaceEntryLine."Shortcut Dimension 1 Code");
            TempDimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
            TempDimensionSetEntry.INSERT();
        end;

        if InterfaceEntryLine."Shortcut Dimension 2 Code" <> '' then begin
            CLEAR(TempDimensionSetEntry);
            TempDimensionSetEntry."Dimension Set ID" := -1;
            TempDimensionSetEntry."Dimension Code" := GLSetup."Shortcut Dimension 2 Code";
            TempDimensionSetEntry."Dimension Value Code" := InterfaceEntryLine."Shortcut Dimension 2 Code";
            DimensionValue.GET(GLSetup."Shortcut Dimension 2 Code", InterfaceEntryLine."Shortcut Dimension 2 Code");
            TempDimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
            TempDimensionSetEntry.INSERT();
        end;

        if TempDimensionSetEntry.ISTEMPORARY then
            exit(DimensionSetEntry.GetDimensionSetID(TempDimensionSetEntry));
    end;

    local procedure GetNoFromMaximoNo(MaximoNo: Code[20]): Code[20];
    var
        DashPos: Integer;
    begin
        DashPos := STRPOS(MaximoNo, '-');
        if DashPos > 1 then
            exit(COPYSTR(MaximoNo, 1, DashPos - 1));
        exit(MaximoNo);
    end;

    local procedure GetCompanyInformation();
    begin
        if not CompanyInformationRead then
            CompanyInformation.GET();
        CompanyInformationRead := true;
    end;

    local procedure GetGeneralInterfaceSetup();
    begin
        if not GeneralInterfaceSetupRead then
            GeneralInterfaceSetup.GET();
        GeneralInterfaceSetupRead := true;
    end;

    local procedure GetGLSetup();
    begin
        if not GLSetupRead then
            GLSetup.GET();
        GLSetupRead := true;
    end;

    local procedure GetPurchSetup();
    begin
        if not PurchSetupRead then
            PurchSetup.GET();
        PurchSetupRead := true;
    end;

    procedure ProcessTransferReceipt(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        Item: Record Item;
        Location: Record Location;
        Zone: Record Zone;
        Bin: Record Bin;
        WhseReceiptHeader: Record "Warehouse Receipt Header";
        WhseReceiptLine: Record "Warehouse Receipt Line";
        WarehouseRequest: Record "Warehouse Request";
        WhseCreateSourceDocument: Codeunit "Whse.-Create Source Document";
        Inb: Codeunit "Get Source Doc. Inbound";
        ReleaseTransferDocument: Codeunit "Release Transfer Document";
        lItem: Record Item;
        lCMGMapping: Record "CMG Mapping FND";
        lComposedGLAcc: Code[20];
        lGeneralInterfaceSetup: Record "General Interface Setup INT";
        lGLAccount: Record "G/L Account";
        lTransferLine: Record "Transfer Line";
    begin
        //HEI.03>>
        //Maximo Transfer Receipt
        GetGeneralInterfaceSetup();

        TransferHeader.SETRANGE("External Document No.", InterfaceEntryHeader."Source No.");
        TransferHeader.FINDFIRST();
        //ReleaseTransferDocument.Reopen(TransferHeader);
        //CODEUNIT.RUN(CODEUNIT::"Release Transfer Document",TransferHeader);

        //HEI.16>>
        lTransferLine.RESET();
        lTransferLine.SETRANGE("Document No.", TransferHeader."No.");
        if lTransferLine.FINDFIRST() then
            repeat
                TransferLine.VALIDATE("Qty. to Receive", 0);
                TransferLine.MODIFY();
            until lTransferLine.NEXT() = 0;
        //HEI.16<<

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.findset() then begin
            /*
            IF (InterfaceEntryHeader."Posting Date" <> TransferHeader."Posting Date") //OR
               //(InterfaceEntryHeader."Document Date" <> TransferHeader."Document Date") OR
               //(InterfaceEntryHeader."External Document No." <> TransferHeader."External Document No.")
            THEN BEGIN
              //ReleasePurchaseDocument.Reopen(PurchaseHeader);
              TransferHeader.VALIDATE("Posting Date",InterfaceEntryHeader."Posting Date");
              //PurchaseHeader.VALIDATE("Document Date",InterfaceEntryHeader."Document Date");
              //TransferHeader.VALIDATE("External Document No.",InterfaceEntryHeader."External Document No.");
              //CODEUNIT.RUN(CODEUNIT::"Release Purchase Document",PurchaseHeader);
            END;
            */
            repeat
                //HEI.16>>
                lItem.RESET();
                if lItem.GET(GetNoFromMaximoNo(InterfaceEntryLine."No.")) then begin
                    //HEI.16<<
                    Item.GET(GetNoFromMaximoNo(InterfaceEntryLine."No."));
                    //TransferLine.SETRANGE("Document Type",PurchaseHeader."Document Type");
                    TransferLine.SETRANGE("Document No.", TransferHeader."No.");
                    //TransferLine.SETRANGE("Line No.",InterfaceEntryLine."Source Line No.");
                    //PurchaseLine.SETRANGE(Type,InterfaceEntryLine.Type);
                    TransferLine.SETRANGE("Shortcut Dimension 1 Code", InterfaceEntryLine."Shortcut Dimension 1 Code");
                    TransferLine.SETRANGE("Item No.", Item."No.");
                    TransferLine.FINDFIRST();
                    Location.GET(TransferHeader."Transfer-to Code");
                    if Location."Require Receive" then begin
                        WhseReceiptLine.SETRANGE("Source Type", DATABASE::"Transfer Line");
                        //WhseReceiptLine.SETRANGE("Source Subtype",TransferLine."Document Type");
                        WhseReceiptLine.SETRANGE("Source No.", TransferLine."Document No.");
                        if WhseReceiptLine.findset() then
                            repeat
                                WhseReceiptLine.VALIDATE("Qty. to Receive", 0);
                                WhseReceiptLine.MODIFY();
                            until WhseReceiptLine.NEXT() = 0;
                        WhseReceiptLine.RESET();
                        TransferLine.CALCFIELDS("Whse. Receipt No. (Open) FND");
                        if TransferLine."Whse. Receipt No. (Open) FND" <> '' then begin
                            WhseReceiptHeader.GET(TransferLine."Whse. Receipt No. (Open) FND");
                            WhseReceiptLine.SETRANGE("No.", WhseReceiptHeader."No.");
                            WhseReceiptLine.SETRANGE("Source Type", DATABASE::"Transfer Line");
                            //WhseReceiptLine.SETRANGE("Source Subtype",PurchaseLine."Document Type");
                            WhseReceiptLine.SETRANGE("Source No.", TransferLine."Document No.");
                            WhseReceiptLine.SETRANGE("Source Line No.", TransferLine."Line No.");
                            WhseReceiptLine.FINDFIRST();
                        end else begin
                            WarehouseRequest.SETRANGE(Type, WarehouseRequest.Type::Inbound);
                            WarehouseRequest.SETRANGE("Location Code", TransferHeader."Transfer-to Code");
                            WarehouseRequest.SETRANGE("Source Type", DATABASE::"Transfer Line");
                            WarehouseRequest.SETRANGE("Source Subtype", WarehouseRequest."Source Subtype"::"1");
                            WarehouseRequest.SETRANGE("Source No.", TransferLine."Document No.");
                            if WarehouseRequest.FINDFIRST() then begin
                                // BC Upgrade BHARDA11 >> ----Drink-IT Field("Warehouse Rcpt/Shpt No.")
                                // if WarehouseRequest."Warehouse Rcpt/Shpt No." <> '' then
                                //     WhseReceiptHeader.GET(WarehouseRequest."Warehouse Rcpt/Shpt No.")
                                // else begin
                                //     CLEAR(WhseReceiptHeader);         
                                //     WhseReceiptHeader.INSERT(true);
                                //     WhseReceiptHeader.VALIDATE("Posting Date", InterfaceEntryHeader."Posting Date");
                                //     WhseReceiptHeader.VALIDATE("Vendor Shipment No.", InterfaceEntryHeader."External Document No.");
                                //     WhseReceiptHeader.MODIFY;
                                // end;
                                // BC Upgrade BHARDA11 << ----Drink-IT Field("Warehouse Rcpt/Shpt No."))
                            end else begin
                                //CODEUNIT.RUN(CODEUNIT::"Release Purchase Document",PurchaseHeader);
                                CLEAR(WhseReceiptHeader);
                                WhseReceiptHeader.INSERT(true);
                                WhseReceiptHeader.VALIDATE("Posting Date", InterfaceEntryHeader."Posting Date");
                                WhseReceiptHeader.VALIDATE("Vendor Shipment No.", InterfaceEntryHeader."External Document No.");
                                WhseReceiptHeader.MODIFY();
                            end;
                            // WhseCreateSourceDocument.TransLine2ReceiptLine(WhseReceiptHeader, TransferLine); // BC Upgrade BHARDA11 ---TransLine2ReceiptLine is missing 
                        end;
                        WhseReceiptLine.SETRANGE("No.", WhseReceiptHeader."No.");
                        WhseReceiptLine.SETRANGE("Source No.", TransferLine."Document No.");
                        WhseReceiptLine.SETRANGE("Source Line No.", TransferLine."Line No.");
                        WhseReceiptLine.FINDFIRST();
                        WhseReceiptLine.VALIDATE(Quantity, TransferLine.Quantity);
                        WhseReceiptLine.VALIDATE("Qty. to Receive", InterfaceEntryLine.Quantity);
                        //HEI.02>>
                        Zone.GET(Location.Code, InterfaceEntryLine."Zone Code");
                        if Location."Bin Mandatory" then
                            Zone.TESTFIELD("Default Receipt Bin Code FND");
                        Bin.GET(Location.Code, Zone."Default Receipt Bin Code FND");
                        Bin.TESTFIELD("Zone Code", InterfaceEntryLine."Zone Code");
                        WhseReceiptLine.VALIDATE("Zone Code", InterfaceEntryLine."Zone Code");
                        WhseReceiptLine.VALIDATE("Bin Code", Bin.Code);
                        //HEI.02<<
                        WhseReceiptLine.MODIFY(true);
                        if WhseReceiptLine."Qty. to Receive" <> 0 then
                            CODEUNIT.RUN(CODEUNIT::"Whse.-Post Receipt", WhseReceiptLine);
                    end else begin
                        TransferLine.VALIDATE("Qty. to Receive", InterfaceEntryLine.Quantity);
                        //TransferLine.VALIDATE("Qty. to Invoice",0);
                        TransferLine.MODIFY();
                        //CODEUNIT.RUN(CODEUNIT::"Release Purchase Document",PurchaseHeader);
                        if TransferLine."Qty. to Receive" <> 0 then begin
                            //TransferLine.Receive := TRUE;
                            //TransferLine.Invoice := FALSE;
                            CODEUNIT.RUN(CODEUNIT::"TransferOrder-Post Receipt", TransferHeader);
                        end;
                    end;
                    //HEI.16>>
                end;
            //HEI.16<<
            until InterfaceEntryLine.NEXT() = 0;
        end;
        //HEI.03<<

    end;

    local procedure GetLastTransferLineNo(TransferOrderNo: Code[20]): Integer;
    var
        TransferLine: Record "Transfer Line";
    begin
        TransferLine.RESET();
        TransferLine.SETRANGE("Document No.", TransferOrderNo);
        if TransferLine.FINDLAST() then
            exit(TransferLine."Line No." + 10000)
        else
            exit(10000)
    end;

    procedure FindItemFilters(Item: Record Item): Boolean;
    var
        MaximoItemCategoryFilter: Record "Maximo Item Category Flter INT";
        DefaultDimensions: Record "Default Dimension";
    begin
        //HEI.05>>
        //IF ItemAttributeValueMapping.GET(DATABASE::Item,Item."No.",'1') THEN //HEI.06
        //  IF ItemAttributeValue.GET('1',ItemAttributeValueMapping."Item Attribute Value ID") THEN; //HEI.06

        if DefaultDimensions.GET(DATABASE::Item, Item."No.", 'CMG') then; //HEI.06

        MaximoItemCategoryFilter.SETRANGE("Item Category", Item."Item Category Code");
        MaximoItemCategoryFilter.SETRANGE("Gen. Prod. Posting Group", Item."Gen. Prod. Posting Group");
        MaximoItemCategoryFilter.SETRANGE("CMG Code", DefaultDimensions."Dimension Value Code"); //HEI.06
        if MaximoItemCategoryFilter.FINDFIRST() then
            exit(true);
        MaximoItemCategoryFilter.RESET();
        MaximoItemCategoryFilter.SETRANGE("Item Category", Item."Item Category Code");
        MaximoItemCategoryFilter.SETRANGE("Gen. Prod. Posting Group", Item."Gen. Prod. Posting Group");
        MaximoItemCategoryFilter.SETRANGE("CMG Code", ''); //HEI.06
        if MaximoItemCategoryFilter.FINDFIRST() then
            exit(true);
        MaximoItemCategoryFilter.RESET();
        MaximoItemCategoryFilter.SETRANGE("Item Category", Item."Item Category Code");
        MaximoItemCategoryFilter.SETRANGE("Gen. Prod. Posting Group", '');
        MaximoItemCategoryFilter.SETRANGE("CMG Code", ''); //HEI.06
        if MaximoItemCategoryFilter.FINDFIRST() then
            exit(true);
        //HEI.05<<
    end;

    local procedure UndoPurchaseReceipt(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        InterfaceEntryLine: Record "Interface Entry Line INT";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        Error001: Label 'You cannot cancel more than %1  %2';
        RemainingQty: Decimal;
        UndoPurchaseReceiptLine: Codeunit "Undo Purchase Receipt Line";
        PurchRcptLine2: Record "Purch. Rcpt. Line";
    begin
        //HEI.07>>
        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        //InterfaceEntryLine.FINDFIRST;
        InterfaceEntryLine.findset(); // HEI.28
        repeat // HEI.28
            RemainingQty := ABS(InterfaceEntryLine.Quantity);
            //PurchRcptLine.SETCURRENTKEY("Qty. Rcd. Not Invoiced");
            //PurchRcptLine.SETASCENDING("Qty. Rcd. Not Invoiced",FALSE);
            PurchRcptLine.RESET();
            PurchRcptLine.SETRANGE("Order No.", InterfaceEntryHeader."Source No.");
            PurchRcptLine.SETRANGE("Order Line No.", InterfaceEntryLine."Source Line No.");
            PurchRcptLine.SETRANGE(Correction, false);
            PurchRcptLine.SETFILTER("Qty. Rcd. Not Invoiced", '>%1', 0);
            PurchRcptLine.CALCSUMS("Qty. Rcd. Not Invoiced");

            if (PurchRcptLine."Qty. Rcd. Not Invoiced" < RemainingQty) or (PurchRcptLine."Qty. Rcd. Not Invoiced" = 0) then
                ERROR(Error001, PurchRcptLine."Qty. Rcd. Not Invoiced", PurchRcptLine."Unit of Measure Code");
            PurchRcptLine.SETRANGE("Qty. Rcd. Not Invoiced", RemainingQty);
            if PurchRcptLine.FINDFIRST() then begin
                //CODEUNIT.RUN(CODEUNIT::"Undo Purchase Receipt Line",PurchRcptLine)
                //MESSAGE('MatchFound and Cancel without receipt')
                PurchRcptLine2.RESET();
                PurchRcptLine2.SETRANGE("Document No.", PurchRcptLine."Document No.");
                PurchRcptLine2.SETRANGE("Line No.", PurchRcptLine."Line No.");
                if PurchRcptLine2.FINDFIRST() then begin
                    //>> HEI.28
                    if IsImportIdentifier(PurchRcptLine2) then begin
                        if UndoItemLedgerEntry(PurchRcptLine2) then begin
                            UndoPurchaseReceiptLine.SetHideDialog(true);
                            UndoPurchaseReceiptLine.RUN(PurchRcptLine2);
                        end
                    end else begin
                        //<< HEI.28
                        UndoPurchaseReceiptLine.SetHideDialog(true);
                        UndoPurchaseReceiptLine.RUN(PurchRcptLine2);
                    end; // HEI.28
                end;
            end else begin
                PurchRcptLine.SETFILTER("Qty. Rcd. Not Invoiced", '>%1', 0);
                PurchRcptLine.SETCURRENTKEY("Qty. Rcd. Not Invoiced");
                PurchRcptLine.SETASCENDING("Qty. Rcd. Not Invoiced", false);
                if PurchRcptLine.findset() then begin
                    repeat
                        if PurchRcptLine."Qty. Rcd. Not Invoiced" < RemainingQty then begin
                            RemainingQty -= PurchRcptLine."Qty. Rcd. Not Invoiced";
                            if InterfaceEntryHeader.Blocked = false then begin
                                PurchRcptLine2.RESET();
                                PurchRcptLine2.SETRANGE("Document No.", PurchRcptLine."Document No.");
                                PurchRcptLine2.SETRANGE("Line No.", PurchRcptLine."Line No.");
                                if PurchRcptLine2.FINDFIRST() then begin
                                    //>> HEI.28
                                    if IsImportIdentifier(PurchRcptLine2) then begin
                                        if UndoItemLedgerEntry(PurchRcptLine2) then begin
                                            UndoPurchaseReceiptLine.SetHideDialog(true);
                                            UndoPurchaseReceiptLine.RUN(PurchRcptLine2);
                                        end
                                    end else begin
                                        //<< HEI.28
                                        UndoPurchaseReceiptLine.SetHideDialog(true);
                                        UndoPurchaseReceiptLine.RUN(PurchRcptLine2);
                                    end;// HEI.28
                                end;
                            end;
                            //CODEUNIT.RUN(CODEUNIT::"Undo Purchase Receipt Line",PurchRcptLine);
                        end else begin
                            RemainingQty -= PurchRcptLine."Qty. Rcd. Not Invoiced";
                            //CODEUNIT.RUN(CODEUNIT::"Undo Purchase Receipt Line",PurchRcptLine);
                            if InterfaceEntryHeader.Blocked = false then begin
                                PurchRcptLine2.RESET();
                                PurchRcptLine2.SETRANGE("Document No.", PurchRcptLine."Document No.");
                                PurchRcptLine2.SETRANGE("Line No.", PurchRcptLine."Line No.");
                                if PurchRcptLine2.FINDFIRST() then begin
                                    //>> HEI.28
                                    if IsImportIdentifier(PurchRcptLine2) then begin
                                        if UndoItemLedgerEntry(PurchRcptLine2) then begin
                                            UndoPurchaseReceiptLine.SetHideDialog(true);
                                            UndoPurchaseReceiptLine.RUN(PurchRcptLine2);
                                        end
                                    end else begin
                                        //<< HEI.28
                                        UndoPurchaseReceiptLine.SetHideDialog(true);
                                        UndoPurchaseReceiptLine.RUN(PurchRcptLine2);
                                    end;
                                end; //HEI.28
                            end;
                            PostPurchaseReceipt(PurchRcptLine, ABS(RemainingQty), InterfaceEntryHeader);
                            exit;
                        end;
                    //MESSAGE('YES')
                    //MESSAGE(FORMAT(PurchRcptLine.Quantity));
                    until (PurchRcptLine.NEXT() = 0) or (RemainingQty <= 0);
                end;// ELSE
                    //MESSAGE('false')
            end;
        //HEI.07<<
        until InterfaceEntryLine.NEXT() = 0; //HEI.28
    end;

    local procedure PostPurchaseReceipt(PurchRcptLine: Record "Purch. Rcpt. Line"; RemainingQty: Decimal; var InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        Item: Record Item;
        Location: Record Location;
        WhseReceiptLine: Record "Warehouse Receipt Line";
        WhseReceiptHeader: Record "Warehouse Receipt Header";
        WarehouseRequest: Record "Warehouse Request";
        WhseCreateSourceDocument: Codeunit "Whse.-Create Source Document";
        Zone: Record Zone;
        PostedWhseReceiptLine: Record "Posted Whse. Receipt Line";
        Bin: Record Bin;
    begin
        //HEI.07>>
        InterfaceEntryHeader.Blocked := true;
        InterfaceEntryHeader.MODIFY();

        PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
        PurchaseHeader.SETRANGE("No.", PurchRcptLine."Order No.");
        PurchaseHeader.FINDFIRST();
        PurchaseLine.GET(PurchaseLine."Document Type"::Order, PurchRcptLine."Order No.", PurchRcptLine."Order Line No.");
        Location.GET(PurchaseLine."Location Code");
        if Location."Require Receive" then begin
            WhseReceiptLine.SETRANGE("Source Type", DATABASE::"Purchase Line");
            WhseReceiptLine.SETRANGE("Source Subtype", PurchaseLine."Document Type");
            WhseReceiptLine.SETRANGE("Source No.", PurchaseLine."Document No.");
            if WhseReceiptLine.findset() then
                repeat
                    WhseReceiptLine.VALIDATE("Qty. to Receive", 0);
                    WhseReceiptLine.MODIFY();
                until WhseReceiptLine.NEXT() = 0;
            // BC Upgrade BHARDA11 >> ----Drink-IT Field("Whse. Receipt No. (Open)","Warehouse Rcpt/Shpt No.")
            // WhseReceiptLine.RESET;
            // PurchaseLine.CALCFIELDS("Whse. Receipt No. (Open)");
            // if PurchaseLine."Whse. Receipt No. (Open)" <> '' then begin
            //     WhseReceiptHeader.GET(PurchaseLine."Whse. Receipt No. (Open)");
            //     WhseReceiptLine.SETRANGE("No.", WhseReceiptHeader."No.");
            //     WhseReceiptLine.SETRANGE("Source Type", DATABASE::"Purchase Line");
            //     WhseReceiptLine.SETRANGE("Source Subtype", PurchaseLine."Document Type");
            //     WhseReceiptLine.SETRANGE("Source No.", PurchaseLine."Document No.");
            //     WhseReceiptLine.SETRANGE("Source Line No.", PurchaseLine."Line No.");
            //     WhseReceiptLine.FINDFIRST;
            // end else begin
            //     WarehouseRequest.SETRANGE(Type, WarehouseRequest.Type::Inbound);
            //     WarehouseRequest.SETRANGE("Location Code", PurchaseLine."Location Code");
            //     WarehouseRequest.SETRANGE("Source Type", DATABASE::"Purchase Line");
            //     WarehouseRequest.SETRANGE("Source Subtype", PurchaseLine."Document Type");
            //     WarehouseRequest.SETRANGE("Source No.", PurchaseLine."Document No.");
            //     if WarehouseRequest.FINDFIRST then begin
            //         if WarehouseRequest."Warehouse Rcpt/Shpt No." <> '' then
            //             WhseReceiptHeader.GET(WarehouseRequest."Warehouse Rcpt/Shpt No.")
            //         else begin
            //             CLEAR(WhseReceiptHeader);
            //             WhseReceiptHeader.INSERT(true);
            //             WhseReceiptHeader.VALIDATE("Posting Date", InterfaceEntryHeader."Posting Date");
            //             WhseReceiptHeader.VALIDATE("Vendor Shipment No.", InterfaceEntryHeader."External Document No.");
            //             WhseReceiptHeader.MODIFY;
            //         end;
            //     end else begin
            //         CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeader);
            //         CLEAR(WhseReceiptHeader);
            //         WhseReceiptHeader.INSERT(true);
            //         WhseReceiptHeader.VALIDATE("Posting Date", InterfaceEntryHeader."Posting Date");
            //         WhseReceiptHeader.VALIDATE("Vendor Shipment No.", InterfaceEntryHeader."External Document No.");
            //         WhseReceiptHeader.MODIFY;
            //     end;
            //     WhseCreateSourceDocument.PurchLine2ReceiptLine(WhseReceiptHeader, PurchaseLine);
            // end;
            // BC Upgrade BHARDA11 << ----Drink-IT Fields("Whse. Receipt No. (Open)","Warehouse Rcpt/Shpt No.")
            WhseReceiptLine.SETRANGE("No.", WhseReceiptHeader."No.");
            WhseReceiptLine.SETRANGE("Source No.", PurchaseLine."Document No.");
            WhseReceiptLine.SETRANGE("Source Line No.", PurchaseLine."Line No.");
            WhseReceiptLine.FINDFIRST();
            WhseReceiptLine.VALIDATE("Qty. to Receive", RemainingQty);//CH
                                                                      //HEI.02>>
            PostedWhseReceiptLine.SETRANGE("Posted Source No.", PurchRcptLine."Document No.");
            PostedWhseReceiptLine.SETRANGE("Posting Date", PurchRcptLine."Posting Date");
            PostedWhseReceiptLine.SETRANGE("Source No.", PurchRcptLine."Order No.");
            PostedWhseReceiptLine.SETRANGE("Source Line No.", PurchRcptLine."Order Line No.");
            PostedWhseReceiptLine.FINDFIRST();
            Zone.GET(Location.Code, PostedWhseReceiptLine."Zone Code");//CH
            if Location."Bin Mandatory" then
                Zone.TESTFIELD("Default Receipt Bin Code FND");
            Bin.GET(Location.Code, Zone."Default Receipt Bin Code FND");
            Bin.TESTFIELD("Zone Code", PostedWhseReceiptLine."Zone Code");
            WhseReceiptLine.VALIDATE("Zone Code", PostedWhseReceiptLine."Zone Code");
            WhseReceiptLine.VALIDATE("Bin Code", Bin.Code);
            //HEI.02<<
            WhseReceiptLine.MODIFY(true);
            if WhseReceiptLine."Qty. to Receive" <> 0 then
                CODEUNIT.RUN(CODEUNIT::"Whse.-Post Receipt", WhseReceiptLine);
        end else begin
            PurchaseLine.VALIDATE("Qty. to Receive", RemainingQty);
            PurchaseLine.VALIDATE("Qty. to Invoice", 0);
            PurchaseLine.MODIFY();
            CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeader);
            if PurchaseLine."Qty. to Receive" <> 0 then begin
                PurchaseHeader.Receive := true;
                PurchaseHeader.Invoice := false;
                CODEUNIT.RUN(CODEUNIT::"Purch.-Post", PurchaseHeader);
            end;
        end;
        //HEI.07<<
    end;

    procedure CreateUnitCostRedesigned();
    var
        InterfaceSetup: Record "Interface Setup INT";
        Item: Record Item;
        SKU: Record "Stockkeeping Unit";
        Location: Record Location;
        Zone: Record Zone;
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceLogHeader: Record "Interface Log Header INT";
        InterfaceLogLine: Record "Interface Log Line INT";
        UnitCost: Decimal;
        EntryNo: Integer;
        FirstOutboundEntry: Boolean;
        UnitCostChanged: Boolean;
        grec_MaximoUnitCostInterface: Record "Last Send Interface Values FND";
        grec_MaximoUnitCostInterfaceInsert: Record "Last Send Interface Values FND";
        rec_IntEntryLn: Record "Interface Entry Line INT";
    begin
        //HEI.22>>
        GetGeneralInterfaceSetup();
        GetCompanyInformation();

        InterfaceSetup.GET(GeneralInterfaceSetup."Maximo Unit Cost Interface");
        if not InterfaceSetup.Enabled then
            exit;

        //insert outb intr hdr
        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderOut."Interface Code" := GeneralInterfaceSetup."Maximo Unit Cost Interface";
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
        InterfaceEntryHeaderOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        InterfaceEntryHeaderOut.INSERT(true);

        //HEI.44<<
        SKU.RESET();
        SKU.SETFILTER(SKU."Location Code", GeneralInterfaceSetup."Maximo Location Filter");
        if SKU.findset(false) then
            repeat
                SKU.CALCFIELDS(Description);
                if FindItemFiltersBySKU(SKU."Item No.") then begin
                    Zone.RESET();
                    Zone.SETRANGE(Zone."Location Code", SKU."Location Code");
                    Zone.SETRANGE(Zone."Use As Technical Zone FND", true);
                    if Zone.findset(false) then
                        repeat
                            grec_MaximoUnitCostInterface.RESET();
                            grec_MaximoUnitCostInterface.SETRANGE(grec_MaximoUnitCostInterface."Item No", SKU."Item No.");
                            grec_MaximoUnitCostInterface.SETRANGE(grec_MaximoUnitCostInterface."Location Code", SKU."Location Code");
                            grec_MaximoUnitCostInterface.SETRANGE(grec_MaximoUnitCostInterface."Zone Code", Zone.Code);
                            if not grec_MaximoUnitCostInterface.FINDFIRST() then begin
                                //insert outb intr Line
                                if Item.GET(SKU."Item No.") then;
                                CLEAR(InterfaceEntryLineOut);
                                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                                EntryNo := EntryNo + 1;
                                InterfaceEntryLineOut."Entry No." := EntryNo;
                                InterfaceEntryLineOut.Type := InterfaceEntryLineOut.Type::Item;
                                InterfaceEntryLineOut."No." := SKU."Item No." + '-' + CompanyInformation."Legal Entity Code FND";
                                InterfaceEntryLineOut.Description := SKU.Description;
                                InterfaceEntryLineOut."Location Code" := SKU."Location Code";
                                InterfaceEntryLineOut."Zone Code" := Zone.Code;
                                InterfaceEntryLineOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
                                InterfaceEntryLineOut."Unit Amount" := SKU."Unit Cost";
                                InterfaceEntryLineOut."Unit of Measure Code" := InterfaceFrameworkMgt.GetUnitOfMeasureCommercialISOCode(Item."Base Unit of Measure");
                                InterfaceEntryLineOut.INSERT(true);
                                //Insert Maximo Unit Cost Table
                                CLEAR(grec_MaximoUnitCostInterfaceInsert);
                                grec_MaximoUnitCostInterfaceInsert."Item No" := SKU."Item No.";
                                grec_MaximoUnitCostInterfaceInsert."Item Description" := SKU.Description;
                                grec_MaximoUnitCostInterfaceInsert."Unit Of Measure" := InterfaceFrameworkMgt.GetUnitOfMeasureCommercialISOCode(Item."Base Unit of Measure");
                                grec_MaximoUnitCostInterfaceInsert."Interface Code" := GeneralInterfaceSetup."Maximo Unit Cost Interface";
                                grec_MaximoUnitCostInterfaceInsert."Direct Unit Cost" := SKU."Unit Cost";
                                grec_MaximoUnitCostInterfaceInsert."Location Code" := SKU."Location Code";
                                grec_MaximoUnitCostInterfaceInsert."Zone Code" := Zone.Code;
                                grec_MaximoUnitCostInterfaceInsert."Gen Prod Posting Group" := Item."Gen. Prod. Posting Group";
                                grec_MaximoUnitCostInterfaceInsert."Item Category Code" := Item."Item Category Code";
                                grec_MaximoUnitCostInterfaceInsert."Send Date" := TODAY;
                                grec_MaximoUnitCostInterfaceInsert.INSERT(true);
                            end else begin
                                if (grec_MaximoUnitCostInterface."Direct Unit Cost" <> SKU."Unit Cost") then begin
                                    //line
                                    CLEAR(InterfaceEntryLineOut);
                                    InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                                    EntryNo := EntryNo + 1;
                                    InterfaceEntryLineOut."Entry No." := EntryNo;
                                    InterfaceEntryLineOut.Type := InterfaceEntryLineOut.Type::Item;
                                    InterfaceEntryLineOut."No." := SKU."Item No." + '-' + CompanyInformation."Legal Entity Code FND";
                                    InterfaceEntryLineOut.Description := SKU.Description;
                                    InterfaceEntryLineOut."Location Code" := SKU."Location Code";
                                    InterfaceEntryLineOut."Zone Code" := Zone.Code;
                                    InterfaceEntryLineOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
                                    InterfaceEntryLineOut."Unit Amount" := SKU."Unit Cost";
                                    InterfaceEntryLineOut."Unit of Measure Code" := InterfaceFrameworkMgt.GetUnitOfMeasureCommercialISOCode(Item."Base Unit of Measure");
                                    InterfaceEntryLineOut.INSERT(true);
                                    //Insert Maximo Unit Cost Table
                                    grec_MaximoUnitCostInterface."Direct Unit Cost" := SKU."Unit Cost";
                                    grec_MaximoUnitCostInterface.MODIFY();
                                end;
                            end;
                        until Zone.NEXT() = 0;
                end;
            until SKU.NEXT() = 0;

        /*
        SKU.RESET;
        SKU.SETFILTER(SKU."Location Code",GeneralInterfaceSetup."Maximo Location Filter");
        IF SKU.findset(FALSE,FALSE) THEN REPEAT
          SKU.CALCFIELDS(Description);
          IF FindItemFiltersBySKU(SKU."Item No.") THEN BEGIN
            //Query_MaxiimoUnitcostIntrfc.OPEN;
            //WHILE Query_MaxiimoUnitcostIntrfc.READ DO BEGIN
              grec_MaximoUnitCostInterface.RESET;
              grec_MaximoUnitCostInterface.SETRANGE(grec_MaximoUnitCostInterface."Item No",SKU."Item No.");
              grec_MaximoUnitCostInterface.SETRANGE(grec_MaximoUnitCostInterface."Location Code",SKU."Location Code");
              IF NOT grec_MaximoUnitCostInterface.FINDFIRST THEN BEGIN
                //insert outb intr Line
                Zone.RESET;
                Zone.SETRANGE(Zone."Location Code",SKU."Location Code");
                Zone.SETRANGE(Zone."Use As Technical Zone",TRUE);
                IF Zone.FINDFIRST THEN BEGIN
                  IF Item.GET(SKU."Item No.") THEN;
                  CLEAR(InterfaceEntryLineOut);
                  InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                  EntryNo := EntryNo + 1;
                  InterfaceEntryLineOut."Entry No." := EntryNo;
                  InterfaceEntryLineOut.Type := InterfaceEntryLineOut.Type::Item;
                  InterfaceEntryLineOut."No." := SKU."Item No." + '-' + CompanyInformation."Legal Entity Code FND";
                  InterfaceEntryLineOut.Description:= SKU.Description;
                  InterfaceEntryLineOut."Location Code" := SKU."Location Code";
                  InterfaceEntryLineOut."Zone Code" := Zone.Code;
                  InterfaceEntryLineOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
                  InterfaceEntryLineOut."Unit Amount" := SKU."Unit Cost";
                  InterfaceEntryLineOut."Unit of Measure Code" := InterfaceFrameworkMgt.GetUnitOfMeasureCommercialISOCode(Item."Base Unit of Measure");
                  InterfaceEntryLineOut.INSERT(TRUE);
                  //Insert Maximo Unit Cost Table
                  CLEAR(grec_MaximoUnitCostInterfaceInsert);
                  grec_MaximoUnitCostInterfaceInsert."Item No" := SKU."Item No.";
                  grec_MaximoUnitCostInterfaceInsert."Item Description" := SKU.Description;
                  grec_MaximoUnitCostInterfaceInsert."Unit Of Measure" := InterfaceFrameworkMgt.GetUnitOfMeasureCommercialISOCode(Item."Base Unit of Measure");
                  grec_MaximoUnitCostInterfaceInsert."Interface Code" := GeneralInterfaceSetup."Maximo Unit Cost Interface";
                  grec_MaximoUnitCostInterfaceInsert."Direct Unit Cost" := SKU."Unit Cost";
                  grec_MaximoUnitCostInterfaceInsert."Location Code" := SKU."Location Code";
                  grec_MaximoUnitCostInterfaceInsert."Zone Code" := Zone.Code;
                  grec_MaximoUnitCostInterfaceInsert."Gen Prod Posting Group" := Item."Gen. Prod. Posting Group";
                  grec_MaximoUnitCostInterfaceInsert."Item Category Code" := Item."Item Category Code";
                  grec_MaximoUnitCostInterfaceInsert."Send Date" := TODAY;
                  grec_MaximoUnitCostInterfaceInsert.INSERT(TRUE);
                END;
              END ELSE BEGIN
                IF (grec_MaximoUnitCostInterface."Direct Unit Cost" <> SKU."Unit Cost") THEN BEGIN
                  //line
                  CLEAR(InterfaceEntryLineOut);
                  InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                  EntryNo := EntryNo + 1;
                  InterfaceEntryLineOut."Entry No." := EntryNo;
                  InterfaceEntryLineOut.Type := InterfaceEntryLineOut.Type::Item;
                  InterfaceEntryLineOut."No." := SKU."Item No." + '-' + CompanyInformation."Legal Entity Code FND";
                  InterfaceEntryLineOut.Description := SKU.Description;
                  InterfaceEntryLineOut."Location Code" := SKU."Location Code";
                  InterfaceEntryLineOut."Zone Code" := Zone.Code;
                  InterfaceEntryLineOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
                  InterfaceEntryLineOut."Unit Amount" := SKU."Unit Cost";
                  InterfaceEntryLineOut."Unit of Measure Code" := InterfaceFrameworkMgt.GetUnitOfMeasureCommercialISOCode(Item."Base Unit of Measure");
                  InterfaceEntryLineOut.INSERT(TRUE);
                  //Insert Maximo Unit Cost Table
                  grec_MaximoUnitCostInterface."Direct Unit Cost" := SKU."Unit Cost";
                  grec_MaximoUnitCostInterface.MODIFY;
                END;
              END;
            END;
            //Query_MaxiimoUnitcostIntrfc.CLOSE;
          //END;
        UNTIL SKU.NEXT = 0;
        */
        //HEI.44>>

        rec_IntEntryLn.RESET();
        rec_IntEntryLn.SETRANGE(rec_IntEntryLn."Header Entry No.", InterfaceEntryHeaderOut."Entry No.");
        if not rec_IntEntryLn.FINDFIRST() then
            InterfaceEntryHeaderOut.DELETE();
        //HEI.22<<

    end;

    procedure FindItemFiltersBySKU(Item: Code[20]): Boolean;
    var
        MaximoItemCategoryFilter: Record "Maximo Item Category Flter INT";
        DefaultDimensions: Record "Default Dimension";
        lrec_Item: Record Item;
    begin
        //HEI.22>>
        if lrec_Item.GET(Item) then begin
            if DefaultDimensions.GET(DATABASE::Item, lrec_Item."No.", 'CMG') then; //HEI.06

            MaximoItemCategoryFilter.SETRANGE("Item Category", lrec_Item."Item Category Code");
            MaximoItemCategoryFilter.SETRANGE("Gen. Prod. Posting Group", lrec_Item."Gen. Prod. Posting Group");
            MaximoItemCategoryFilter.SETRANGE("CMG Code", DefaultDimensions."Dimension Value Code"); //HEI.06
            if MaximoItemCategoryFilter.FINDFIRST() then
                exit(true);
            MaximoItemCategoryFilter.RESET();
            MaximoItemCategoryFilter.SETRANGE("Item Category", lrec_Item."Item Category Code");
            MaximoItemCategoryFilter.SETRANGE("Gen. Prod. Posting Group", lrec_Item."Gen. Prod. Posting Group");
            MaximoItemCategoryFilter.SETRANGE("CMG Code", ''); //HEI.06
            if MaximoItemCategoryFilter.FINDFIRST() then
                exit(true);
            MaximoItemCategoryFilter.RESET();
            MaximoItemCategoryFilter.SETRANGE("Item Category", lrec_Item."Item Category Code");
            MaximoItemCategoryFilter.SETRANGE("Gen. Prod. Posting Group", '');
            MaximoItemCategoryFilter.SETRANGE("CMG Code", ''); //HEI.06
            if MaximoItemCategoryFilter.FINDFIRST() then
                exit(true);
        end;
        //HEI.22<<
    end;

    procedure CreateItemRequestGroupHeader(): Integer;
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        Language: Record Language;
        ItemTranslation: Record "Item Translation";
        DefaultLanguageCode: Code[10];
        LineEntryNo: Integer;
        ItemRec: Record Item;
        ItemAttribueRec: Record "Item Attribute";
        ItemAttriValRec: Record "Item Attribute Value";
        ItemValMappRec: Record "Item Attribute Value Mapping";
        GeneralLedSetupRec: Record "General Ledger Setup";
        lStockkeepingUnit: Record "Stockkeeping Unit";
        lLocTemp: Record Location temporary;
        lLoc: Record Location;
        lZone: Record Zone;
    begin
        //HEI.21>>
        GetGeneralInterfaceSetup();
        GetCompanyInformation();

        InterfaceSetup.GET(GeneralInterfaceSetup."Maximo Item Interface");
        if not InterfaceSetup.Enabled then
            exit;

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderOut."Interface Code" := GeneralInterfaceSetup."Maximo Item Interface";
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
        InterfaceEntryHeaderOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        InterfaceEntryHeaderOut."Source Type" := DATABASE::Item;
        GeneralInterfaceSetup.RESET();
        ;
        GeneralInterfaceSetup.GET();
        GeneralInterfaceSetup.TESTFIELD("CMG Attribute ID");
        ItemValMappRec.RESET();
        ItemValMappRec.SETRANGE("Item Attribute ID", GeneralInterfaceSetup."CMG Attribute ID");
        if ItemValMappRec.FINDFIRST() then begin
            ItemAttriValRec.RESET();
            ItemAttriValRec.SETRANGE("Attribute ID", GeneralInterfaceSetup."CMG Attribute ID");
            ItemAttriValRec.SETRANGE(ID, ItemValMappRec."Item Attribute Value ID");
            if ItemAttriValRec.FINDFIRST() then
                InterfaceEntryHeaderOut."CMG Code" := ItemAttriValRec.Value;
        end;
        InterfaceEntryHeaderOut."Location Code" := lLocTemp.Code;
        InterfaceEntryHeaderOut.INSERT(true);

        exit(InterfaceEntryHeaderOut."Entry No.");
        //HEI.21<<
    end;

    procedure CreateItemRequestGrouped(LogHeaderEntryNo: Integer; Item: Record Item; DeleteRecord: Boolean; pLineEntryNo: Integer): Integer;
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        Language: Record Language;
        ItemTranslation: Record "Item Translation";
        DefaultLanguageCode: Code[10];
        LineEntryNo: Integer;
        ItemRec: Record Item;
        ItemAttribueRec: Record "Item Attribute";
        ItemAttriValRec: Record "Item Attribute Value";
        ItemValMappRec: Record "Item Attribute Value Mapping";
        GeneralLedSetupRec: Record "General Ledger Setup";
        lStockkeepingUnit: Record "Stockkeeping Unit";
        lLocTemp: Record Location temporary;
        lLoc: Record Location;
        lZone: Record Zone;
    begin
        //HEI.21>>
        LineEntryNo := pLineEntryNo;

        InterfaceEntryHeaderOut.GET(LogHeaderEntryNo);

        lLocTemp.RESET();
        lStockkeepingUnit.RESET();
        lStockkeepingUnit.SETCURRENTKEY("Item No.", "Location Code", "Variant Code");
        lStockkeepingUnit.SETRANGE("Item No.", Item."No.");
        if lStockkeepingUnit.findset(false) then
            repeat
                if lLoc.GET(lStockkeepingUnit."Location Code") then begin
                    lZone.RESET();
                    lZone.SETRANGE("Location Code", lLoc.Code);
                    lZone.SETRANGE("Use As Technical Zone FND", true);
                    if lZone.FINDFIRST() then begin
                        lLocTemp.RESET();
                        if not lLocTemp.GET(lLoc.Code) then begin
                            lLocTemp.TRANSFERFIELDS(lLoc);
                            if lLocTemp.INSERT() then;
                        end;
                        ;
                    end;
                end;
            until lStockkeepingUnit.NEXT() = 0;


        if lLocTemp.ISEMPTY then begin
            LineEntryNo := LineEntryNo + 1;
            if Language.GET(GeneralInterfaceSetup."Maximo Default Language Code") then
                DefaultLanguageCode := Language.Code;
            // CreateItemEntryGrouped(InterfaceEntryHeaderOut, Item, DeleteRecord, Language."ISO Language Text", Item."Description 2", LineEntryNo, ''); // BC Upgrade BHARDA11 ----Drink-IT Field(Language."ISO Language Text")
            CreateItemEntryGrouped(InterfaceEntryHeaderOut, Item, DeleteRecord, Language."ISO Language Text1 FND", Item."Description 2", LineEntryNo, ''); // BC Upgrade BHARDA11 ----Drink-IT Field(Language."ISO Language Text")

            CLEAR(ItemTranslation);
            Language.RESET();
            Language.SETFILTER(Code, '<>%1', DefaultLanguageCode);
            Language.SETRANGE("Use In Maximo FND", true);
            if Language.findset() then
                repeat
                    ItemTranslation.SETRANGE("Item No.", Item."No.");
                    ItemTranslation.SETRANGE("Language Code", Language.Code);
                    if ItemTranslation.FINDFIRST() then begin
                        LineEntryNo := LineEntryNo + 1;
                        // CreateItemEntryGrouped(InterfaceEntryHeaderOut, Item, DeleteRecord, Language."ISO Language Text", ItemTranslation.Description, LineEntryNo, ''); // BC Upgrade BHARDA11 ----Drink-IT Field(Language."ISO Language Text")
                        CreateItemEntryGrouped(InterfaceEntryHeaderOut, Item, DeleteRecord, Language."ISO Language Text1 FND", ItemTranslation.Description, LineEntryNo, ''); // BC Upgrade BHARDA11 ----Drink-IT Field(Language."ISO Language Text")
                    end;
                until Language.NEXT() = 0;
        end;


        lLocTemp.RESET();
        if not lLocTemp.ISEMPTY then begin
            if lLocTemp.FINDFIRST() then
                repeat
                    LineEntryNo := LineEntryNo + 1;
                    if Language.GET(GeneralInterfaceSetup."Maximo Default Language Code") then
                        DefaultLanguageCode := Language.Code;
                    // CreateItemEntryGrouped(InterfaceEntryHeaderOut, Item, DeleteRecord, Language."ISO Language Text", Item."Description 2", LineEntryNo, lLocTemp.Code); // BC Upgrade BHARDA11 ----Drink-IT Field(Language."ISO Language Text")
                    CreateItemEntryGrouped(InterfaceEntryHeaderOut, Item, DeleteRecord, Language."ISO Language Text1 FND", Item."Description 2", LineEntryNo, lLocTemp.Code); // BC Upgrade BHARDA11 ----Drink-IT Field(Language."ISO Language Text")

                    CLEAR(ItemTranslation);
                    Language.RESET();
                    Language.SETFILTER(Code, '<>%1', DefaultLanguageCode);
                    Language.SETRANGE("Use In Maximo FND", true);
                    if Language.findset() then
                        repeat
                            ItemTranslation.SETRANGE("Item No.", Item."No.");
                            ItemTranslation.SETRANGE("Language Code", Language.Code);
                            if ItemTranslation.FINDFIRST() then begin
                                LineEntryNo := LineEntryNo + 1;
                                // CreateItemEntryGrouped(InterfaceEntryHeaderOut, Item, DeleteRecord, Language."ISO Language Text", ItemTranslation.Description, LineEntryNo, lLocTemp.Code); // BC Upgrade BHARDA11 ----Drink-IT Field(Language."ISO Language Text")
                                CreateItemEntryGrouped(InterfaceEntryHeaderOut, Item, DeleteRecord, Language."ISO Language Text1 FND", ItemTranslation.Description, LineEntryNo, lLocTemp.Code); // BC Upgrade BHARDA11 ---Remove drink-it field and replace with blank
                            end;
                        until Language.NEXT() = 0;
                until lLocTemp.NEXT() = 0;
        end;

        exit(LineEntryNo);
        //HEI.21<<
    end;

    local procedure CreateItemEntryGrouped(InterfaceEntryHeaderOut: Record "Interface Entry Header INT"; Item: Record Item; DeleteRecord: Boolean; LanguageCode: Code[10]; Description: Text; LineEntryNo: Integer; pLoc: Code[10]);
    var
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        ItemTrackingCode: Record "Item Tracking Code";
        ItemValMappRec: Record "Item Attribute Value Mapping";
        ItemAttriValRec: Record "Item Attribute Value";
    begin
        //HEI.21>>
        GetGeneralInterfaceSetup();
        GetCompanyInformation();

        GeneralInterfaceSetup.RESET();
        GeneralInterfaceSetup.GET();
        GeneralInterfaceSetup.TESTFIELD("CMG Attribute ID");
        ItemValMappRec.RESET();
        ItemValMappRec.SETRANGE("No.", Item."No.");
        ItemValMappRec.SETRANGE("Item Attribute ID", GeneralInterfaceSetup."CMG Attribute ID");
        if ItemValMappRec.FINDFIRST() then begin
            ItemAttriValRec.RESET();
            ItemAttriValRec.SETRANGE("Attribute ID", GeneralInterfaceSetup."CMG Attribute ID");
            ItemAttriValRec.SETRANGE(ID, ItemValMappRec."Item Attribute Value ID");
            if ItemAttriValRec.FINDFIRST() then
                InterfaceEntryHeaderOut."CMG Code" := ItemAttriValRec.Value;
        end;

        CLEAR(InterfaceEntryLineOut);
        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
        InterfaceEntryLineOut."Entry No." := LineEntryNo;
        InterfaceEntryLineOut.Type := InterfaceEntryLineOut.Type::Item;
        InterfaceEntryLineOut."No." := Item."No.";
        InterfaceEntryHeaderOut."Source No." := Item."No." + '-' + CompanyInformation."Legal Entity Code FND";
        InterfaceEntryHeaderOut.MODIFY();
        InterfaceEntryLineOut.CALCFIELDS("Source No.");
        InterfaceEntryLineOut."E-Mail 2" := InterfaceEntryLineOut."Source No.";
        InterfaceEntryLineOut."Global No." := Item."No. 2";
        InterfaceEntryLineOut."Language Code" := LanguageCode;
        InterfaceEntryLineOut.Description := Description;
        InterfaceEntryLineOut."Unit of Measure Code" := InterfaceFrameworkMgt.GetUnitOfMeasureCommercialISOCode(Item."Base Unit of Measure");
        InterfaceEntryLineOut."Purch. Unit of Measure" := InterfaceFrameworkMgt.GetUnitOfMeasureCommercialISOCode(Item."Purch. Unit of Measure");
        // InterfaceEntryLineOut."Auto Receive after Qlty. Test" := Item."Auto Receive after Qlty. Test"; // BC Upgrade BHARDA11 ----Drink-IT Field(Item."Auto Receive after Qlty. Test")
        if ItemTrackingCode.GET(Item."Item Tracking Code") then
            InterfaceEntryLineOut."Item Tracking Code" := 'LOT'
        else
            InterfaceEntryLineOut."Item Tracking Code" := 'NOLOT';
        InterfaceEntryLineOut."Item Segmentation" := Item."Item Segmentation FND";
        InterfaceEntryLineOut."Certification Required" := Item."Certification Required FND";
        InterfaceEntryLineOut."Rotating Item" := Item."Rotating Item FND";
        InterfaceEntryLineOut."Machine Reference No." := Item."Machine Reference Number FND";
        InterfaceEntryLineOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        InterfaceEntryLineOut.Blocked := Item.Blocked;
        InterfaceEntryLineOut."Delete Record" := DeleteRecord;
        InterfaceEntryLineOut."CMG Code" := InterfaceEntryHeaderOut."CMG Code";
        InterfaceEntryLineOut."Location Code" := pLoc;
        InterfaceEntryLineOut.INSERT(true);
        //HEI.21<<
    end;

    procedure CreateItemUOMRequest(prec_Item: Record Item; DeleteRecord: Boolean);
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        lrec_ItemUOM: Record "Item Unit of Measure";
        LineEntryNo: Integer;
    begin
        //HEI.25>>
        GetGeneralInterfaceSetup();
        GetCompanyInformation();
        InterfaceSetup.GET(GeneralInterfaceSetup."Maximo UnitofMeasure Interface");
        if not InterfaceSetup.Enabled then
            exit;

        //If no other uom is available except Base uom
        lrec_ItemUOM.SETRANGE("Item No.", prec_Item."No.");
        if lrec_ItemUOM.findset() then
            if (lrec_ItemUOM.COUNT = 1) and (prec_Item."Base Unit of Measure" = lrec_ItemUOM.Code) then
                exit;

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderOut."Interface Code" := GeneralInterfaceSetup."Maximo UnitofMeasure Interface";
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
        InterfaceEntryHeaderOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        InterfaceEntryHeaderOut."Source Type" := DATABASE::"Item Unit of Measure";
        InterfaceEntryHeaderOut."Source No." := prec_Item."No." + '-' + CompanyInformation."Legal Entity Code FND";
        InterfaceEntryHeaderOut.Description := prec_Item."Description 2";
        InterfaceEntryHeaderOut.Blocked := prec_Item.Blocked;
        InterfaceEntryHeaderOut."Delete Record" := DeleteRecord;
        InterfaceEntryHeaderOut.INSERT(true);

        LineEntryNo := 0;
        CLEAR(InterfaceEntryLineOut);
        lrec_ItemUOM.RESET();
        lrec_ItemUOM.SETRANGE("Item No.", prec_Item."No.");
        lrec_ItemUOM.SETFILTER(Code, '<>%1', prec_Item."Base Unit of Measure");
        if lrec_ItemUOM.findset() then
            repeat
                LineEntryNo := LineEntryNo + 1;
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                InterfaceEntryLineOut."Entry No." := LineEntryNo;
                InterfaceEntryLineOut."No." := lrec_ItemUOM."Item No." + '-' + CompanyInformation."Legal Entity Code FND";
                //InterfaceEntryLineOut."Unit of Measure Code" := lrec_ItemUOM.Code;
                InterfaceEntryLineOut."Unit of Measure Code" := prec_Item."Base Unit of Measure";
                InterfaceEntryLineOut."VAT Amount" := lrec_ItemUOM."Qty. per Unit of Measure";
                InterfaceEntryLineOut."External Document No." := lrec_ItemUOM.Code;
                //InterfaceEntryLineOut."Unit Amount" := lrec_ItemUOM.Weight;
                //InterfaceEntryLineOut."Line Amount" := lrec_ItemUOM."Net Weight";
                //InterfaceEntryLineOut."Global No." := lrec_ItemUOM."Unit of Weight";
                InterfaceEntryLineOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
                InterfaceEntryLineOut.INSERT(true);
                lrec_ItemUOM."Last Update FND" := WORKDATE();
                lrec_ItemUOM.MODIFY();
            until lrec_ItemUOM.NEXT() = 0;
        //HEI.25<<
    end;

    procedure ProcessTransferShipmentReceipt(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        InterfaceEntryLine: Record "Interface Entry Line INT";
        lrec_purchHdr: Record "Purchase Header";
        lrec_PurchHdrAdditional: Record "Purchase Header Additional FND";
        lrec_TransHdr: Record "Transfer Header";
        lrec_PostedTransHdr: Record "Transfer Shipment Header";
        lTxt50000: Label 'The Transfer Order - %1 is posted';
        lTxt50001: Label 'Transfer Order - %1 does not exist';
        ReleaseTransferDoc: Codeunit "Release Transfer Document";
        lrec_TransLn: Record "Transfer Line";
        lTxt50002: Label 'The Purchase Order - %1 is not import identifier';
        lrec_Item: Record Item;
        lrec_location: Record Location;
        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
        lrec_WrhsShpmntHdr: Record "Warehouse Shipment Header";
        ReleaseWhseShptDoc: Codeunit "Whse.-Shipment Release";
        lrec_WrhsShpmntLn: Record "Warehouse Shipment Line";
        PostTransferShipment: Boolean;
        lTxt50003: Label 'Transfer Line does not exist for Source line No. %1 and Item code %2';
    begin
        //HEI.27>>
        GetGeneralInterfaceSetup();
        if lrec_purchHdr.GET(InterfaceEntryHeader."Source Subtype", InterfaceEntryHeader."Source No.") then begin
            if lrec_PurchHdrAdditional.GET(lrec_purchHdr."Document Type", lrec_purchHdr."No.") then begin
                lrec_PurchHdrAdditional.CALCFIELDS("TO Reference");
                lrec_PurchHdrAdditional.TESTFIELD("TO Reference");
                PostTransferShipment := false;
                if lrec_TransHdr.GET(lrec_PurchHdrAdditional."TO Reference") then begin
                    if lrec_PurchHdrAdditional."Import Identifier" then begin
                        if (lrec_TransHdr.Status = lrec_TransHdr.Status::Released) then begin
                            ReleaseTransferDoc.Reopen(lrec_TransHdr);
                            //HEI.39>>
                            lrec_TransHdr."Posting Date" := InterfaceEntryHeader."Posting Date";
                            lrec_TransHdr.MODIFY();
                            //HEI.39<<
                            //HEI.45>>
                            //lrec_TransLn.RESET;
                            //lrec_TransLn.SETRANGE("Document No.",lrec_PurchHdrAdditional."TO Reference");
                            //IF lrec_TransLn.FINDSET THEN REPEAT
                            //lrec_TransLn.VALIDATE("Qty. to Ship",0);
                            //lrec_TransLn.VALIDATE("Qty. to Receive",0);
                            //lrec_TransLn.MODIFY(TRUE);
                            //UNTIL lrec_TransLn.NEXT = 0;
                            //HEI.45<<
                            //HEI.50>>
                            lrec_TransLn.RESET();
                            lrec_TransLn.SETRANGE("Document No.", lrec_PurchHdrAdditional."TO Reference");
                            if lrec_TransLn.findset(true) then
                                repeat
                                    lrec_TransLn.VALIDATE("Qty. to Ship", 0);
                                    lrec_TransLn.VALIDATE("Qty. to Receive", 0);
                                    lrec_TransLn.MODIFY(true);
                                until lrec_TransLn.NEXT() = 0;
                            //HEI.50<<

                        end;
                        InterfaceEntryLine.RESET();
                        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                        if InterfaceEntryLine.findset() then
                            repeat
                                if lrec_Item.GET(GetNoFromMaximoNo(InterfaceEntryLine."No.")) then;
                                //HEI.45>>
                                lrec_TransLn.RESET();
                                lrec_TransLn.SETCURRENTKEY("Document No.", "Line No.", "Item No.");
                                lrec_TransLn.SETRANGE("Document No.", lrec_PurchHdrAdditional."TO Reference");
                                lrec_TransLn.SETRANGE("Line No.", InterfaceEntryLine."Source Line No.");
                                lrec_TransLn.SETRANGE("Item No.", lrec_Item."No.");
                                if lrec_TransLn.findset(true) then begin
                                    repeat
                                        lrec_TransLn.VALIDATE("Qty. to Ship", 0);
                                        lrec_TransLn.VALIDATE("Qty. to Receive", 0);
                                        lrec_TransLn.MODIFY(true);
                                    until lrec_TransLn.NEXT() = 0;
                                end;
                                //HEI.45<<
                                lrec_TransLn.RESET();
                                //HEI.45>>
                                lrec_TransLn.SETCURRENTKEY("Document No.", "Line No.", "Item No.");
                                //HEI.45<<
                                lrec_TransLn.SETRANGE("Document No.", lrec_PurchHdrAdditional."TO Reference");
                                //HEI.45>>
                                lrec_TransLn.SETRANGE("Line No.", InterfaceEntryLine."Source Line No.");
                                //HEI.45<<
                                lrec_TransLn.SETRANGE("Item No.", lrec_Item."No.");
                                //HEI.45>>
                                //IF lrec_TransLn.FINDSET THEN REPEAT
                                //HEI.50>>
                                //IF lrec_TransLn.findset(TRUE,FALSE) THEN
                                //REPEAT
                                if lrec_TransLn.findset(true) then begin
                                    repeat
                                        //HEI.50<<
                                        //HEI.45<<
                                        lrec_TransLn.VALIDATE("Qty. to Ship", InterfaceEntryLine.Quantity);
                                        lrec_TransLn.MODIFY(true);
                                        PostTransferShipment := true;
                                    until lrec_TransLn.NEXT() = 0;
                                    //HEI.50>>
                                end else
                                    //HEI.51>>
                                    //ERROR(lTxt50002,InterfaceEntryLine."Source Line No.",lrec_Item."No.");
                                    ERROR(lTxt50003, InterfaceEntryLine."Source Line No.", lrec_Item."No.");
                            //HEI.51<<
                            //HEI.50<<
                            until InterfaceEntryLine.NEXT() = 0;
                    end else
                        ERROR(lTxt50002, lrec_purchHdr."No.");
                end else begin
                    lrec_PostedTransHdr.RESET();
                    lrec_PostedTransHdr.SETRANGE("Transfer Order No.", lrec_PurchHdrAdditional."TO Reference");
                    if lrec_PostedTransHdr.FINDFIRST() then
                        ERROR(lTxt50000, lrec_PurchHdrAdditional."TO Reference")
                    else
                        ERROR(lTxt50001, lrec_PurchHdrAdditional."TO Reference");
                end;
            end;
        end;
        if PostTransferShipment then begin
            if lrec_location.GET(lrec_TransLn."Transfer-from Code") then
                if lrec_location."Require Shipment" then begin
                    CreateAndPostTransferWhsShpmnt(lrec_TransHdr, InterfaceEntryHeader);
                    CreateAndPostTransferWhsReceipt(lrec_TransHdr, InterfaceEntryHeader);
                end;
        end;
        //HEI.27<<
    end;

    local procedure CreateAndPostTransferWhsShpmnt(var pTransferHeader: Record "Transfer Header"; InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        TransferLine: Record "Transfer Line";
        Location: Record Location;
        lrec_Item: Record Item;
        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
        WhsePostShipment: Codeunit "Whse.-Post Shipment";
        TOPostShipment: Codeunit "TransferOrder-Post Shipment";
        GetWhseShpNo: Code[20];
        lrec_PnPSetup: Record "Purchases & Payables Setup";
        lrec_Zone: Record Zone;
        Txt001: Label 'Warehouse Shipment does not exist for Source line No. %1 and Item code %2';
    begin
        //HEI.27>>
        lrec_PnPSetup.GET();
        lrec_PnPSetup.TESTFIELD("Zone Code for Import Proc. FND");

        CODEUNIT.RUN(CODEUNIT::"Release Transfer Document", pTransferHeader);

        WarehouseShipmentHeader.SETRANGE("Source No. FND", pTransferHeader."No.");
        //HEI.45>>
        //IF WarehouseShipmentHeader.FINDSET THEN
        //HEI.47>>
        if WarehouseShipmentHeader.FINDFIRST() then begin
            //IF NOT WarehouseShipmentHeader.ISEMPTY THEN BEGIN
            //HEI.47<<
            WarehouseShipmentLine.SETCURRENTKEY("Source No.", "Qty. Outstanding");
            WarehouseShipmentLine.SETRANGE("Source No.", pTransferHeader."No.");
            WarehouseShipmentLine.SETFILTER("Qty. Outstanding", '<>0');
            if WarehouseShipmentLine.ISEMPTY then
                //HEI.45<<
                WarehouseShipmentHeader.DELETE(true);
            //HEI.45>>
        end;
        //HEI.45<<

        // GetSourceDocOutbound.Fct_Batchprocessing(true); // BC Upgrade BHARDA11 ----Drink-IT Function(Fct_Batchprocessing)
        GetSourceDocOutbound.CreateFromOutbndTransferOrderHideDialog(pTransferHeader);

        WarehouseShipmentLine.RESET();
        WarehouseShipmentLine.SETRANGE("Source No.", pTransferHeader."No.");
        if WarehouseShipmentLine.FINDFIRST() then
            GetWhseShpNo := WarehouseShipmentLine."No.";

        if WarehouseShipmentHeader.GET(GetWhseShpNo) then begin
            WarehouseShipmentHeader.LOCKTABLE();
            //HEI.41>>
            WarehouseShipmentHeader."Posting Date" := InterfaceEntryHeader."Posting Date";
            WarehouseShipmentHeader.MODIFY();
            //HEI.41<<
            WarehouseShipmentLine.RESET();
            WarehouseShipmentLine.SETRANGE("No.", WarehouseShipmentHeader."No.");
            if WarehouseShipmentLine.findset() then
                repeat
                    WarehouseShipmentLine.VALIDATE("Qty. to Ship", 0);
                    WarehouseShipmentLine.MODIFY();
                until WarehouseShipmentLine.NEXT() = 0;
        end;

        InterfaceEntryLine.RESET();
        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.findset() then
            repeat
                if lrec_Item.GET(GetNoFromMaximoNo(InterfaceEntryLine."No.")) then;
                WarehouseShipmentLine.RESET();
                WarehouseShipmentLine.SETRANGE("No.", WarehouseShipmentHeader."No.");
                //HEI.45>>
                //HEI.47>>
                //WarehouseShipmentLine.SETRANGE("Line No.",InterfaceEntryLine."Source Line No.");
                WarehouseShipmentLine.SETRANGE("Source Line No.", InterfaceEntryLine."Source Line No.");
                //HEI.47<<
                //HEI.45<<
                WarehouseShipmentLine.SETRANGE("Item No.", lrec_Item."No.");
                //HEI.50>>
                //IF WarehouseShipmentLine.FINDSET THEN REPEAT
                if WarehouseShipmentLine.findset(true) then begin
                    repeat
                        //HEI.50<<
                        WarehouseShipmentLine.VALIDATE("Qty. to Ship", InterfaceEntryLine.Quantity);
                        if lrec_PnPSetup.GET() then begin
                            lrec_Zone.RESET();
                            lrec_Zone.SETRANGE("Location Code", WarehouseShipmentLine."Location Code");//HEI.50
                            lrec_Zone.SETRANGE(Code, lrec_PnPSetup."Zone Code for Import Proc. FND");
                            if lrec_Zone.FINDFIRST() then begin
                                WarehouseShipmentLine.VALIDATE("Zone Code", lrec_Zone.Code);
                                WarehouseShipmentLine.VALIDATE("Bin Code", lrec_Zone."Default Receipt Bin Code FND");
                            end;
                        end;
                        WarehouseShipmentLine.MODIFY();
                    until WarehouseShipmentLine.NEXT() = 0;
                    //HEI.50>>
                end else
                    ERROR(Txt001, InterfaceEntryLine."Source Line No.", lrec_Item."No.");
            //HEI.50<<
            until InterfaceEntryLine.NEXT() = 0;
        WarehouseShipmentLine.RESET();
        WarehouseShipmentLine.SETRANGE("No.", WarehouseShipmentHeader."No.");
        WhsePostShipment.RUN(WarehouseShipmentLine);
        //END;
        //HEI.27<<
    end;

    local procedure CreateAndPostTransferWhsReceipt(var pTransferHeader: Record "Transfer Header"; InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        TransferLine: Record "Transfer Line";
        Location: Record Location;
        ItemTrackingCode: Record "Item Tracking Code";
        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
        WhsePostReceipt: Codeunit "Whse.-Post Receipt";
        TOPostReceipt: Codeunit "TransferOrder-Post Receipt";
        TotalQtyfromFile: Decimal;
        GetWhseRcptNo: Code[20];
        ReleaseTransferDoc: Codeunit "Release Transfer Document";
        ShipNotDone: Label 'Receipt impossible because shipment not done before.';
        lrec_Item: Record Item;
        lrec_Zone: Record Zone;
        Txt001: Label 'Warehouse Receipt does not exist for Source line No. %1 and Item code %2';
    begin
        //>>HEI.27
        if not CanBeReceived(pTransferHeader) then
            ERROR(ShipNotDone);
        //HEi.50>>
        WarehouseReceiptHeader.SETRANGE("Source No. FND", pTransferHeader."No.");
        if WarehouseReceiptHeader.FINDFIRST() then begin
            //HEI.50<<
            //Delete Warehouse Rcpt if exists
            WarehouseReceiptLine.RESET();
            WarehouseReceiptLine.SETCURRENTKEY("Source No.", "Qty. Outstanding");//HEI.50
            WarehouseReceiptLine.SETRANGE("Source No.", pTransferHeader."No.");
            WarehouseReceiptLine.SETFILTER("Qty. Outstanding", '<>0');//HEI.50
                                                                      //IF WarehouseReceiptLine.FINDFIRST THEN BEGIN//HEI.50
                                                                      //HEI.45>>
                                                                      //IF WarehouseReceiptHeader.GET(WarehouseReceiptLine."No.") THEN
                                                                      //IF WarehouseReceiptHeader.GET(WarehouseReceiptLine."No.") THEN BEGIN//HEI.50
                                                                      //WarehouseReceiptLine.SETFILTER("Qty. Outstanding",'<>0');//HEI.50
            if WarehouseReceiptLine.ISEMPTY then
                //HEI.45<<
                WarehouseReceiptHeader.DELETE(true);
            //HEI.45>>
        end;
        //HEI.45<<
        //END;//HEi.50

        GetSourceDocInbound.CreateFromInbndTransferOrderHideDialog(pTransferHeader);

        WarehouseReceiptLine.RESET();
        WarehouseReceiptLine.SETRANGE("Source No.", pTransferHeader."No.");
        if WarehouseReceiptLine.FINDFIRST() then
            GetWhseRcptNo := WarehouseReceiptLine."No.";

        //HEI.41>>
        if WarehouseReceiptHeader.GET(GetWhseRcptNo) then begin
            WarehouseReceiptHeader."Posting Date" := InterfaceEntryHeader."Posting Date";
            WarehouseReceiptHeader.MODIFY();
            //HEI.50>>
            WarehouseReceiptLine.RESET();
            WarehouseReceiptLine.SETRANGE("No.", WarehouseReceiptHeader."No.");
            if WarehouseReceiptLine.findset(true) then
                repeat
                    WarehouseReceiptLine.VALIDATE("Qty. to Receive", 0);
                    WarehouseReceiptLine.MODIFY();
                until WarehouseReceiptLine.NEXT() = 0;
            //HEI.50<<
        end;
        //HEI.41<<
        //
        InterfaceEntryLine.RESET();
        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.findset() then
            repeat
                if lrec_Item.GET(GetNoFromMaximoNo(InterfaceEntryLine."No.")) then;
                WarehouseReceiptLine.RESET();
                WarehouseReceiptLine.SETRANGE("No.", GetWhseRcptNo);
                //HEI.45>>
                //WarehouseReceiptLine.SETRANGE("Line No.",InterfaceEntryLine."Source Line No.");//HEi.50
                //HEI.45<<
                WarehouseReceiptLine.SETRANGE("Source Line No.", InterfaceEntryLine."Source Line No.");//HEI.50
                WarehouseReceiptLine.SETRANGE("Item No.", lrec_Item."No.");
                //HEI.50>>
                //IF WarehouseReceiptLine.FINDSET THEN REPEAT
                if WarehouseReceiptLine.findset(true) then begin
                    repeat
                        //HEI.50<<
                        lrec_Zone.RESET();
                        lrec_Zone.SETRANGE(Code, InterfaceEntryLine."Zone Code");
                        lrec_Zone.SETRANGE("Location Code", WarehouseReceiptLine."Location Code");//HEI.50
                        if lrec_Zone.FINDFIRST() then begin
                            WarehouseReceiptLine.VALIDATE("Zone Code", InterfaceEntryLine."Zone Code");
                            WarehouseReceiptLine.VALIDATE("Bin Code", lrec_Zone."Default Receipt Bin Code FND");
                            WarehouseReceiptLine.VALIDATE("Qty. to Receive", InterfaceEntryLine.Quantity);//HEI.50
                            WarehouseReceiptLine.MODIFY(true);
                        end;
                    until WarehouseReceiptLine.NEXT() = 0;
                    //HEI.50>>
                end else
                    ERROR(Txt001, InterfaceEntryLine."Source Line No.", lrec_Item."No.");
            //HEI.50<<
            until InterfaceEntryLine.NEXT() = 0;
        //
        /*
        WarehouseReceiptHeader.RESET;
        IF WarehouseReceiptHeader.GET(GetWhseRcptNo) THEN BEGIN
          WarehouseReceiptLine.RESET;
          WarehouseReceiptLine.SETRANGE("No.",WarehouseReceiptHeader."No.");
          IF WarehouseReceiptLine.FINDSET THEN REPEAT
          UNTIL WarehouseReceiptLine.NEXT = 0;
          */
        WarehouseReceiptLine.RESET();
        WarehouseReceiptLine.SETRANGE("No.", GetWhseRcptNo);
        WhsePostReceipt.SetHideValidationDialog(true);
        WhsePostReceipt.RUN(WarehouseReceiptLine);
        //END;
        //HEI.27<<

    end;

    local procedure CanBeReceived(TH: Record "Transfer Header"): Boolean;
    var
        TL: Record "Transfer Line";
    begin
        //HEI.27>>
        TL.RESET();
        TL.SETRANGE("Document No.", TH."No.");
        if TL.FINDFIRST() then
            repeat
                if TL."Quantity Shipped" > TL."Quantity Received" then
                    exit(true);
            until (TL.NEXT() = 0);
        exit(false);
        //HEI.27<<
    end;

    local procedure IsImportIdentifier(var PurchRcptLine: Record "Purch. Rcpt. Line"): Boolean;
    var
        PurchaseLine: Record "Purchase Line";
    begin
        //>> HEI.28
        PurchaseLine.SETRANGE("Order No.", PurchRcptLine."Document No.");
        PurchaseLine.SETRANGE("Order Line No.", PurchRcptLine."Line No.");
        if PurchaseLine.FINDFIRST() then
            PurchaseLine.CALCFIELDS("Import Identifier FND");
        exit(PurchaseLine."Import Identifier FND");
        //<< HEI.28
    end;

    local procedure UndoItemLedgerEntry(var PurchRcptLine: Record "Purch. Rcpt. Line"): Boolean;
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        //>> HEI.28
        ItemLedgerEntry.SETRANGE("Document No.", PurchRcptLine."Document No.");
        ItemLedgerEntry.SETRANGE("Posting Date", PurchRcptLine."Posting Date");
        ItemLedgerEntry.SETRANGE(Open, true);
        ItemLedgerEntry.SETFILTER("Remaining Quantity", '<>%1', 0);
        if ItemLedgerEntry.FINDFIRST() then
            exit(true)
        else
            exit(false);
        //<< HEI.28
    end;

    procedure CreatePurchRcptConfirmationResponse(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT"; InterfaceCode: Code[20]; ErrorOccurred: Boolean; ErrorMessage: Text);
    var
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        lText50000: Label 'Line processed successfully';
        lrec_PurchHdr: Record "Purchase Header";
        lrec_PurchLn: Record "Purchase Line";
    begin
        //HEI.30>>
        //Purchase Receipt Validation Response
        GetGeneralInterfaceSetup();
        InterfaceSetup.GET(InterfaceCode);
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut."Interface Code" := InterfaceCode;
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeader.Direction::Outbound;
        if ErrorOccurred then
            InterfaceEntryHeaderOut."Log Message" := COPYSTR(ErrorMessage, 1, MAXSTRLEN(InterfaceEntryHeader."Log Message"));

        InterfaceEntryHeaderOut."Message ID" := InterfaceEntryHeader."Message ID";
        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderOut."Msg. Sender Business System ID" := InterfaceEntryHeader."Msg. Recv. Business System ID";
        if InterfaceEntryHeaderOut."Msg. Sender Business System ID" = '' then
            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := InterfaceEntryHeader."Msg. Sender Business System ID";
        if lrec_PurchHdr.GET(lrec_PurchHdr."Document Type"::Order, InterfaceEntryHeader."Source No.") then
            InterfaceEntryHeaderOut."Location Code" := lrec_PurchHdr."Location Code";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.findset() then
            repeat
                CLEAR(InterfaceEntryLineOut);
                InterfaceEntryLineOut.TRANSFERFIELDS(InterfaceEntryLine, false);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
                InterfaceEntryLineOut."Source No." := InterfaceEntryHeader."Source No.";
                if lrec_PurchLn.GET(lrec_PurchLn."Document Type"::Order, InterfaceEntryHeader."Source No.", InterfaceEntryLineOut."Source Line No.") then
                    InterfaceEntryLineOut."Location Code" := lrec_PurchLn."Location Code";
                if ErrorOccurred then begin
                    InterfaceEntryLineOut."Log Message" := COPYSTR(ErrorMessage, 1, MAXSTRLEN(InterfaceEntryHeaderOut."Log Message"));
                    InterfaceEntryLineOut."E-Mail" := 'FAILED';
                end else begin
                    InterfaceEntryLineOut."Log Message" := lText50000;
                    InterfaceEntryLineOut."E-Mail" := 'SUCCESS';
                end;
                InterfaceEntryLineOut.INSERT(true);
            until InterfaceEntryLine.NEXT() = 0;

        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
        //HEI.30<<
    end;

    procedure ProcessMaximoPurchaseReceipt(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        InterfaceEntryLine: Record "Interface Entry Line INT";
    begin
        //HEI.30>>
        COMMIT();
        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        InterfaceEntryLine.FINDFIRST();
        case InterfaceEntryLine."Description 2" of
            'Receipt':
                ProcessPurchaseReceipt(InterfaceEntryHeader);
            'SHIPRECEIPT':
                ProcessTransferReceipt(InterfaceEntryHeader);
            'Return', 'VoidReceipt':
                ProcessPurchaseCancelReceipt(InterfaceEntryHeader);
            'Transfer':
                ProcessTransferShipmentReceipt(InterfaceEntryHeader);
        end;
        ERROR(SimulateModeErr);
        //HEI.30<<
    end;
}

