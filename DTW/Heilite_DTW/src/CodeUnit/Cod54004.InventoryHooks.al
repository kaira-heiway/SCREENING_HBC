codeunit 54004 "Inventory Hooks"
{
    // BC Upgrade BHARDA11 >>
    /* 1. This codeunit has been divided into three parts.
The first part, which is the main part, has been placed in the DTW extension.
The second part has been placed in the interface extension.
The third part, which will contain DotNet-related code, is currently pending. */
    /* 2. I have created an integration event OnBeforeRunProcessingInvHooks() in this codeunit, which I have called from the OnRun trigger of the codeunit.
I have also subscribed to the same event from the interface extension so that interface-related code can be executed here. */
    // 3. Old Codeunit ID is 50023
    // BC Upgrade BHARDA11 <<

    // BC Upgrade MISHRS14 >>
    // Blocked with statement and prefixed variable with Rec in Procedure-ProductionBOMHeaderOnAfterValidateNo
    // Blocked with statement and prefixed variable with Rec in Procedure-RoutingHeaderOnAfterValidateNo
    // Blocked with statement and prefixed variable with Rec in Procedure-ProductionBOMHeaderOnAfterValidateLinkedSKU
    // FINDSET Is being deprected so removed false due to warning in Procedure-Procedure-ProductionBOMHeaderOnAfterValidateLinkedSKU
    // Blocked with statement and prefixed variable with Rec in Procedure-RoutingHeaderOnAfterValidateLinkedSKU
    // FINDSET Is being deprected so removed false due to warning in Procedure-RoutingHeaderOnAfterValidateLinkedSKU
    // Blocked with statement and prefixed variable with Rec in Procedure-ProductionBOMHeaderOnModify
    // Blocked with statement and prefixed variable with Rec in Procedure-ProductionBOMHeaderOnAfterValidateStatus
    // FINDSET Is being deprected so removed false due to warning in Procedure-ProductionBOMHeaderOnAfterValidateStatus
    // Blocked with statement and prefixed variable with Rec in Procedure-RoutingHeaderOnAfterValidateStatus
    // FINDSET Is being deprected so removed false due to warning in Procedure-RoutingHeaderOnAfterValidateStatus
    // Blocked with statement and prefixed variable with Rec in Procedure-ProductionBOMHeaderOnAfterDeleteEvent
    // FINDSET Is being deprected so removed false due to warning in Procedure-ProductionBOMHeaderOnAfterDeleteEvent
    // Blocked with statement and prefixed variable with Rec in Procedure-RoutingHeaderOnAfterDeleteEvent
    // FINDSET Is being deprected so removed false due to warning in Procedure-RoutingHeaderOnAfterDeleteEvent
    // BC Upgrade MISHRS14 <<

    Permissions = TableData Item = rm, TableData "Stockkeeping Unit" = rm; // BC Upgrade BHARAD11 
    trigger OnRun();
    begin
        OnBeforeRunProcessingInvHooks(); // BC Upgrade BHARDA11
    end;

    [EventSubscriber(ObjectType::Table, Database::"Production BOM Header", 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure ProductionBOMHeaderOnAfterValidateNo(var Rec: Record "Production BOM Header"; var xRec: Record "Production BOM Header"; CurrFieldNo: Integer);
    var
        Item: Record Item;
        TotalCharCount: Integer;
        Itemno: Code[20];
    begin

        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variable with Rec
        // with Rec do begin
        //     if "No." <> '' then
        //         //HEI.08>>
        //         TotalCharCount := STRLEN("No.") - 7;
        //     if TotalCharCount <> 0 then
        //         Item.SETFILTER("No.", '%1', '*' + COPYSTR("No.", TotalCharCount))
        //     else
        //         Item.SETFILTER("No.", '%1', '*' + COPYSTR("No.", 3));
        //     //HEI.08<<
        //     if Item.FINDFIRST then
        //         "Linked Item No." := Item."No.";
        // end;

        //with Rec do begin
        if Rec."No." <> '' then
            //HEI.08>>
            TotalCharCount := STRLEN(Rec."No.") - 7;
        if TotalCharCount <> 0 then
            Item.SETFILTER("No.", '%1', '*' + COPYSTR(Rec."No.", TotalCharCount))
        else
            Item.SETFILTER("No.", '%1', '*' + COPYSTR(Rec."No.", 3));
        //HEI.08<<
        if Item.FINDFIRST then
            Rec."Linked Item No. FND" := Item."No.";
        //end;
        // BC Upgrade MISHRS14 <<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Routing Header", 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure RoutingHeaderOnAfterValidateNo(var Rec: Record "Routing Header"; var xRec: Record "Routing Header"; CurrFieldNo: Integer);
    var
        Item: Record Item;
        TotalCharCount: Integer;
        Itemno: Code[20];
    begin

        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variable with Rec
        // with Rec do begin
        //     if "No." <> '' then
        //         //HEI.08>>
        //         TotalCharCount := STRLEN("No.") - 7;
        //     if TotalCharCount <> 0 then
        //         Item.SETFILTER("No.", '%1', '*' + COPYSTR("No.", TotalCharCount))
        //     else
        //         Item.SETFILTER("No.", '%1', '*' + COPYSTR("No.", 3));
        //     //HEI.08<<
        //     if Item.FINDFIRST then
        //         "Linked Item No." := Item."No.";
        // end;

        //with Rec do begin
        if Rec."No." <> '' then
            //HEI.08>>
            TotalCharCount := STRLEN(Rec."No.") - 7;
        if TotalCharCount <> 0 then
            Item.SETFILTER("No.", '%1', '*' + COPYSTR(Rec."No.", TotalCharCount))
        else
            Item.SETFILTER("No.", '%1', '*' + COPYSTR(Rec."No.", 3));
        //HEI.08<<
        if Item.FINDFIRST then
            Rec."Linked Item No. FND" := Item."No.";
        //end;
        // BC Upgrade MISHRS14 <<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Production BOM Header", 'OnAfterValidateEvent', 'Linked SKU FND', false, false)]
    local procedure ProductionBOMHeaderOnAfterValidateLinkedSKU(var Rec: Record "Production BOM Header"; var xRec: Record "Production BOM Header"; CurrFieldNo: Integer);
    var
        StockkeepingUnit: Record "Stockkeeping Unit";
        Text001: Label 'You cannot update %1 when status is closed';
    begin
        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variable with Rec
        //with Rec do begin
        //HEI.13>>
        if (Rec.Status = Rec.Status::Closed) then
            ERROR(Text001, Rec.FIELDNAME("Linked SKU FND"));
        //HEI.13<<
        if Rec."Linked SKU FND" <> xRec."Linked SKU FND" then begin
            if Rec."Linked SKU FND" <> '' then begin
                StockkeepingUnit.SETRANGE("Item No.", Rec."Linked Item No. FND");
                StockkeepingUnit.SETRANGE("Location Code", Rec."Linked SKU FND");
                //if StockkeepingUnit.FINDSET(true, false) then

                // BC Upgrade MISHRS14 >>
                // FINDSET Is being deprected so removed false due to warning
                if StockkeepingUnit.FINDSET(true) then
                    // BC Upgrade MISHRS14 <<

                        repeat
                            StockkeepingUnit.VALIDATE("Production BOM No.", Rec."No.");
                            StockkeepingUnit.MODIFY(true);
                    until StockkeepingUnit.NEXT = 0;
            end;
            if xRec."Linked SKU FND" <> '' then begin
                StockkeepingUnit.SETRANGE("Location Code", xRec."Linked SKU FND");
                StockkeepingUnit.SETRANGE("Item No.", Rec."Linked Item No. FND"); //HEI.10
                                                                              //if StockkeepingUnit.FINDSET(true, false) then

                // BC Upgrade MISHRS14 >>
                // FINDSET Is being deprected so removed false due to warning
                if StockkeepingUnit.FINDSET(true) then
                    // BC Upgrade MISHRS14 <<

                        repeat
                            //HEI.13>>
                            //StockkeepingUnit.VALIDATE("Production BOM No.",'');
                            StockkeepingUnit."Production BOM No." := '';
                            //HEI.13<<
                            StockkeepingUnit.MODIFY(true);
                    until StockkeepingUnit.NEXT = 0;
            end;
        end;
        //end;
        // BC Upgrade MISHRS14 <<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Routing Header", 'OnAfterValidateEvent', 'Linked SKU FND', false, false)]
    local procedure RoutingHeaderOnAfterValidateLinkedSKU(var Rec: Record "Routing Header"; var xRec: Record "Routing Header"; CurrFieldNo: Integer);
    var
        StockkeepingUnit: Record "Stockkeeping Unit";
        Text001: Label 'You cannot update %1 when status is closed';
    begin
        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variable with Rec
        //with Rec do begin
        //HEI.13>>
        if (Rec.Status = Rec.Status::Closed) then
            ERROR(Text001, Rec.FIELDNAME("Linked SKU FND"));
        //HEI.13<<
        if Rec."Linked SKU FND" <> xRec."Linked SKU FND" then begin
            if Rec."Linked SKU FND" <> '' then begin
                StockkeepingUnit.SETRANGE("Item No.", Rec."Linked Item No. FND");
                StockkeepingUnit.SETRANGE("Location Code", Rec."Linked SKU FND");

                // BC Upgrade MISHRS14 >>
                // FINDSET Is being deprected so removed false due to warning
                //if StockkeepingUnit.FINDSET(true, false) then
                if StockkeepingUnit.FINDSET(true) then
                    // BC Upgrade MISHRS14 <<
                        repeat
                            StockkeepingUnit.VALIDATE("Routing No.", Rec."No.");
                            StockkeepingUnit.MODIFY(true);
                    until StockkeepingUnit.NEXT = 0;
            end;
            if xRec."Linked SKU FND" <> '' then begin
                StockkeepingUnit.SETRANGE("Location Code", xRec."Linked SKU FND");
                StockkeepingUnit.SETRANGE("Item No.", Rec."Linked Item No. FND"); //HEI.10

                // BC Upgrade MISHRS14 >>
                // FINDSET Is being deprected so removed false due to warning
                //if StockkeepingUnit.FINDSET(true, false) then
                if StockkeepingUnit.FINDSET(true) then
                    // BC Upgrade MISHRS14 <<

                        repeat
                            //HEI.13>>
                            //StockkeepingUnit.VALIDATE("Routing No.",'');
                            StockkeepingUnit."Routing No." := '';
                            //HEI.13<<
                            StockkeepingUnit.MODIFY(true);
                    until StockkeepingUnit.NEXT = 0;
            end;
        end;
        //end;
        // BC Upgrade MISHRS14 <<
    end;

    local procedure UpdateHistory();
    var
        ProductionBOMHeader: Record "Production BOM Header";
        RoutingHeader: Record "Routing Header";
        Item: Record Item;
        SKU: Record "Stockkeeping Unit";
    begin
        if ProductionBOMHeader.FINDSET then
            repeat
                SKU.SETRANGE("Item No.", ProductionBOMHeader."Linked Item No. FND");
                SKU.SETRANGE("Production BOM No.", ProductionBOMHeader."No.");
                if SKU.FINDFIRST then begin
                    ProductionBOMHeader."Linked SKU FND" := SKU."Production BOM No.";
                    ProductionBOMHeader.MODIFY;
                end;
            until ProductionBOMHeader.NEXT = 0;

        SKU.RESET;
        if RoutingHeader.FINDSET then
            repeat
                SKU.SETRANGE("Item No.", RoutingHeader."Linked Item No. FND");
                SKU.SETRANGE("Routing No.", RoutingHeader."No.");
                if SKU.FINDFIRST then begin
                    RoutingHeader."Linked SKU FND" := SKU."Routing No.";
                    RoutingHeader.MODIFY;
                end;
            until RoutingHeader.NEXT = 0;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Unit of Measure", 'OnAfterInsertEvent', '', false, false)]
    local procedure ItemUoMOnAfterInsert(var Rec: Record "Item Unit of Measure"; RunTrigger: Boolean);
    var
        Item: Record Item;
        InventorySetup: Record "Inventory Setup";
    begin
        //HEI.02>>
        if Rec.ISTEMPORARY then
            exit;

        InventorySetup.GET;
        // BC Upgrade BHARDA11 >> ----Drink-IT Field("Volume Unit of Measure Code")
        // if (Rec.Code = InventorySetup."Volume Unit of Measure Code") and
        //    (Rec."Qty. per Unit of Measure" <> 1)
        // then begin
        //     Item.GET(Rec."Item No.");
        //     Item.VALIDATE("Volume Unit of Measure Code", Rec.Code);
        //     Item.MODIFY;
        // end;
        // BC Upgrade BHARDA11 << ----Drink-IT Field("Volume Unit of Measure Code")

        //HEI.02<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Unit of Measure", 'OnAfterModifyEvent', '', false, false)]
    local procedure ItemUoMOnAfterModify(var Rec: Record "Item Unit of Measure"; var xRec: Record "Item Unit of Measure"; RunTrigger: Boolean);
    var
        Item: Record Item;
        InventorySetup: Record "Inventory Setup";
    begin
        //HEI.02>>
        if Rec.ISTEMPORARY then
            exit;
        // BC Upgrade BHARDA11 >> ----Drink-IT Field("Volume Unit of Measure Code")
        // InventorySetup.GET;
        // if (Rec.Code = InventorySetup."Volume Unit of Measure Code") and
        //    (Rec."Qty. per Unit of Measure" <> 1)
        // then begin
        //     Item.GET(Rec."Item No.");
        //     if Item."Volume Unit of Measure Code" <> Rec.Code then begin
        //         Item.VALIDATE("Volume Unit of Measure Code", Rec.Code);
        //         Item.MODIFY;
        //     end;
        // end;
        // BC Upgrade BHARDA11 << ----Drink-IT Field("Volume Unit of Measure Code")

        //HEI.02<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Unit of Measure", 'OnAfterRenameEvent', '', false, false)]
    local procedure ItemUoMOnAfterRename(var Rec: Record "Item Unit of Measure"; var xRec: Record "Item Unit of Measure"; RunTrigger: Boolean);
    var
        Item: Record Item;
        InventorySetup: Record "Inventory Setup";
    begin
        //HEI.02>>
        if Rec.ISTEMPORARY then
            exit;
        // BC Upgrade BHARDA11 >> ----Drink-IT Field("Volume Unit of Measure Code")
        // InventorySetup.GET;
        // if Rec.Code = InventorySetup."Volume Unit of Measure Code" then begin
        //     Item.GET(Rec."Item No.");
        //     Item.VALIDATE("Volume Unit of Measure Code", Rec.Code);
        //     Item.MODIFY;
        // end else
        //     if xRec.Code = InventorySetup."Volume Unit of Measure Code" then begin
        //         Item.GET(Rec."Item No.");
        //         Item.VALIDATE("Volume Unit of Measure Code", '');
        //         Item.MODIFY;
        //     end;
        // BC Upgrade BHARDA11 << ----Drink-IT Field("Volume Unit of Measure Code")

        //HEI.02<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Unit of Measure", 'OnBeforeDeleteEvent', '', false, false)]
    local procedure ItemUoMOnBeforeDelete(var Rec: Record "Item Unit of Measure"; RunTrigger: Boolean);
    var
        Item: Record Item;
        InventorySetup: Record "Inventory Setup";
    begin
        //HEI.02>>
        if Rec.ISTEMPORARY then
            exit;
        // BC Upgrade BHARDA11 >> ----Drink-IT Field("Volume Unit of Measure Code")
        // InventorySetup.GET;
        // if Rec.Code = InventorySetup."Volume Unit of Measure Code" then begin
        //     Item.GET(Rec."Item No.");
        //     if Item."Base Unit of Measure" <> Rec.Code then begin
        //         Item.VALIDATE("Volume Unit of Measure Code", '');
        //         Item.MODIFY;
        //     end;
        // end;
        // BC Upgrade BHARDA11 << ----Drink-IT Field("Volume Unit of Measure Code")

        //HEI.02<<
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'Base Unit of Measure', false, false)]
    local procedure ItemOnAfterValidateBaseUoM(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer);
    var
        InventorySetup: Record "Inventory Setup";
    begin
        //HEI.02>>
        if Rec.ISTEMPORARY then
            exit;
        // BC Upgrade BHARDA11 >> ----Drink-IT Field("Volume Unit of Measure Code")
        // InventorySetup.GET;
        // if Rec."Base Unit of Measure" = InventorySetup."Volume Unit of Measure Code" then
        //     Rec.VALIDATE("Volume Unit of Measure Code", Rec."Base Unit of Measure")
        // else
        //     if (Rec."Base Unit of Measure" = '') and (xRec."Base Unit of Measure" = InventorySetup."Volume Unit of Measure Code") then
        //         Rec.VALIDATE("Volume Unit of Measure Code", '');
        // BC Upgrade BHARDA11 << ----Drink-IT Field("Volume Unit of Measure Code")

        //HEI.02<<

    end;

    [EventSubscriber(ObjectType::Table, Database::"Stockkeeping Unit", 'OnBeforeValidateEvent', 'Phys Invt Counting Period Code', false, false)]
    local procedure T5700OnBeforeValidatePhysInvtCountingPeriod(var Rec: Record "Stockkeeping Unit"; var xRec: Record "Stockkeeping Unit"; CurrFieldNo: Integer);
    var
        SessionGlobals: Codeunit "Session Globals";
    begin
        //HEI.03>>
        if not GUIALLOWED then
            Rec.SetHideValidationDialog(SessionGlobals.GetHideValidationDialog);
        //HEI.03<<
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'No. 2', false, false)]
    local procedure T27OnAfterValidateNo2(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer);
    var
        Item: Record Item;
        CommonSourceSharingSetup: Record "Common Src Sharing Setup FND";
        GlobalSharedSource: Record "Global Shared Source FND";
    begin
        //HEI.05>>
        if (Rec."No. 2" = xRec."No. 2") or
           (Rec."No. 2" = '')
        then
            exit;
        //>> HEI.13
        if CommonSourceSharingSetup.GET then
            if CommonSourceSharingSetup."Enable Common Item Sharing" then begin
                GlobalSharedSource.RESET;
                GlobalSharedSource.SETRANGE("Source Type", GlobalSharedSource."Source Type"::Item);
                GlobalSharedSource.SETRANGE("Global ID", Rec."No.");
                GlobalSharedSource.SETRANGE("Local ID", Rec."No.");
                GlobalSharedSource.SETRANGE("Company ID", COMPANYNAME);
                GlobalSharedSource.SETRANGE(Blocked, false);
                if GlobalSharedSource.FINDFIRST then
                    ERROR(GlobalItemNoExistsErr, Item."No. 2", Item."No.")
                else
                    exit;
            end;
        //<< HEI.13

        Item.SETRANGE("No. 2", Rec."No. 2");
        if Item.FINDFIRST then
            ERROR(GlobalItemNoExistsErr, Item."No. 2", Item."No.");
        //HEI.05<<
    end;



    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'RPM Solution FND', false, false)]
    local procedure T27OnAfterValidateRpmSolution(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer);
    var
        Text001: Label '%1 must not be blank';
        SalesReceivablesSetupL: Record "Sales & Receivables Setup";
    begin
        //HEI.06>>
        if xRec."RPM Solution FND" <> Rec."RPM Solution FND" then
            T27CheckFields(Rec.FIELDNO("RPM Solution FND"), Rec.FIELDCAPTION("RPM Solution FND"), Rec);

        //HEI.18>>
        //IF Rec."Item Type" <> Rec."Item Type"::"RPM Related" THEN
        //Rec.TESTFIELD("RPM Solution",Rec."RPM Solution"::" ")
        //ELSE
        //IF Rec."RPM Solution" = Rec."RPM Solution"::" " THEN
        //ERROR(Text001,Rec.FIELDCAPTION("RPM Solution"));

        SalesReceivablesSetupL.GET;
        if STRPOS(SalesReceivablesSetupL."RPMRelatedItemCategoryCode FND", Rec."Item Category Code") = 0 then begin
            if Rec."Item Type FND" <> Rec."Item Type FND"::"RPM Related" then
                Rec.TESTFIELD("RPM Solution FND", Rec."RPM Solution FND"::" ")
            else begin
                if Rec."RPM Solution FND" = Rec."RPM Solution FND"::" " then
                    ERROR(Text001, Rec.FIELDCAPTION("RPM Solution FND"));
            end;
        end;
        //HEI.18<<
        //HEI.06<<

        UpdateSKU(Rec);
    end;



    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'Item Type FND', false, false)]
    local procedure T27OnAfterValidateItemType(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer);
    begin
        //HEI.06>>
        if Rec.ISTEMPORARY then
            exit;

        if Rec."Item Type FND" <> xRec."Item Type FND" then
            T27CheckFields(Rec.FIELDNO("Item Type FND"), Rec.FIELDCAPTION("Item Type FND"), Rec);

        if Rec."Item Type FND" <> Rec."Item Type FND"::"RPM Related" then begin
            Rec.VALIDATE("RPM Solution FND", Rec."RPM Solution FND"::" ");
            Rec.VALIDATE("RPM Type FND", '');
            UpdateSKU(Rec)
        end;
        //HEI.06<<
    end;

    local procedure UpdateSKU(Item: Record Item);
    var
        StockkeepingUnit: Record "Stockkeeping Unit";
    begin
        StockkeepingUnit.RESET();
        StockkeepingUnit.SETRANGE("Item No.", Item."No.");
        if StockkeepingUnit.FINDSET() then
            repeat
                StockkeepingUnit.VALIDATE("Item Type FND", Item."Item Type FND");
                StockkeepingUnit.VALIDATE("RPM Solution FND", Item."RPM Solution FND");
                StockkeepingUnit.VALIDATE("RPM Type FND", Item."RPM Type FND");
                StockkeepingUnit.MODIFY();
            until StockkeepingUnit.NEXT() = 0;
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'RPM Type FND', false, false)]
    local procedure T27OnAfterValidateRpmType(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer);
    begin
        if xRec."RPM Type FND" <> Rec."RPM Type FND" then
            T27CheckFields(Rec.FIELDNO("RPM Type FND"), Rec.FIELDCAPTION("RPM Type FND"), Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Stockkeeping Unit", 'OnAfterValidateEvent', 'Item Type FND', false, false)]
    local procedure T5700OnAfterValidateItemType(var Rec: Record "Stockkeeping Unit"; var xRec: Record "Stockkeeping Unit"; CurrFieldNo: Integer);
    begin
        if xRec."Item Type FND" = Rec."Item Type FND" then
            exit;

        T5700CheckFields(Rec.FIELDNO("Item Type FND"), Rec.FIELDCAPTION("Item Type FND"), Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Stockkeeping Unit", 'OnAfterValidateEvent', 'RPM Type FND', false, false)]
    local procedure T5700OnAfterValidateRpmType(var Rec: Record "Stockkeeping Unit"; var xRec: Record "Stockkeeping Unit"; CurrFieldNo: Integer);
    begin
        if xRec."RPM Type FND" = Rec."RPM Type FND" then
            exit;
        T5700CheckFields(Rec.FIELDNO("RPM Type FND"), Rec.FIELDCAPTION("RPM Type FND"), Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Stockkeeping Unit", 'OnAfterValidateEvent', 'RPM Solution FND', false, false)]
    local procedure T5700OnAfterValidateRpmSolution(var Rec: Record "Stockkeeping Unit"; var xRec: Record "Stockkeeping Unit"; CurrFieldNo: Integer);
    begin
        if xRec."RPM Solution FND" = Rec."RPM Solution FND" then
            exit;
        T5700CheckFields(Rec.FIELDNO("RPM Solution FND"), Rec.FIELDCAPTION("RPM Solution FND"), Rec);
    end;

    local procedure T5700CheckSalesLine(CurrFieldNo: Integer; StockkeepingUnit: Record "Stockkeeping Unit");
    var
        SalesLine: Record "Sales Line";
        Text001: TextConst ENU = 'There may be orders and open ledger entries for the item. ', FRA = 'Il existe probablement des écritures comptables ouvertes et des ordres pour cet article. ';
        CannotChangeFieldErr: TextConst Comment = '%1 = Field Caption, %2 = Item Table Name, %3 = Item No., %4 = Table Name', ENU = 'You cannot change the %1 field on %2 %3 because at least one %4 exists for this item.';
    begin
        //HEI.05>>
        SalesLine.SETCURRENTKEY(Type, "No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        SalesLine.SETRANGE("No.", StockkeepingUnit."Item No.");
        if SalesLine.FINDFIRST() then begin
            if CurrFieldNo = 0 then
                ERROR(Text001, StockkeepingUnit.TABLECAPTION, StockkeepingUnit."Item No.", SalesLine."Document Type");
            if CurrFieldNo = StockkeepingUnit.FIELDNO("RPM Solution FND") then
                ERROR(CannotChangeFieldErr, StockkeepingUnit.FIELDCAPTION("RPM Solution FND"), StockkeepingUnit.TABLECAPTION, StockkeepingUnit."Item No.", SalesLine.TABLECAPTION);
            if CurrFieldNo = StockkeepingUnit.FIELDNO("RPM Type FND") then
                ERROR(CannotChangeFieldErr, StockkeepingUnit.FIELDCAPTION("RPM Type FND"), StockkeepingUnit.TABLECAPTION, StockkeepingUnit."Item No.", SalesLine.TABLECAPTION);
            if CurrFieldNo = StockkeepingUnit.FIELDNO("Item Type FND") then
                ERROR(CannotChangeFieldErr, StockkeepingUnit.FIELDCAPTION("Item Type FND"), StockkeepingUnit.TABLECAPTION, StockkeepingUnit."Item No.", SalesLine.TABLECAPTION);
        end;
        //HEI.05<<
    end;

    local procedure T5700CheckFields(FieldNo: Integer; FieldsCaption: Text; StockkeepingUnit: Record "Stockkeeping Unit");
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        Text007: Label 'You cannot change %1 because there are one or more ledger entries for this item.';
    begin
        T5700CheckSalesLine(FieldNo, StockkeepingUnit);
        ItemLedgEntry.SETCURRENTKEY("Item No.");
        ItemLedgEntry.SETRANGE("Item No.", StockkeepingUnit."Item No.");
        if not ItemLedgEntry.ISEMPTY then
            ERROR(
              Text007,
              FieldsCaption);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Stockkeeping Unit", 'OnBeforeModifyEvent', '', false, false)]
    local procedure T5700OnBeforeModify(var Rec: Record "Stockkeeping Unit"; var xRec: Record "Stockkeeping Unit"; RunTrigger: Boolean);
    var
        StdCostAgingInfo: Record "Standard Cost Aging Info FND";
        SKU: Record "Stockkeeping Unit";
    begin
        //HEI.18>>
        if Rec.ISTEMPORARY then
            exit;

        if SKU.GET(Rec."Location Code", Rec."Item No.", Rec."Variant Code") then
            if Rec."Standard Cost" <> SKU."Standard Cost" then
                StdCostAgingInfo.CreateLogEntry(Rec, SKU);//HEI.20
        //HEI.18<<
    end;

    local procedure T27CheckSalesLine(CurrFieldNo: Integer; Item: Record Item);
    var
        SalesLine: Record "Sales Line";
        Text001: TextConst ENU = 'There may be orders and open ledger entries for the item. ', FRA = 'Il existe probablement des écritures comptables ouvertes et des ordres pour cet article. ';
        CannotChangeFieldErr: TextConst Comment = '%1 = Field Caption, %2 = Item Table Name, %3 = Item No., %4 = Table Name', ENU = 'You cannot change the %1 field on %2 %3 because at least one %4 exists for this item.';
    begin
        //HEI.05>>
        SalesLine.SETCURRENTKEY(Type, "No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        SalesLine.SETRANGE("No.", Item."No.");
        if SalesLine.FINDFIRST() then begin
            if CurrFieldNo = 0 then
                ERROR(Text001, Item.TABLECAPTION, Item."No.", SalesLine."Document Type");
            if CurrFieldNo = Item.FIELDNO("RPM Solution FND") then
                ERROR(CannotChangeFieldErr, Item.FIELDCAPTION("RPM Solution FND"), Item.TABLECAPTION, Item."No.", SalesLine.TABLECAPTION);
            if CurrFieldNo = Item.FIELDNO("RPM Type FND") then
                ERROR(CannotChangeFieldErr, Item.FIELDCAPTION("RPM Type FND"), Item.TABLECAPTION, Item."No.", SalesLine.TABLECAPTION);
            if CurrFieldNo = Item.FIELDNO("Item Type FND") then
                ERROR(CannotChangeFieldErr, Item.FIELDCAPTION("Item Type FND"), Item.TABLECAPTION, Item."No.", SalesLine.TABLECAPTION);
        end;
        //HEI.05<<
    end;

    local procedure T27CheckFields(FieldNo: Integer; FieldsCaption: Text; Item: Record Item);
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        Text007: Label 'You cannot change %1 because there are one or more ledger entries for this item.';
    begin
        T27CheckSalesLine(FieldNo, Item);
        ItemLedgEntry.SETCURRENTKEY("Item No.");
        ItemLedgEntry.SETRANGE("Item No.", Item."No.");
        if not ItemLedgEntry.ISEMPTY then
            ERROR(
              Text007,
              FieldsCaption);
    end;



    [EventSubscriber(ObjectType::Table, Database::"Production BOM Header", 'OnAfterValidateEvent', 'Unit of Measure Code', false, false)]
    procedure ProductionBOMHeaderOnModify(var Rec: Record "Production BOM Header"; var xRec: Record "Production BOM Header"; CurrFieldNo: Integer);
    var
        ProductionBOMHeader: Record "Production BOM Header";
    begin
        //HEI.08>>

        // BC Upgrade MISHRS14 >>
        // Blocked with statement due to warning
        // with Rec do begin
        //     if "No." <> '' then
        //         if Rec."Unit of Measure Code" <> '' then begin
        //             Rec."Unit of Measure Code" := Rec."Unit of Measure Code";
        //             Rec.MODIFY;
        //             COMMIT;
        //         end;
        // end;

        // with Rec do begin
        if Rec."No." <> '' then
            if Rec."Unit of Measure Code" <> '' then begin
                Rec."Unit of Measure Code" := Rec."Unit of Measure Code";
                Rec.MODIFY;
                COMMIT;
            end;
        //end;
        // BC Upgrade MISHSR14 <<
        //HEI.08>>
    end;

    [EventSubscriber(ObjectType::Table, Database::"Production BOM Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure ProductionBOMLineOnAfterInsert(var Rec: Record "Production BOM Line"; RunTrigger: Boolean);
    begin
        //>> HEI.09 Defect 4550 IBM.GUNERE01 09.10.2019
        if Rec.ISTEMPORARY then
            exit;

        TestRepeatItem(Rec);
        //<< HEI.09 Defect 4550 IBM.GUNERE01 09.10.2019
    end;

    [EventSubscriber(ObjectType::Table, Database::"Production BOM Line", 'OnAfterModifyEvent', '', false, false)]
    local procedure ProductionBOMLineOnAfterModify(var Rec: Record "Production BOM Line"; var xRec: Record "Production BOM Line"; RunTrigger: Boolean);
    begin
        //>> HEI.09 Defect 4550 IBM.GUNERE01 09.10.2019
        if Rec.ISTEMPORARY then
            exit;

        TestRepeatItem(Rec);
        //<< HEI.09 Defect 4550 IBM.GUNERE01 09.10.2019
    end;

    local procedure TestRepeatItem(var ProductionBOMLine: Record "Production BOM Line");
    var
        ProdBOMLine: Record "Production BOM Line";
        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
        ItemAttributeValue: Record "Item Attribute Value";
        BOMLineRepeatItemErr: Label 'The Item No %1 already exists in BOM';
    begin
        //>> HEI.09 Defect 4550 IBM.GUNERE01 09.10.2019
        GetManufacturingSetup; // HEI.09 Defect 4550 IBM.GUNERE01 09.10.2019
        ProdBOMLine.RESET;
        ProdBOMLine.SETRANGE("Production BOM No.", ProductionBOMLine."Production BOM No.");
        ProdBOMLine.SETRANGE("Version Code", ProductionBOMLine."Version Code");
        ProdBOMLine.SETRANGE("No.", ProductionBOMLine."No.");
        ProdBOMLine.SETFILTER("Line No.", '<>%1', ProductionBOMLine."Line No."); // HEI.09 Defect 4550 IBM.GUNERE01 09.10.2019
        if ProdBOMLine.FIND('-') then begin
            ItemAttributeValueMapping.RESET;
            ItemAttributeValueMapping.SETRANGE("Table ID", DATABASE::Item);
            ItemAttributeValueMapping.SETRANGE("No.", ProductionBOMLine."No.");
            if ItemAttributeValueMapping.FINDSET then begin
                ItemAttributeValue.SETRANGE("Attribute ID", ItemAttributeValueMapping."Item Attribute ID");
                ItemAttributeValue.SETRANGE(ID, ItemAttributeValueMapping."Item Attribute Value ID");
                //>> HEI.09 Defect 4550 IBM.GUNERE01 09.10.2019
                //ItemAttributeValue.SETRANGE(Value,'CMG0418');
                if ManufacturingSetup."Item Attri Value Filter FND" <> '' then
                    //ItemAttributeValue.SETFILTER(Value,'%1',ManufacturingSetup."Item Attribute Value Filter");
                    ItemAttributeValue.SETFILTER(Value, ManufacturingSetup."Item Attri Value Filter FND");
                //<< HEI.09 Defect 4550 IBM.GUNERE01 09.10.2019
                if not ItemAttributeValue.FIND('-') then
                    ERROR(BOMLineRepeatItemErr, ProductionBOMLine."No.");
            end else
                ERROR(BOMLineRepeatItemErr, ProductionBOMLine."No.");
        end;
        //<< HEI.09 Defect 4550 IBM.GUNERE01 09.10.2019
    end;

    local procedure GetManufacturingSetup();
    begin
        //>> HEI.09 Defect 4550 IBM.GUNERE01 09.10.2019
        if not ManufacturingSetupGot then
            if ManufacturingSetup.GET then;
        ManufacturingSetupGot := true
        //<< HEI.09 Defect 4550 IBM.GUNERE01 09.10.2019
    end;



    [EventSubscriber(ObjectType::Table, Database::"Production BOM Header", 'OnAfterValidateEvent', 'Status', false, false)]
    local procedure ProductionBOMHeaderOnAfterValidateStatus(var Rec: Record "Production BOM Header"; var xRec: Record "Production BOM Header"; CurrFieldNo: Integer);
    var
        StockkeepingUnit: Record "Stockkeeping Unit";
    begin
        //HEI.13>>

        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variable with Rec.
        // with Rec do begin
        //     if (xRec.Status <> Status) and (Status = Status::Closed) then begin
        //         StockkeepingUnit.SETRANGE("Location Code", "Linked SKU");
        //         StockkeepingUnit.SETRANGE("Item No.", "Linked Item No.");
        //         if StockkeepingUnit.FINDSET(true, false) then
        //             repeat
        //                 StockkeepingUnit."Production BOM No." := '';
        //                 StockkeepingUnit.MODIFY(true);
        //             until StockkeepingUnit.NEXT = 0;
        //         "Linked SKU" := '';
        //     end;
        // end;

        //with Rec do begin
        if (xRec.Status <> Rec.Status) and (Rec.Status = Rec.Status::Closed) then begin
            StockkeepingUnit.SETRANGE("Location Code", Rec."Linked SKU FND");
            StockkeepingUnit.SETRANGE("Item No.", Rec."Linked Item No. FND");

            // BC Upgrade MISHRS14 >>
            // FINDSET Is being deprected so removed false due to warning
            //if StockkeepingUnit.FINDSET(true, false) then
            if StockkeepingUnit.FINDSET(true) then
                // BC Upgrade MISHRS14 <<

                    repeat
                        StockkeepingUnit."Production BOM No." := '';
                        StockkeepingUnit.MODIFY(true);
                until StockkeepingUnit.NEXT = 0;
            Rec."Linked SKU FND" := '';
        end;
        //end;
        // BC Upgrade MISHRS14 <<
        //HEI.13<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Routing Header", 'OnAfterValidateEvent', 'Status', false, false)]
    local procedure RoutingHeaderOnAfterValidateStatus(var Rec: Record "Routing Header"; var xRec: Record "Routing Header"; CurrFieldNo: Integer);
    var
        StockkeepingUnit: Record "Stockkeeping Unit";
    begin
        //HEI.13>>
        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variable with Rec.
        // with Rec do begin
        //     if (xRec.Status <> Status) and (Status = Status::Closed) then begin
        //         StockkeepingUnit.SETRANGE("Location Code", "Linked SKU");
        //         StockkeepingUnit.SETRANGE("Item No.", "Linked Item No.");
        //         if StockkeepingUnit.FINDSET(true, false) then
        //             repeat
        //                 StockkeepingUnit."Routing No." := '';
        //                 StockkeepingUnit.MODIFY(true);
        //             until StockkeepingUnit.NEXT = 0;
        //         "Linked SKU" := '';
        //     end;
        // end;

        //with Rec do begin
        if (xRec.Status <> Rec.Status) and (Rec.Status = Rec.Status::Closed) then begin
            StockkeepingUnit.SETRANGE("Location Code", Rec."Linked SKU FND");
            StockkeepingUnit.SETRANGE("Item No.", Rec."Linked Item No. FND");

            // BC Upgrade MISHRS14 >>
            // FINDSET Is being deprected so removed false due to warning
            //if StockkeepingUnit.FINDSET(true, false) then
            if StockkeepingUnit.FINDSET(true) then
                // BC Upgrade MISHRS14 <<

                    repeat
                        StockkeepingUnit."Routing No." := '';
                        StockkeepingUnit.MODIFY(true);
                until StockkeepingUnit.NEXT = 0;
            Rec."Linked SKU FND" := '';
        end;
        //end;
        // BC Upgrade MISHRS14 <<
        //HEI.13<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Production BOM Header", 'OnAfterDeleteEvent', '', false, false)]
    local procedure ProductionBOMHeaderOnAfterDeleteEvent(var Rec: Record "Production BOM Header"; RunTrigger: Boolean);
    var
        StockkeepingUnit: Record "Stockkeeping Unit";
    begin
        //HEI.13>>
        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variable with Rec.
        // with Rec do begin
        //     if "Linked SKU" <> '' then begin
        //         StockkeepingUnit.SETRANGE("Item No.", "Linked Item No.");
        //         StockkeepingUnit.SETRANGE("Location Code", "Linked SKU");
        //         if StockkeepingUnit.FINDSET(true, false) then
        //             repeat
        //                 StockkeepingUnit."Production BOM No." := '';
        //                 StockkeepingUnit.MODIFY(true);
        //             until StockkeepingUnit.NEXT = 0;
        //     end;
        // end;

        //with Rec do begin
        if Rec."Linked SKU FND" <> '' then begin
            StockkeepingUnit.SETRANGE("Item No.", Rec."Linked Item No. FND");
            StockkeepingUnit.SETRANGE("Location Code", Rec."Linked SKU FND");

            // BC Upgrade MISHRS14 >>
            // FINDSET Is being deprected so removed false due to warning
            //if StockkeepingUnit.FINDSET(true, false) then
            if StockkeepingUnit.FINDSET(true) then
                // BC Upgrade MISHRS14 <<

                    repeat
                        StockkeepingUnit."Production BOM No." := '';
                        StockkeepingUnit.MODIFY(true);
                until StockkeepingUnit.NEXT = 0;
        end;
        //end;
        // BC Upgrade MISHRS14 <<
        //HEI.13<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Routing Header", 'OnAfterDeleteEvent', '', false, false)]
    local procedure RoutingHeaderOnAfterDeleteEvent(var Rec: Record "Routing Header"; RunTrigger: Boolean);
    var
        StockkeepingUnit: Record "Stockkeeping Unit";
    begin
        //HEI.13>>
        // BC Upgrade MISHRS14 >>
        // Blocked with statement and prefixed variable with Rec.
        // with Rec do begin
        //     if "Linked SKU" <> '' then begin
        //         StockkeepingUnit.SETRANGE("Item No.", "Linked Item No.");
        //         StockkeepingUnit.SETRANGE("Location Code", "Linked SKU");
        //         if StockkeepingUnit.FINDSET(true, false) then
        //             repeat
        //                 StockkeepingUnit."Routing No." := '';
        //                 StockkeepingUnit.MODIFY(true);
        //             until StockkeepingUnit.NEXT = 0;
        //     end;
        // end;

        //with Rec do begin
        if Rec."Linked SKU FND" <> '' then begin
            StockkeepingUnit.SETRANGE("Item No.", Rec."Linked Item No. FND");
            StockkeepingUnit.SETRANGE("Location Code", Rec."Linked SKU FND");
            // BC Upgrade MISHRS14 >>
            // FINDSET Is being deprected so removed false due to warning
            //if StockkeepingUnit.FINDSET(true, false) then
            if StockkeepingUnit.FINDSET(true) then
                // BC Upgrade MISHRS14 <<
                    repeat
                        StockkeepingUnit."Routing No." := '';
                        StockkeepingUnit.MODIFY(true);
                until StockkeepingUnit.NEXT = 0;
        end;
        //end;
        // BC Upgrade MISHRS14 <<
        //HEI.13<<
    end;



    local procedure GetCommonSourceSharingSetup();
    begin
        //>> HEI.15
        if not CommonSourceSharingSetupGot then
            if CommonSourceSharingSetup.GET then;
        CommonSourceSharingSetupGot := true
        //<< HEI.15
    end;

    [EventSubscriber(ObjectType::Table, Database::"Warehouse Receipt Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure T7317OnAfterInsertWhseRcptLine(var Rec: Record "Warehouse Receipt Line"; RunTrigger: Boolean);
    var
        PL: Record "Purchase Line";
    begin
        //HEI.19 >>
        if PL.GET(PL."Document Type"::Order, Rec."Source No.", Rec."Source Line No.") then begin
            Rec."SPL Code FND" := PL."SPL Code FND";
            Rec."SPL Name FND" := PL."SPL Name FND";
            Rec.MODIFY;
        end;
        //HEI.19 <<
    end;

    var
        GlobalItemNoExistsErr: Label 'Global item no. %1 already exists as local no. %2.';
        GlobalItemNoFormatErr: Label 'Global item no. %1 is longer than %2 %3 from %4. You must adjust %5 or send a valid global number.';
        ManufacturingSetup: Record "Manufacturing Setup";
        ManufacturingSetupGot: Boolean;
        CommonSourceSharingSetup: Record "Common Src Sharing Setup FND";
        CommonSourceSharingSetupGot: Boolean;
    // BC Upgrade BHARDA11 >> ----his event has been created so that it can be called from the interface extension, allowing the interface-related code to be executed here.
    [IntegrationEvent(false, false)]
    local procedure OnBeforeRunProcessingInvHooks()
    begin
    end;
    // BC Upgrade BHARDA11 << ----his event has been created so that it can be called from the interface extension, allowing the interface-related code to be executed here.

}