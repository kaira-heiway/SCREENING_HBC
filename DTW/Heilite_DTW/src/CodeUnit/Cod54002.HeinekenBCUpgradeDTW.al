codeunit 54002 "Heineken BC Upgrade DTW"
{
    //REP-99001025-Refresh Production Order Start here -->>

    //BC Upgrade KAPOOV01 REP-99001025-HEI.01 #Created new function -OnBeforeUpdateRoutingNo & Subscribed to event-OnBeforeUpdateRoutingNo of function-UpdateRoutingNo so as to handle Production Order - OnAfterGetRecord() Trigger related customization of HEI.01>>

    // BC Upgrade MISHRS14 >>
    // Created procedure - "InsertItemJnLineProcedure" for Report-790 "Calculate Inventory" for #HEI.02 tag to subscribe event - OnInsertItemJnlLineOnAfterValidateLocationCode.
    // Created procedure - "OnInsertItemJnlLineOnAfterUpdateDimensionSetIDProcedure" for Report-790 "Calculate Inventory" for #HEI.02 tag to subscribe event - OnInsertItemJnlLineOnAfterUpdateDimensionSetID.
    // BC Upgrade MISHRS14 <<
    // BC Upgrade - RD03 Subscribed event to handle Zone Warehouse Movement Proces.
    // Defect/Bug Fix- BC UPGRADE PATHAA02 08.06.26; In TO Process-->After Creating Whse Receipt, system should open the Document page instead of List page. Code added on "Get Source Doc. Inbound_OnOpenWarehouseReceiptPage"


    // BC Upgrade - RD03 ---->>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Act.-Register (Yes/No)", 'OnBeforeCode', '', false, false)]
    local procedure CU7306_OnBeforeCode(var WarehouseActivityLine: Record "Warehouse Activity Line"; var IsHandled: Boolean)
    var
        WMSMgt: Codeunit "WMS Management";
        text50000: Label 'Do you want to register the %1 Document?';
        WhseActivityRegister: Codeunit "Whse.-Activity-Register";
        WhseActivityRegis_NewCode: Codeunit WhseActivityRegister_NewCode;
    begin
        CustomCheckSourceDocument(WarehouseActivityLine);
        if NOT WarehouseActivityLine."Zone-Transfer FND" then begin //HEI.01
            WMSMgt.CheckBalanceQtyToHandle(WarehouseActivityLine);
            IF NOT CONFIRM(text50000, FALSE, WarehouseActivityLine."Activity Type") THEN
                EXIT;
        end else begin
            IsHandled := true;   // Skip entire standard Code() logic 
            // BC Upgrade - RD03 a New codeunit created and migrated logic to make Zone Warehouse Movement works -->>
            WhseActivityRegis_NewCode.Execute(WarehouseActivityLine);
            // BC Upgrade - RD03 a New codeunit created and migrated logic to make Zone Warehouse Movement works--<<
            //WhseActivityRegister.Run(WarehouseActivityLine);
            Clear(WhseActivityRegister);
        end;
    end;

    local procedure CustomCheckSourceDocument(var WhseLine: Record "Warehouse Activity Line")
    var
        text50000: Label 'The document %1 is not supported.';
    begin
        if (WhseLine."Activity Type" = WhseLine."Activity Type"::"Invt. Movement") and
     not (WhseLine."Source Document" in [WhseLine."Source Document"::" ",
                                 WhseLine."Source Document"::"Prod. Consumption",
                                 WhseLine."Source Document"::"Assembly Consumption"]) then
            Error(text50000, WhseLine."Source Document");
    end;
    // BC Upgrade - RD03 ---->>

    [EventSubscriber(ObjectType::Report, Report::"Refresh Production Order", OnBeforeUpdateRoutingNo, '', false, false)]
    local procedure OnBeforeUpdateRoutingNo(var ProductionOrder: Record "Production Order"; RoutingNo: Code[20]; var IsHandled: Boolean; var CalcLines: Boolean; var CalcComponents: Boolean; var CalcRoutings: Boolean)
    var

    begin
        IsHandled := true;
        IF (RoutingNo <> ProductionOrder."Routing No.") THEN BEGIN
            //BC Upgrade KAPOOV01 Drink-IT>>
            //IF (RoutingNo <> "Routing No.") AND ("Routing No." = '') THEN BEGIN
            // >>DITW110.00.12A HBA NRQ#68221
            //BC Upgrade KAPOOV01 Drink-IT<<
            //HEI.01>>
            //"Routing No." := RoutingNo;
            ProductionOrder.VALIDATE("Routing No.", RoutingNo);
            //HEI.01<<
            ProductionOrder.Modify();
        end;
    end;
    //BC Upgrade KAPOOV01 REP-99001025-HEI.01 #Created new function -OnBeforeUpdateRoutingNo & Subscribed to event-OnBeforeUpdateRoutingNo of function-UpdateRoutingNo so as to handle Production Order - OnAfterGetRecord() Trigger related customization of HEI.01<<


    //BC Upgrade KAPOOV01 REP-99001025 #Created new function -OnAfterRefreshProdOrder & Subscribed to event-OnAfterRefreshProdOrder of Production Order - OnAfterGetRecord() Trigger so as to handle Production Order - OnAfterGetRecord() Trigger related customization of Various HEI TAGS>>
    [EventSubscriber(ObjectType::Report, Report::"Refresh Production Order", OnAfterRefreshProdOrder, '', false, false)]
    local procedure OnAfterRefreshProdOrder(var ProductionOrder: Record "Production Order"; ErrorOccured: Boolean)
    var
        ProdOrderLine: Record 5406;
        RoutingLine: Record 99000764;
        ProdOrderLineL: Record 5406;

    begin
        //HEI.01>>
        RoutingLine.SETRANGE("Routing No.", ProductionOrder."Routing No. 112FDW");// BC UPGRADE KAMNAY01 RPO FIXING 08-05-2026
        //RoutingLine.SETRANGE("Version Code", ProductionOrder."Routing Version Code"); //BC Upgrade KAPOOV01 Drink-IT
        RoutingLine.SetRange("Version Code", ProductionOrder."Routing Vrsn Code 112FDW");// BC UPGRADE KAMNAY01 RPO FIXING 08-05-2026
        IF RoutingLine.FINDFIRST() THEN BEGIN
            IF (RoutingLine."Zone Code FND" <> '') THEN BEGIN
                ProductionOrder."Zone Code FND" := RoutingLine."Zone Code FND";
                IF RoutingLine."Bin Code FND" <> '' THEN
                    ProductionOrder."Bin Code" := RoutingLine."Bin Code FND";
                ProductionOrder.MODIFY();
                ProdOrderLine.SETRANGE(Status, ProductionOrder.Status);
                ProdOrderLine.SETRANGE("Prod. Order No.", ProductionOrder."No.");
                //HEI.04>>
                //IF ProdOrderLine.FINDFIRST THEN
                IF ProdOrderLine.FIND('-') THEN
                    //HEI.04<<
                    REPEAT
                        //HEI.04>>
                        //IF ("Bin Code" = ProdOrderLine."Bin Code") AND (RoutingLine."Bin Code" = '') THEN
                        //ProdOrderLine."Bin Code" := RoutingLine."Bin Code"
                        //ELSE
                        //HEI.04<<
                        ProdOrderLine."Bin Code" := ProductionOrder."Bin Code";
                        //HEI.04>>
                        //ProdOrderLine."Zone Code" := RoutingLine."Zone Code";
                        ProdOrderLine."Zone Code FND" := ProductionOrder."Zone Code FND";
                        //HEI.04<<
                        ProdOrderLine.MODIFY();
                    UNTIL ProdOrderLine.NEXT() = 0;
            END;
        END;

        //HEI.05>>
        // HEI.03 >>
        //ProdOrderLine.SETRANGE(Status,Status);
        //ProdOrderLine.SETRANGE("Prod. Order No.","No.");
        //IF ProdOrderLine.FINDSET THEN REPEAT
        //  ProdOrderLine.VALIDATE("Ending Date-Time");
        //  ProdOrderLine.MODIFY;
        //  "Starting Date" := DT2DATE(ProdOrderLine."Starting Date-Time");
        //UNTIL ProdOrderLine.NEXT = 0;
        // HEI.03 <<

        ProdOrderLineL.SETRANGE(Status, ProductionOrder.Status);
        ProdOrderLineL.SETRANGE("Prod. Order No.", ProductionOrder."No.");
        IF ProdOrderLineL.FIND('-') THEN BEGIN
            REPEAT
                ProdOrderLineL.VALIDATE("Ending Date-Time");
                ProdOrderLineL.MODIFY(TRUE);
            UNTIL ProdOrderLineL.NEXT() = 0;
            ProductionOrder.VALIDATE("Ending Date", DT2DATE(ProdOrderLineL."Ending Date-Time"));
            ProductionOrder.MODIFY(TRUE);
        END;
        //HEI.05<<

        //HEI.01<<

        //HEI.02>>

        //BC Upgrade KAPOOV01 Passed-ProductionOrder as parameter instaed of Data Item- "Production Order">>
        //RefreshProductionOrder.L_UpdateTileCode("Production Order");
        L_UpdateTileCode(ProductionOrder);
        //BC Upgrade KAPOOV01 Passed-ProductionOrder as parameter instaed of Data Item- "Production Order"<<
        ProductionOrder.MODIFY();
        //HEI.02<<

    end;
    //BC Upgrade KAPOOV01 REP-99001025 #Created new function -OnAfterRefreshProdOrder & Subscribed to event-OnAfterRefreshProdOrder of Production Order - OnAfterGetRecord() Trigger so as to handle Production Order - OnAfterGetRecord() Trigger related customization of Various HEI TAGS<<

    //BC Upgrade KAPOOV01 Created new procedure- L_UpdateTileCode Originally created in report-Refresh Production Order under TAG-HEI.02>>
    Local procedure L_UpdateTileCode(VAR pProductionOrder: Record "Production Order")
    var
        lRoleCenterTileSetup: Record "Role Center Tile Setup FND";
        lDimensionSetEntry: Record "Dimension Set Entry";
        lStatus: Enum "Production Order Status"; //BC Upgrade KAPOOV01 defined lStatus as enum and not option as defined in NAV.
        lProdOrderNo: Code[20];
        lRoleCentreTileCode: Text[30];
    begin
        //HEI.02>>
        lRoleCentreTileCode := pProductionOrder."Role Centre Tile Code FND";

        pProductionOrder."Role Centre Tile Code FND" := '';
        lStatus := pProductionOrder.Status;
        lProdOrderNo := pProductionOrder."No.";

        lRoleCenterTileSetup.RESET();
        lRoleCenterTileSetup.SETRANGE("Location Code", pProductionOrder."Location Code");
        lRoleCenterTileSetup.SETRANGE("Zone Code", pProductionOrder."Zone Code FND");
        IF lRoleCenterTileSetup.FINDFIRST() THEN
            REPEAT
                IF ((lRoleCenterTileSetup."Dimension Code" = '') AND (lRoleCenterTileSetup."Dimension Filter Value" = '')) THEN
                    pProductionOrder."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";

                IF ((lRoleCenterTileSetup."Dimension Code" <> '') OR (lRoleCenterTileSetup."Dimension Filter Value" <> '')) THEN BEGIN
                    lDimensionSetEntry.RESET();
                    lDimensionSetEntry.SETRANGE("Dimension Set ID", pProductionOrder."Dimension Set ID");
                    IF (lRoleCenterTileSetup."Dimension Code" <> '') THEN
                        lDimensionSetEntry.SETRANGE("Dimension Code", lRoleCenterTileSetup."Dimension Code");
                    IF (lRoleCenterTileSetup."Dimension Filter Value" <> '') THEN
                        lDimensionSetEntry.SETFILTER("Dimension Value Code", lRoleCenterTileSetup."Dimension Filter Value");
                    IF lDimensionSetEntry.FINDFIRST() THEN
                        pProductionOrder."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";
                END;
            UNTIL lRoleCenterTileSetup.NEXT() = 0;

        lRoleCenterTileSetup.RESET();
        lRoleCenterTileSetup.SETRANGE("Location Code", pProductionOrder."Location Code");
        lRoleCenterTileSetup.SETRANGE("Zone Code", '');
        IF lRoleCenterTileSetup.FINDFIRST() THEN
            REPEAT
                IF ((lRoleCenterTileSetup."Dimension Code" = '') AND (lRoleCenterTileSetup."Dimension Filter Value" = '')) THEN
                    pProductionOrder."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";

                IF ((lRoleCenterTileSetup."Dimension Code" <> '') OR (lRoleCenterTileSetup."Dimension Filter Value" <> '')) THEN BEGIN
                    lDimensionSetEntry.RESET();
                    lDimensionSetEntry.SETRANGE("Dimension Set ID", pProductionOrder."Dimension Set ID");
                    IF (lRoleCenterTileSetup."Dimension Code" <> '') THEN
                        lDimensionSetEntry.SETRANGE("Dimension Code", lRoleCenterTileSetup."Dimension Code");
                    IF (lRoleCenterTileSetup."Dimension Filter Value" <> '') THEN
                        lDimensionSetEntry.SETFILTER("Dimension Value Code", lRoleCenterTileSetup."Dimension Filter Value");
                    IF lDimensionSetEntry.FINDFIRST() THEN
                        pProductionOrder."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";
                END;
            UNTIL lRoleCenterTileSetup.NEXT() = 0;


        lRoleCenterTileSetup.RESET();
        lRoleCenterTileSetup.SETRANGE("Location Code", '');
        lRoleCenterTileSetup.SETRANGE("Zone Code", pProductionOrder."Zone Code FND");
        IF lRoleCenterTileSetup.FINDFIRST() THEN
            REPEAT
                IF ((lRoleCenterTileSetup."Dimension Code" = '') AND (lRoleCenterTileSetup."Dimension Filter Value" = '')) THEN
                    pProductionOrder."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";

                IF ((lRoleCenterTileSetup."Dimension Code" <> '') OR (lRoleCenterTileSetup."Dimension Filter Value" <> '')) THEN BEGIN
                    lDimensionSetEntry.RESET();
                    lDimensionSetEntry.SETRANGE("Dimension Set ID", pProductionOrder."Dimension Set ID");
                    IF (lRoleCenterTileSetup."Dimension Code" <> '') THEN
                        lDimensionSetEntry.SETRANGE("Dimension Code", lRoleCenterTileSetup."Dimension Code");
                    IF (lRoleCenterTileSetup."Dimension Filter Value" <> '') THEN
                        lDimensionSetEntry.SETFILTER("Dimension Value Code", lRoleCenterTileSetup."Dimension Filter Value");
                    IF lDimensionSetEntry.FINDFIRST() THEN
                        pProductionOrder."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";
                END;
            UNTIL lRoleCenterTileSetup.NEXT() = 0;

        lRoleCenterTileSetup.RESET();
        lRoleCenterTileSetup.SETRANGE("Location Code", '');
        lRoleCenterTileSetup.SETRANGE("Zone Code", '');
        IF lRoleCenterTileSetup.FINDFIRST() THEN
            REPEAT
                IF ((lRoleCenterTileSetup."Dimension Code" <> '') OR (lRoleCenterTileSetup."Dimension Filter Value" <> '')) THEN BEGIN
                    lDimensionSetEntry.RESET();
                    lDimensionSetEntry.SETRANGE("Dimension Set ID", pProductionOrder."Dimension Set ID");
                    IF (lRoleCenterTileSetup."Dimension Code" <> '') THEN
                        lDimensionSetEntry.SETRANGE("Dimension Code", lRoleCenterTileSetup."Dimension Code");
                    IF (lRoleCenterTileSetup."Dimension Filter Value" <> '') THEN
                        lDimensionSetEntry.SETFILTER("Dimension Value Code", lRoleCenterTileSetup."Dimension Filter Value");
                    IF lDimensionSetEntry.FINDFIRST() THEN
                        pProductionOrder."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";
                END;
            UNTIL lRoleCenterTileSetup.NEXT() = 0;

        IF ((pProductionOrder."Role Centre Tile Code FND" = '') AND (lRoleCentreTileCode <> '')) THEN
            pProductionOrder."Role Centre Tile Code FND" := lRoleCentreTileCode;
        //HEI.02<<
    end;
    //BC Upgrade KAPOOV01 Created new procedure- L_UpdateTileCode Originally created in report-Refresh Production Order under TAG-HEI.02 <<

    //REP-99001025-Refresh Production Order END here <<


    //BC Upgrade GUNREM01 codeunit 99000787 "Create Prod. Order Lines" >>
    // MANXL7.00.001 DAT 03/03/2014 #12: Version Management
    //   MANXL7.00.001 WSA 11/07/2014 #87: Added code MANXL security

    //   DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008 BrewIt & Quality
    //   DITW15.00.00.39 PRODW14.00.00.08.18 DDR 25/08/2011 issue 1372 Added fields "Item Category Code"
    //   DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //   DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    //   DITW18.00.06 AKH 16/02/2015 DIT-770 #1184 Multisite - Production Orders: Consider possible BOM and Routing setup on SKU card
    //   DITW18.00.06 MSF 28/02/2015 DIT-770 #1192 Copy "Responsibility Center" & "Physical location group code" From production order
    //   DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //                                            Use XL fields "Product Group Code","Item Category Code"
    //   DITW17.10.04 MSF 11/11/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //   DITW17.10.05  AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    //   DITW18.00.06 MSF 02/06/2015 DIT-770 #1403 Routing No is not copied to production order line
    //   DITW19.00.08 AKH 22/09/2016 BL#11719 (DIT-770 #2188) Bin code not filled well in production order line

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    //   FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    //   DITW110.00.12A HBA 18/06/2018 NRQ#68221 Adjusted code in funtion Copy()
    //   DITW110.00.12A HBA 22/06/2018 NRQ#68221 Adjusted Code in function Copy() to insert "Routing No."
    //   DITW111.00.13 MZOU 07/11/2018 NRQ#91425 Refresh Production order should update Bin from last routing line
    //   DITW111.00.13 ISL 13/12/2018 NRQ#91425 Adjudted code in funtion Copy()
    //   # INC3259372/INC3170793-CHG2093474 IBM.AK 08/01/20 added missing code

    //   HEI.01 FDD-PRDGAP024 IBM SOICAD01 25.07.2017 #Changed Zone copy zone code from Prod Order Header to Prod Order Line

    //   HEI.02 ISSUE ID #78 IBM.NAIKH01,
    //     # populating the Bincode from the Routing or work center
    //   HEI.03 Defect 3532 IBM.NAIKH01 16.11.2018
    //     # Code added on the function Copy() to get the Zone Code as the Bin is picked from the
    //       different Zone and the Zone is not changed.
    //   HEI.04 CHG2007832 IBM ISYED01 3.21.2019
    //    #System is not auto populating Zone Code and bin Code fields after production order refreshing.

    //   HEI.05 CC-CHG2096636 IBM.AK 03.02.21
    //     # written code to consider ending date as due date for non-active (importing firm planned prod orders)
    //   HEI.06 CHG2103273 IBM.LS      18.06.2021
    //     # Added and Commented Code

    //BC Upgrade GUNREM01 - HEI.03, HEI.05 and HEI.06 code not added becuase its DIT.


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Prod. Order Lines", OnCreateProdOrderLineOnBeforeInitProdOrderLine, '', false, false)]
    local procedure "Create Prod. Order Lines_OnCreateProdOrderLineOnBeforeInitProdOrderLine"(var InsertNew: Boolean)
    begin
        ProdOrderLineInsert := True;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Prod. Order Lines", OnCopyFromSalesOrderOnBeforeProdOrderLineModify, '', false, false)]
    local procedure "Create Prod. Order Lines_OnCopyFromSalesOrderOnBeforeProdOrderLineModify"(var ProdOrderLine: Record "Prod. Order Line"; SalesLine: Record "Sales Line"; SalesPlanningLine: Record "Sales Planning Line"; var NextProdOrderLineNo: Integer)
    var
        //  Bin: Record Bin;
        Bin: Record Bin;
    begin
        //HEI.01 PRDGAP024>>
        IF Bin.GET(ProdOrderLine."Location Code", ProdOrderLine."Bin Code") THEN
            ProdOrderLine."Zone Code FND" := Bin."Zone Code";
        //HEI.01 PRDGAP024<<
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Create Prod. Order Lines", OnInitProdOrderLineAfterVariantCode, '', false, false)]

    procedure OnInitProdOrderLineAfterVariantCode(var ProdOrderLine: Record "Prod. Order Line")
    var
        Bin: Record Bin;
    begin
        //HEI.01 PRDGAP024>>
        IF Bin.GET(ProdOrderLine."Location Code", ProdOrderLine."Bin Code") THEN
            ProdOrderLine."Zone Code FND" := Bin."Zone Code";
        //HEI.01 PRDGAP024<<
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Create Prod. Order Lines", OnCheckMakeOrderLineBeforeInsert, '', false, false)]
    procedure OnCheckMakeOrderLineBeforeInsert(var ProdOrderLine: Record "Prod. Order Line"; var ProdOrderComponent: Record "Prod. Order Component"; var InsertNew: Boolean)
    var
        Bin: Record Bin;
    begin
        //HEI.01 PRDGAP024>>
        IF Bin.GET(ProdOrderLine."Location Code", ProdOrderLine."Bin Code") THEN
            ProdOrderLine."Zone Code FND" := Bin."Zone Code";
        //HEI.01 PRDGAP024<<
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Create Prod. Order Lines", OnAfterProdOrderLineInsert, '', false, false)]
    procedure OnAfterProdOrderLineInsert(var ProdOrder: Record "Production Order"; var ProdOrderLine: Record "Prod. Order Line"; var NextProdOrderLineNo: Integer)
    var
        Bin: Record Bin;
        WHSUtils: Codeunit "WHS-Utils";
    begin
        if ProdOrderLineInsert then begin
            //HEI.04>>
            IF Bin.GET(ProdOrderLine."Location Code", ProdOrderLine."Bin Code") THEN
                ProdOrderLine."Zone Code FND" := Bin."Zone Code";
            IF ProdOrderLine."Zone Code FND" <> '' THEN
                WHSUtils.CheckUserAuthorizedinZone(ProdOrderLine."Location Code", ProdOrderLine."Zone Code FND");
            //HEI.04>>

            //HEI.02  ISSUE #78
            IF ProdOrder."Bin Code" = '' THEN
                ProdOrder."Bin Code" := ProdOrderLine."Bin Code";
            IF ProdOrder."Zone Code FND" = '' THEN
                ProdOrder."Zone Code FND" := ProdOrderLine."Zone Code FND";
            WHSUtils.CheckUserAuthorizedinZone(ProdOrder."Location Code", ProdOrder."Zone Code FND"); //HEI.01 PRDGAP024>>
            ProdOrder.MODIFY;
            //HEI.02 ISSUE #78
            ProdOrderLineInsert := false;
        end;
    end;

    //BC Upgrade GUNREM01 codeunit 99000787 "Create Prod. Order Lines" <<


    //BC UPGRADE PATHAA02-page 99000800-ProdBOMVersionList>>
    //HEI.01  Code added to mandate Active at least one version-OnqueryClosePageEvent>>
    [EventSubscriber(ObjectType::Page, Page::"Prod. BOM Version List", 'OnQueryClosePageEvent', '', false, false)]
    local procedure ProdBOMVersionList_OnQueryClosePageEvent(var Rec: Record "Production BOM Version"; var AllowClose: Boolean)
    var
        ProdBOMVer: Record "Production BOM Version";
        Text0001: Label 'Production BOM %1 does not have any Active version. Please select one version as Active.';
    begin
        ProdBOMVer.Reset();
        ProdBOMVer.SetRange("Production BOM No.", Rec."Production BOM No.");
        ProdBOMVer.SetRange("Active FND", true);

        if not ProdBOMVer.FindFirst() then begin
            AllowClose := false;
            Error(Text0001, Rec."Production BOM No.");
        end;
    end;
    //HEI.01  Code added to mandate Active at least one version-OnqueryClosePageEvent<<
    //BC UPGRADE PATHAA02-page 99000800-ProdBOMVersionList<<


    //BC UPGRADE PATHAA02-page 99000808-RoutingVersionList>>
    //HEI.01  Code added to mandate Active at least one version-OnqueryClosePageEvent>>
    [EventSubscriber(ObjectType::Page, Page::"Routing Version List", 'OnQueryClosePageEvent', '', false, false)]
    local procedure RoutingVersionList_OnQueryClosePageEvent(var Rec: Record "Routing Version"; var AllowClose: Boolean)
    var
        RoutingVersion: Record "Routing Version";
        Text0001: Label 'Routing Code %1 does not have any Active version. Please select one version as Active.';
    begin
        RoutingVersion.Reset();
        RoutingVersion.SetRange("Routing No.", Rec."Routing No.");
        RoutingVersion.SetRange("Active FND", true);

        if not RoutingVersion.FindFirst() then begin
            AllowClose := false;
            Error(Text0001, Rec."Routing No.");
        end;
    end;
    //HEI.01  Code added to mandate Active at least one version-OnqueryClosePageEvent<<
    //BC UPGRADE PATHAA02-page 99000808-RoutingVersionList<<

    //BC Upgrade -SIVA REP-5706 Stock Keeping Unit (SKU) >>
    //  DITW18.00.06 MSF 03/02/2015 DIT-770 #1182 Copy "Production Bom No." and "Routing No." from Item card
    //   DITW17.10.05 WSA 10/10/2014 DIT-770 #930 : Added code to transfer field "Origin Type" from Item or Location to SKU
    //   DITW19.00.08A AKH 06/01/2017 BL#17581 Removed code assigning "Origin Type" (Related to DE Beertax)
    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.09 YHE 15/03/2017 NRQ#24111 merge DIT2016 W1 R8A
    //   DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    //   DITW110.00.11 SFI 30/08/2017 BL#14417 Added changes for deposit valuation
    //   DITW110.00.11 VSC 26/09/2017 NRQ#30577 Merge - QXL10.01 VSC 26/09/2017 NRQ#38341 : Multisite Æ Quality tracking per Location
    //   HEI.01 FDD-KDD0TC001 IBM HORTOC01 17.10.2017
    //     # Fill in Item Type field

    //BC Upgrade SIVA REP-5706 #Created new function -OnBeforeStockkeepingUnitInsert & Subscribed to event-OnBeforeStockkeepingUnitInsert of Create Stockkeeping Unit Report so as to handle assigning values related to HEI TAGS custom code OnBeforeStockkeepingUnitInsert values >>
    [EventSubscriber(ObjectType::Report, Report::"Create Stockkeeping Unit", OnBeforeStockkeepingUnitInsert, '', false, false)]
    local procedure OnBeforeStockkeepingUnitInsert(var StockkeepingUnit: Record "Stockkeeping Unit"; Item: Record Item)
    begin
        //HEI.01>>
        StockkeepingUnit."Item Type FND" := Item."Item Type FND";
        StockkeepingUnit."RPM Solution FND" := Item."RPM Solution FND";
        StockkeepingUnit."RPM Type FND" := Item."RPM Type FND";
        //HEI.01<<
    end;
    //BC Upgrade SIVA REP-5706 #Created new function -OnBeforeStockkeepingUnitInsert & Subscribed to event-OnBeforeStockkeepingUnitInsert of Create Stockkeeping Unit Report so as to handle assigning values related to HEI TAGS custom code OnBeforeStockkeepingUnitInsert values <<
    //BC Upgrade -SIVA REP-5706 Stock Keeping Unit (SKU) <<


    // BC Upgrade MISHRS14 >>
    // Created procedure for Report-790 Calculate Inventory for #HEI.02 tag
    [EventSubscriber(ObjectType::Report, Report::"Calculate Inventory", OnInsertItemJnlLineOnAfterValidateLocationCode, '', false, false)]
    procedure InsertItemJnLineProcedure(ItemNo: Code[20]; VariantCode2: Code[10]; DimEntryNo2: Integer; BinCode2: Code[20]; Quantity2: Decimal; PhysInvQuantity: Decimal; var ItemJournalLine: Record "Item Journal Line")
    var
        UOMMgt: Codeunit "Unit of Measure Management";
        Item: Record Item;
        ItemJnlLine: Record "Item Journal Line";
    begin
        ItemJnlLine.SETAUTOCALCFIELDS(); //HEI.09
        //<<HEI.02 PATHAA02 27.03.26 -to flow the Inv UOM when called from Std report-790
        Item.GET(ItemNo);
        Item.TESTFIELD("Inventory Unit of Measure FND");
        ItemJournalLine.VALIDATE("Invent. Unit of Measur Cod FND", Item."Inventory Unit of Measure FND");
        ItemJournalLine."Qty. Phys. Inv. in Inv.UoM FND" := UOMMgt.CalcQtyFromBase(PhysInvQuantity, UOMMgt.GetQtyPerUnitOfMeasure(Item, ItemJournalLine."Invent. Unit of Measur Cod FND"));
        ItemJournalLine."Qty. (Calc.) in Inv. UoM FND" := UOMMgt.CalcQtyFromBase(Quantity2, UOMMgt.GetQtyPerUnitOfMeasure(Item, ItemJournalLine."Invent. Unit of Measur Cod FND"));
        // >>HEI.02   PATHAA02 27.03.26
    end;

    // Created procedure for Report-790 Calculate Inventory for #HEI.05 tag
    [EventSubscriber(ObjectType::Report, Report::"Calculate Inventory", 'OnInsertItemJnlLineOnAfterUpdateDimensionSetID', '', false, false)]
    local procedure OnInsertItemJnlLineOnAfterUpdateDimensionSetIDProcedure(var ItemJnlLine: Record "Item Journal Line")
    var
        Bin: Record Bin;
    begin
        //HEI.05<<
        IF Bin.GET(ItemJnlLine."Location Code", ItemJnlLine."Bin Code") AND (Bin."Ccc Code FND" <> '') THEN
            ItemJnlLine.VALIDATE("Shortcut Dimension 2 Code", Bin."Ccc Code FND");//HEI.07
                                                                                  //HEI.06>>
                                                                                  //   {
                                                                                  //     ELSE BEGIN//HEI.07
                                                                                  //     IF gSKU.GET("Location Code","Item No.",'') THEN BEGIN
                                                                                  //       IF gSKU."CCC Dim. Code" <> '' THEN
                                                                                  //         VALIDATE("Shortcut Dimension 2 Code",gSKU."CCC Dim. Code");
                                                                                  //     END;
                                                                                  //   END;
                                                                                  //   }//HEI.07
                                                                                  //HEI.06<<
                                                                                  //HEI.05>>
    end;
    // BC Upgrade MISHRS14 <<


    //BC Upgrade kamnay01  FDD DTW-006  Your reference >>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnSetupTempSplitItemJnlLineOnBeforeCalcPostItemJnlLine, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnSetupTempSplitItemJnlLineOnBeforeCalcPostItemJnlLine"(var TempSplitItemJnlLine: Record "Item Journal Line"; TempTrackingSpecification: Record "Tracking Specification")
    begin
        // 
        TempSplitItemJnlLine."Your Reference FND" := TempTrackingSpecification."Your Reference FND";
        // 

        // QXL11.01 MTR 13/09/2018 NRQ#24975
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnAfterInitItemLedgEntry, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnAfterInitItemLedgEntry"(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)

    var
        RealItemJnlLine: Record "Item Journal Line";
    begin
        if RealItemJnlLine.Get(
            ItemJournalLine."Journal Template Name",
            ItemJournalLine."Journal Batch Name",
            ItemJournalLine."Line No.")
        then begin
            NewItemLedgEntry."Your Reference FND" := RealItemJnlLine."Your Reference FND";
            //BC Upgrade GUNREM01 IBM GAP DTW 73 >> instead of DIT field created new Scrap code field and updating the field from item journal to ILE.  
            NewItemLedgEntry."Scrap Code FND" := RealItemJnlLine."Scrap Code";
            //BC Upgrade GUNREM01 IBM GAP DTW 73 << instead of DIT field created new Scrap code field and updating the field from item journal to ILE.  
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Reserv. Entry", 'OnAfterCopyFromInsertReservEntry', '', false, false)]
    local procedure CreateReservEntry_OnAfterCopyFromInsertReservEntry(var InsertReservEntry: Record "Reservation Entry"; var ReservEntry: Record "Reservation Entry"; FromReservEntry: Record "Reservation Entry"; Status: Enum "Reservation Status"; var QtyToHandleAndInvoiceIsSet: Boolean)
    var
        ItemJnlLine: Record "Item Journal Line";
    begin
        if ItemJnlLine.Get(ReservEntry."Source ID", ReservEntry."Source Batch Name", ReservEntry."Source Ref. No.")
        then begin
            ReservEntry."Your Reference FND" := ItemJnlLine."Your Reference FND";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracing Mgt.", OnAfterTransferData, '', false, false)]
    local procedure "Item Tracing Mgt._OnAfterTransferData"(var ItemLedgerEntry: Record "Item Ledger Entry"; var TempItemTracingBuffer: Record "Item Tracing Buffer" temporary; ValueEntry: Record "Value Entry")
    begin
        TempItemTracingBuffer."Your Reference FND" := ItemLedgerEntry."Your Reference FND";
    end;
    //BC Upgrade kamnay01  FDD DTW-006  Your reference <<


    //BC Upgrade Kamnay01 >> FDD -DTW031 Revaluation Journal Error Log
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Check Line", OnBeforeGetItem, '', false, false)]
    local procedure "Item Jnl.-Check Line_OnBeforeGetItem"(var Item: Record Item; var IsHandled: Boolean; ItemJournalLine: Record "Item Journal Line")

    var
        Text021: Label '%1 cannot be left blank.';
        ItemJnlPostBatchL: Codeunit "Item Jnl.-Post Batch";
        HeinekenBCUpgrade: Codeunit "Heineken BC Upgrade";
        Cu23: Codeunit "Item Jnl.-Post Batch _DTW";
    begin
        Item.Get(ItemJournalLine."Item No."); /// Yashraj added
        GetItemJnlLine(ItemJournalLine);
        //HEI.04>>

        IF CreateLog AND (Item."Base Unit of Measure" = '') THEN BEGIN
            ErrorTextL := STRSUBSTNO(Text021, Item.FIELDCAPTION("Base Unit of Measure"));
            Cu23.InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
            CLEAR(ErrorTextL);
        END ELSE
            //HEI.04<<
            if Item.Get(ItemJournalLine."Item No.") then
                Item.TestField("Base Unit of Measure", ErrorInfo.Create());
        IsHandled := true;
        // Item.TESTFIELD("Base Unit of Measure");
    end;

    local procedure GetItemJnlLine(VAR ItemJournalLine: Record "Item Journal Line")
    var
        myInt: Integer;
        InventorySetupL: Record "Inventory Setup";
        ItemJnlTemplateL: Record "Item Journal Template";
    begin


        //HEI.04>>
        CLEAR(ItemJnlLineError);
        CLEAR(CreateLog);
        IF InventorySetupL.GET THEN BEGIN
            IF InventorySetupL."Activate Rev.Jnl.Error Log FND" THEN BEGIN
                IF ItemJnlTemplateL.GET(ItemJournalLine."Journal Template Name") THEN BEGIN
                    IF ItemJnlTemplateL.Type = ItemJnlTemplateL.Type::Revaluation THEN BEGIN
                        ItemJnlLineError.SETRANGE("Journal Template Name", ItemJournalLine."Journal Template Name");
                        ItemJnlLineError.SETRANGE("Journal Batch Name", ItemJournalLine."Journal Batch Name");
                        ItemJnlLineError.SETRANGE("Line No.", ItemJournalLine."Line No.");
                        IF ItemJnlLineError.FINDFIRST THEN;
                        CreateLog := TRUE;
                    END;
                END;
            END;
        END;
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Heineken BC Upgrade", OnHandleNonRecurringLineOnAfterCopyItemJnlLine3, '', false, false)]
    local procedure "Heineken BC Upgrade_OnHandleNonRecurringLineOnAfterCopyItemJnlLine3"(var ItemJournalLine: Record "Item Journal Line"; var ItemJournalLine3: Record "Item Journal Line")
    var
        Itemjournalline4: Record "Item Journal Line";
        LineNo: Integer;
        InventorySetupL: Record "Inventory Setup";
        ItemJnlTemplateL: Record "Item Journal Template";
    begin
        CLEAR(Itemjournalline4);
        IF InventorySetupL.GET THEN BEGIN
            IF InventorySetupL."Activate Rev.Jnl.Error Log FND" THEN BEGIN
                IF ItemJnlTemplateL.GET(ItemJournalLine."Journal Template Name") THEN BEGIN
                    IF ItemJnlTemplateL.Type = ItemJnlTemplateL.Type::Revaluation THEN BEGIN
                        Itemjournalline4.SETRANGE("Journal Template Name", ItemJournalLine."Journal Template Name");
                        Itemjournalline4.SETRANGE("Journal Batch Name", ItemJournalLine."Journal Batch Name");
                        Itemjournalline4.SETRANGE("Post To FND", Itemjournalline4."Post To FND"::Include);
                        IF Itemjournalline4.FindSet() THEN
                            ItemJournalLine3.CopyFilters(Itemjournalline4);
                    END;
                END;
            END;
        END;
    end;

    //Yashraj stop posting error line<<03-04-2026

    //BC Upgrade Kamnay01 << FDD -DTW031 Revaluation Journal Error Log

    //BC Upgrade GUNREM01 IBM GAP DTW 73 >> Stopped Base error for the scrap code, type machine center or work center error

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnBeforeValidateScrapCode, '', false, false)]
    local procedure "Item Journal Line_OnBeforeValidateScrapCode"(var ItemJournalLine: Record "Item Journal Line"; var IsHandled: Boolean)
    begin
        //  if ItemJournalLine."Scrap Code" <> '' then
        IsHandled := true;
    end;

    //BC Upgrade GUNREM01 IBM GAP DTW 73 << Stopped Base error for the scrap code, type machine center or work center error


    //BC Upgrade GUNREM01 -IBM GAP DTW 48 >>
    [EventSubscriber(ObjectType::Report, Report::"Notification Email", OnBeforeGetDocumentTypeAndNumber, '', false, false)]
    local procedure "Notification Email_OnBeforeGetDocumentTypeAndNumber"(var NotificationEntry: Record "Notification Entry"; var RecRef: RecordRef; var DocumentType: Text; var DocumentNo: Text; var IsHandled: Boolean)
    var
        FieldRef: FieldRef;
    begin
        //HEI.01>>
        case RecRef.NUMBER of
            DATABASE::"Item Journal Line":
                BEGIN
                    DocumentType := RecRef.CAPTION;
                    FieldRef := RecRef.FIELD(1);
                    DocumentNo := FORMAT(FieldRef.VALUE);
                    FieldRef := RecRef.FIELD(41);
                    DocumentNo += ',' + FORMAT(FieldRef.VALUE);
                    FieldRef := RecRef.FIELD(2);
                    DocumentNo += ',' + FORMAT(FieldRef.VALUE);
                END;
            DATABASE::"Item Journal Batch":
                BEGIN
                    DocumentType := RecRef.CAPTION;
                    FieldRef := RecRef.FIELD(1);
                    DocumentNo := FORMAT(FieldRef.VALUE);
                    FieldRef := RecRef.FIELD(2);
                    DocumentNo += ',' + FORMAT(FieldRef.VALUE);
                    FieldRef := RecRef.FIELD(21);
                    FieldRef.CALCFIELD;
                    DocumentNo += ',' + FORMAT(FieldRef.VALUE);
                END;
        //HEI.01<<

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Notification Management", OnGetDocumentTypeAndNumber, '', false, false)]
    local procedure "Notification Management_OnGetDocumentTypeAndNumber"(var RecRef: RecordRef; var DocumentType: Text; var DocumentNo: Text; var IsHandled: Boolean)
    var
        FieldRef: FieldRef;
    begin
        //HEI.01>>
        IF (RecRef.NUMBER = DATABASE::"Approval Entry") AND (DocumentNo = '') THEN BEGIN
            FieldRef := RecRef.FIELD(22);
            DocumentNo := FORMAT(FieldRef.VALUE);
        END;
        //HEI.01<<
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnAddWorkflowResponsesToLibrary, '', false, false)]

    local procedure "Workflow Response Handling_OnAddWorkflowResponsesToLibrary"()
    var
        WorkflowResponseHandler: Codeunit "Workflow Response Handling";
        HeinikenBCUpgrade: Codeunit "Heineken BC Upgrade";
        CheckItemJournalBatchBalanceTxt: label 'Check if the Phys. Inv. Journal batch is selected.';
        Text001: Label 'Post Phys. Inv. Journal Lines in the background';//BC Upgrade GUNREM01 -Workflow auto Posting

    begin
        //HEI.07>>
        WorkflowResponseHandler.AddResponseToLibrary(HeinikenBCUpgrade.CheckItemJournalBatchBalanceCode, 0, CheckItemJournalBatchBalanceTxt, 'GROUP 0');
        //HEI.07<<
        //BC Upgrade GUNREM01 -Workflow auto Posting >>
        //HEI.07>>
        WorkflowResponseHandler.AddResponseToLibrary(PostItemJournalAsyncCode, 0, Text001, 'GROUP 0');
        //HEI.07<<
        //BC Upgrade GUNREM01 -Workflow auto Posting <<
    end;

    LOCAL procedure CheckItemJournalBatchBalance(Variant: Variant)
    var
        RecRef: RecordRef;
        ItemJournalBatch: Record "Item Journal Batch";
    begin
        //HEI.07>>
        RecRef.GETTABLE(Variant);

        CASE RecRef.NUMBER OF
            DATABASE::"Item Journal Batch":
                BEGIN
                    ItemJournalBatch := Variant;
                    ItemJournalBatch.CheckBalance;
                END;
        END;
    end;
    //HEI.07<<
    //BC Upgrade GUNREM01 -1522 workflow request page handlling >>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Request Page Handling", OnAfterInsertRequestPageFields, '', false, false)]
    local procedure "Workflow Request Page Handling_OnAfterInsertRequestPageFields"()
    begin
        //HEI.01>>
        InsertItemJournalBatchReqPageFields;
        InsertItemJournalLineReqPageFields;
        //HEI.01<<
    end;

    LOCAL procedure InsertItemJournalBatchReqPageFields()
    var
        ItemJournalBatch: Record "Item Journal Batch";
    begin
        //HEI.01>>
        InsertReqPageField(DATABASE::"Item Journal Batch", ItemJournalBatch.FIELDNO(Name));
        InsertReqPageField(DATABASE::"Item Journal Batch", ItemJournalBatch.FIELDNO("Template Type"));
        InsertReqPageField(DATABASE::"Item Journal Batch", ItemJournalBatch.FIELDNO(Recurring));
        //HEI.01<<
    end;

    LOCAL procedure InsertItemJournalLineReqPageFields()
    var
        ItemJournalLine: Record "Item Journal Line";
    begin
        //HEI.01>>
        InsertReqPageField(DATABASE::"Item Journal Line", ItemJournalLine.FIELDNO("Document Type"));
        InsertReqPageField(DATABASE::"Item Journal Line", ItemJournalLine.FIELDNO("Entry Type"));
        InsertReqPageField(DATABASE::"Item Journal Line", ItemJournalLine.FIELDNO("Document No."));
        InsertReqPageField(DATABASE::"Item Journal Line", ItemJournalLine.FIELDNO(Quantity));
        //HEI.01<<
    end;

    LOCAL procedure InsertReqPageField(TableId: Integer; FieldId: Integer)
    var
        DynamicRequestPageField: Record "Dynamic Request Page Field";
    begin
        IF NOT DynamicRequestPageField.GET(TableId, FieldId) THEN
            CreateReqPageField(TableId, FieldId);
    end;

    LOCAL procedure CreateReqPageField(TableId: Integer; FieldId: Integer)
    var
        DynamicRequestPageField: Record "Dynamic Request Page Field";
    begin
        DynamicRequestPageField.INIT;
        DynamicRequestPageField.VALIDATE("Table ID", TableId);
        DynamicRequestPageField.VALIDATE("Field ID", FieldId);
        DynamicRequestPageField.INSERT
    end;
    //BC Upgrade GUNREM01 -1522 workflow request page handlling <<

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnAddWorkflowResponsePredecessorsToLibrary, '', false, false)]
    local procedure "Workflow Response Handling_OnAddWorkflowResponsePredecessorsToLibrary"(ResponseFunctionName: Code[128])
    var
        WorkflowResponseHandler: Codeunit "Workflow Response Handling";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        HnkBCUpgrade: Codeunit "Heineken BC Upgrade";
    begin
        case ResponseFunctionName of
            //BC Upgrade GUNREM01 -Workflow auto Posting >>
            //HEI.07>>
            PostItemJournalAsyncCode:
                WorkflowResponseHandler.AddResponsePredecessor(PostItemJournalAsyncCode, 'RunWorkflowOnAfterApproveItemLines');
            //HEI.07<<
            //BC Upgrade GUNREM01 -Workflow auto Posting >>
            //HEI.07>>
            HnkBCUpgrade.CheckItemJournalBatchBalanceCode:
                WorkflowResponseHandler.AddResponsePredecessor(HnkBCUpgrade.CheckItemJournalBatchBalanceCode,
                  HnkBCUpgrade.RunWorkflowOnSendItemJournalBatchForApprovalRequestCode);
        //HEI.07<<
        end;
    End;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnExecuteWorkflowResponse, '', false, false)]
    local procedure OnExecuteWorkflowResponse(var ResponseExecuted: Boolean; var Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
        HNKenBCUpgrade: Codeunit "Heineken BC Upgrade";
    begin
        ResponseExecuted := true;
        if WorkflowResponse.Get(ResponseWorkflowStepInstance."Function Name") then
            case WorkflowResponse."Function Name" of
                //BC Upgrade GUNREM01 -Workflow auto Posting >>
                //HEI.07>>
                PostItemJournalAsyncCode:
                    PostItemJournalAsync(Variant);
                //HEI.07<<
                //BC Upgrade GUNREM01 -Workflow auto Posting <<
                //HEI.07>>
                HNKenBCUpgrade.CheckItemJournalBatchBalanceCode:
                    CheckItemJournalBatchBalance(Variant);
            //HEI.07<<
            end else
            ResponseExecuted := false;
    end;
    //BC Upgrade GUNREM01 -IBM GAP DTW 48 <<

    //BC Upgrade GUNREM01 >> BUG Fix 29.05.26

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"WMS Management", OnBeforeLocationIsAllowed, '', false, false)]
    local procedure "WMS Management_OnBeforeLocationIsAllowed"(LocationCode: Code[10]; var LocationAllowed: Boolean)
    var
        WarehouseEmployee: Record "Warehouse Employee_DTW FND";
    begin
        LocationAllowed := true;
        WarehouseEmployee.Reset();
        WarehouseEmployee.SetRange("Location Code", LocationCode);
        WarehouseEmployee.SetRange("User ID", UserId());
        if WarehouseEmployee.FindFirst() then
            LocationAllowed := true
        else
            LocationAllowed := false;
    end;
    //BC Upgrade GUNREM01 << BUG Fix 29.05.26
    //BC Upgrade FDD-DTW-015 >> warehouse employee bug fix 05.06.26
    [EventSubscriber(ObjectType::Table, Database::"Warehouse Shipment Header", OnBeforeErrorIfUserIsNotWhseEmployee, '', false, false)]
    local procedure "Warehouse Shipment Header_OnBeforeErrorIfUserIsNotWhseEmployee"(LocationCode: Code[10]; var IsHandled: Boolean)
    var
        ZonewarehouseMovements: page "Zone Warehouse Movements";
    begin
        zonewarehouseMovements.CheckUserIsWhseEmployee_DTW();
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Warehouse Receipt Header", OnBeforeErrorIfUserIsNotWhseEmployee, '', false, false)]
    local procedure "Warehouse Receipt Header_OnBeforeErrorIfUserIsNotWhseEmployee"(LocationCode: Code[10]; var IsHandled: Boolean)
    var
        ZonewarehouseMovements: page "Zone Warehouse Movements";
    begin
        zonewarehouseMovements.CheckUserIsWhseEmployee_DTW();
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"WMS Management", OnBeforeCheckUserIsWhseEmployee, '', false, false)]
    local procedure "WMS Management_OnBeforeCheckUserIsWhseEmployee"(Location: Record Location; var IsHandled: Boolean)
    var
        WarehouseEmployee: Record "Warehouse Employee_DTW FND";
        ZonewarehouseMovements: page "Zone Warehouse Movements";
    begin

        if UserId <> '' then begin
            WarehouseEmployee.SetRange("User ID", UserId);
            if WarehouseEmployee.IsEmpty() then
                ZonewarehouseMovements.CheckUserIsWhseEmployee_DTW();
        end;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Get Source Doc. Outbound", OnBeforeOpenWarehouseShipmentPage, '', false, false)]
    local procedure "Get Source Doc. Outbound_OnBeforeOpenWarehouseShipmentPage"(var GetSourceDocuments: Report "Get Source Documents"; var IsHandled: Boolean)
    var
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";

    begin
        GetSourceDocuments.GetCreatedShptHeaders(WarehouseShipmentHeader);
        WarehouseShipmentHeader.MarkedOnly(true);
        WarehouseShipmentHeader.FindSet();
        repeat
            CheckUserIsWhseEmployeeForLocationCustom(WarehouseShipmentHeader."Location Code", true);
        until WarehouseShipmentHeader.Next() = 0;
        case WarehouseShipmentHeader.Count() of
            1:
                Page.Run(Page::"Warehouse Shipment", WarehouseShipmentHeader);
            else
                Page.Run(Page::"Warehouse Shipment List", WarehouseShipmentHeader);
        end;
        IsHandled := true;
    end;

    procedure CheckUserIsWhseEmployeeForLocationCustom(LocationCode: Code[10]; DoCommit: Boolean)
    var
        WarehouseEmployee: Record "Warehouse Employee_DTW FND";
        UserIsNotWhseEmployeeForLocationErr: Label 'To open warehouse document for location %1, You must first set up user %2 as a warehouse employee.', Comment = '%1: Location Code, %2: User Id';
    begin
        if UserId <> '' then begin
            if DoCommit then
                Commit();

            WarehouseEmployee.SetRange("User ID", UserId);
            WarehouseEmployee.SetRange("Location Code", LocationCode);
            if WarehouseEmployee.IsEmpty() then
                ConfirmOpenWarehouseEmployees(WarehouseEmployee, StrSubstNo(UserIsNotWhseEmployeeForLocationErr, LocationCode, UserId()));
        end;
    end;

    local procedure ConfirmOpenWarehouseEmployees(var WarehouseEmployee: Record "Warehouse Employee_DTW FND"; ErrorMessage: Text)
    var
        WarehouseEmployeeLocal: Record "Warehouse Employee_DTW FND";
        ConfirmManagement: Codeunit "Confirm Management";
        WarehouseEmployees: Page "Warehouse Employees_DTW CBN";
        ConfirmText: TextBuilder;
        WarehouseEmployeeExists: Boolean;
        OpenWarehouseEmployeesPageQst: Label 'Do you want to do that now?';

    begin
        ConfirmText.AppendLine(ErrorMessage);
        ConfirmText.AppendLine();
        ConfirmText.AppendLine(OpenWarehouseEmployeesPageQst);

        WarehouseEmployeeLocal.CopyFilters(WarehouseEmployee);
        WarehouseEmployeeLocal.SetRange(Default);

        if ConfirmManagement.GetResponseOrDefault(ConfirmText.ToText(), false) then begin
            WarehouseEmployees.SetTableView(WarehouseEmployeeLocal);
            WarehouseEmployees.RunModal();
            if not WarehouseEmployee.IsEmpty() then
                WarehouseEmployeeExists := true;
        end;

        if not WarehouseEmployeeExists then
            Error(ErrorMessage);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Get Source Doc. Inbound", OnOpenWarehouseReceiptPage, '', false, false)]
    local procedure "Get Source Doc. Inbound_OnOpenWarehouseReceiptPage"(WarehouseReceiptHeader: Record "Warehouse Receipt Header"; ServVendDocNo: Code[20]; var IsHandled: Boolean; var GetSourceDocuments: Report "Get Source Documents")
    begin
        //BC UPGRADE PATHAA02 08.06.26>> 
        GetSourceDocuments.GetCreatedReceiptHeaders(WarehouseReceiptHeader);
        WarehouseReceiptHeader.MarkedOnly(true);
        WarehouseReceiptHeader.FindSet();
        //BC UPGRADE PATHAA02 08.06.26<<
        repeat
            CheckUserIsWhseEmployeeForLocationCustom(WarehouseReceiptHeader."Location Code", true);
        until WarehouseReceiptHeader.Next() = 0;
        case WarehouseReceiptHeader.Count() of
            1:
                Page.Run(Page::"Warehouse Receipt", WarehouseReceiptHeader);
            else
                Page.Run(Page::"Warehouse Receipts", WarehouseReceiptHeader);
        end;
        IsHandled := true;
    end;

    //BC Upgrade FDD-DTW-015 >> warehouse employee bug fix 05.06.26

    //BCUP0-92 PATHAA02 09.07.26>>'
    [EventSubscriber(ObjectType::Report, Report::"Calculate Inventory Value", OnAfterInsertItemJnlLine, '', false, false)]
    local procedure "Calculate Inventory Value_OnAfterInsertItemJnlLine"(var ItemJournalLine: Record "Item Journal Line"; EntryType2: Enum "Item Ledger Entry Type"; ItemNo2: Code[20]; VariantCode2: Code[10]; LocationCode2: Code[10]; Quantity2: Decimal; Amount2: Decimal; ApplyToEntry2: Integer; AppliedAmount: Decimal; CalcBase: Enum "Inventory Value Calc. Base")
    var
        ItemJnlTemplate: Record "Item Journal Template";
    begin
        ItemJnlTemplate.Get(ItemJournalLine."Journal Template Name");
        ItemJnlTemplate.TestField(Type, ItemJnlTemplate.Type::Revaluation);
        IF ItemJnlTemplate."Def. Gen. Bus. Posting Group FND" <> '' THEN begin
            ItemJournalLine."Gen. Bus. Posting Group" := ItemJnlTemplate."Def. Gen. Bus. Posting Group FND";
            ItemJournalLine.Modify(false);
        end;
    end;

    [EventSubscriber(ObjectType::Report, Report::"Implement Standard Cost Change", OnBeforeCalculateInventoryValue, '', false, false)]
    local procedure "Implement Standard Cost Change_OnBeforeCalculateInventoryValue"(var ItemJournalTemplate: Record "Item Journal Template"; var StandardCostWorksheet: Record "Standard Cost Worksheet"; PostingDate: Date; DocNo: Code[20]; HideDuplWarning: Boolean; var IsHandled: Boolean; var ItemJournalBatch: Record "Item Journal Batch")
    var
        ItemJnlLine: Record "Item Journal Line";
        Item: Record Item;
        CalcInvtValue: Report "Calculate Inventory Value";
        CalculatePer: Enum "Inventory Value Calc. Per";
    begin
        ItemJnlLine."Journal Template Name" := ItemJournalTemplate.Name;
        ItemJnlLine."Journal Batch Name" := ItemJournalTemplate.Name;
        IF ItemJournalTemplate."Def. Gen. Bus. Posting Group FND" <> '' THEN
            ItemJnlLine."Gen. Bus. Posting Group" := ItemJournalTemplate."Def. Gen. Bus. Posting Group FND";
        CalcInvtValue.SetItemJnlLine(ItemJnlLine);
        Clear(Item);
        Item.SetRange("No.", StandardCostWorksheet."No.");
        CalcInvtValue.SetTableView(Item);
        CalcInvtValue.SetParameters(PostingDate, DocNo, HideDuplWarning, CalculatePer::Item, false, false, false, "Inventory Value Calc. Base"::" ", false);
        CalcInvtValue.UseRequestPage(false);
        CalcInvtValue.Run();
        IsHandled := true;
    end;
    //BCUP0-92 PATHAA02 09.07.26<<
    //BC Upgrade GUNREM01 -Workflow auto Posting >>
    procedure PostItemJournalAsyncCode(): Code[128]
    begin
        //HEI.07>>
        EXIT(UPPERCASE('BackgroundPostApprovedItemLines'));
        //HEI.07<<
    end;

    LOCAL procedure PostItemJournalAsync(Variant: Variant)
    var
        RecRef: RecordRef;
        Fldref: FieldRef;
        ApprovalEntry: Record "Approval Entry";
        JobQueueEntry: Record "Job Queue Entry";
        UnsupportedRecordTypeErr: Label 'Record type %1 is not supported by this workflow response.';
    begin
        //HEI.07>>
        RecRef.GETTABLE(Variant);
        CASE RecRef.NUMBER OF
            DATABASE::"Approval Entry":
                BEGIN
                    Fldref := RecRef.FIELD(ApprovalEntry.FIELDNO("Table ID"));
                    IF FORMAT(Fldref.VALUE) = '233' THEN BEGIN
                        ApprovalEntry := Variant;
                        JobQueueEntry.ScheduleJobQueueEntry(CODEUNIT::"Item Jnl. Post via Job Que CBN", ApprovalEntry."Record ID to Approve");
                    END;
                END;
            ELSE
                ERROR(UnsupportedRecordTypeErr, RecRef.CAPTION);
        END;
    end;
    //HEI.07<<

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnAfterAllowRecordUsage, '', false, false)]
    local procedure "Workflow Response Handling_OnAfterAllowRecordUsage"(Variant: Variant; var RecRef: RecordRef)
    var

        ApprovalEntry: Record "Approval Entry";
        GenJournalBatch: Record "Gen. Journal Batch";
        RecordRestrictionMgt: Codeunit "Record Restriction Mgt.";
        ItemJournalBatch: Record "Item Journal Batch";
    begin
        case RecRef.Number of
            //HEI.07>>
            DATABASE::"Item Journal Batch":
                BEGIN
                    RecRef.SETTABLE(ItemJournalBatch);
                    RecordRestrictionMgt.AllowItemJournalBatchUsage(ItemJournalBatch);
                END;
        //HEI.07<<
        end;
    end;
    //BC Upgrade GUNREM01 -Workflow auto Posting <<

    var
        //GUNREM01 Added var
        // WHSUtils: Codeunit 50001;
        WHSUtils: Codeunit "WHS-UTILS";
        ProdOrderLineInsert: Boolean;
        CreateLog: Boolean;
        ItemJnlLineError: Record "Item Journal Line";
        ErrorTextL: Text[250];
    //GUNREM01 Added var
}
