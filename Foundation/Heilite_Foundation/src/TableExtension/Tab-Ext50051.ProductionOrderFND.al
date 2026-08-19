tableextension 50051 ProductionOrderExtFND extends "Production Order"
{
    // version NAVW111.00.20783,FINXL8.00.001,MANXL10.01,QXL9.00.001,DITW111.00.13,HEI.18

    // version NAVW111.00.20783,FINXL8.00.001,MANXL10.01,QXL9.00.001,DITW111.00.13,HEI.18
    //BC Upgrade PATHAA02-HEI.04(Description non-editable not supported as it is std field-try on page, HEI.06-DIT
    //Astro-HEI.14 to HEI.18-commented (Fields 50020-50042) & Function-ValidateAstroProdOrderModification commented
    //     FINXL7.00.001 RBE 10/10/2013: Expanded fields from 50->80
    // FINXL8.00.001 BSA 05/06/2015 #182: Added Field "Emergency Order"
    // MANXL7.00.001 DAT 03/03/2014 #10: Subcontractors Dispatch Screen
    // MANXL7.00.001 DAT 04/03/2014 #13: Prod. Order KPI's in overview screen
    // MANXL7.00.001 WSA 11/07/2014 #87: Added code MANXL security

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.03 MSF 28/05/2014 DIT-770 #715 Upgrade W1 Rollup 6 ChangeLog.W1.36366 file 474255
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //                                          Disabled fields
    //                                            2035166 _Product Group Code
    //                                            2035208 _Item Category Code
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 AKH 10/02/2015 DIT-770 #1184 Multisite - Production Orders: Consider possible BOM and Routing setup on SKU card
    // DITW18.00.06 AKH 17/02/2015 DIT-770 #1197 Multisite - Site dimension in item transactions : Added code to register the site dimension when selecting a location
    // DITW18.00.06 AKH 20/02/2015 DIT-770 #1197 Multisite - Site dimension in item transactions : Extended function CreateDim()
    // DITW18.00.06 MSF 26/02/2015 DIT-770 #1192 Added fields 2014410 "Responsibility Center"
    //                                                        2014411 "Physical Location Group Code"
    //                                                        2014412 "Resp. Center Table Filter"
    //                                                        2014513 "Phys. Location Table Filter"
    //                                                        2014514 "Location Table Filter"
    //                                           Added function SetSecurityFilterOnRespCenter
    // DITW18.00.06 MSF 03/03/2015 DIT-770 #1192 Bug Fix
    // DITW18.00.06 MSF 05/06/2015 DIT-770 #1416 #1417 Error message when no setup on Resp Center employee location
    // DITW18.00.06 MSF 11/06/2015 DIT-770 #1416 #1417 Restore code
    // DITW19.00.07 MVN 30/12/2015 DIT-770 #001 Upgrade Set Global CreateDim
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    // DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                      Added functions GetTaxSpecCaption(),GetTaxSpecCaptionText(),GetTaxSpecCaptionText2(),GetGlobalTaxSpecFormatType(),
    //                                                        GetGlobalTaxSpecValue(),OpenLossOutputJournal()
    // DITW19.00.08 DDR 20/10/2016 BL#10443 Added flowfields
    //                                       2013718 Vol-Strength Spec. Code
    //                                       2013719 Balance Vol-Strength Value
    //                                       2013720 Consumption Vol-Strength Value
    //                                       2013721 Output Vol-Strength Value
    //                                       2013722 Loss Vol-Strength Value
    //                                       2013723 Exist Loss Strength Journal
    // DITW19.00.08 DDR 13/12/2016 BL#10443 Added journal batch name as Production Order No.
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 02/02/2017 NRQ#20692 Item Category Code length 20
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // DITW110.00.09 AKH 29/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // DITW110.00.11 SFI 31/08/2017 BL#30569 Added changes for SKU blocking
    // DITW110.00.12 AKH 21/03/2018 NRQ#64704 Added new fields 2014420"Unit of Measure Code"
    //                                                         2014421"Qty. per Unit of Measure"
    //                                                         2014422"Quantity (Base)"
    //                                                         2014423"Unit Volume HL"
    //                                                         2014424"Quantity HL"
    // DITW110.00.12A HBA 18/06/2018 NRQ#68221 Added new fields 2035270 "Routing Version Code"
    //                                                          2035271 "Routing Version Description"
    //                                                          2035272 "Production BOM No."
    //                                                          2035273 "Production BOM Version Code"
    //                                                          2035274 "Production BOM Version Desc."
    //                                         Added Code in Location Code - OnValidate()
    // DITW110.00.12A HBA 22/06/2018 NRQ#68221 Adjusted code to update "Production BOM No." and "Routing No."
    // DITW110.00.12A HBA 05/06/2018 NRQ#72678 Adjusted code in fctCalcQuantityPlannedVsAct to display finished quantity
    // DITW111.00.13 ISL 13/09/2018 NRQ#84282 Added function fctCalcQuantityFinished to display finished quantity
    // DITW111.00.13 ISL 31/10/2018 NRQ#89922 Adjusted code to update "Production BOM No."
    // DITW111.00.13 ISL 05/11/2018 NRQ#89922 Adjusted code to update versions of "Production BOM No." and "Routing No."
    // DITW111.00.13 MZOU 07/11/2018 NRQ#91446 Routing, BOM and Version should not be changed in the production order when ledger entries exist

    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #added fields Zone Code and validation
    // HEI.02 FDD-PRDGAP024 IBM SOICAD01 25.07.2017 #Changed Zone code table relation to not show in transit zones
    //   #bring zone code when bin code is filled
    // HEI.03 FDD-PRDGAP024 IBM POENAB01 01.08.2017 #solved problems with Bin and Zone validation

    // HEI.04 FDD-GAPID031 IBM.PATHAA02 17.08.2017
    //   # Description made non-Editable

    // HEI.05 FDD-PRDGAP027 , No Lot No., Bin code in FPO and RPO, Production Journal Page, IBM.NAIKH01 22.08.2017
    //   # Code commented on Function "GetDefaultBin()" , Not to show Default Bin Code in the Production Order Page.
    // HEI.06 Defect #2799 IBM NASTAA02 24.09.2018 # Wort RPO tile not acesible
    //   # Merged code for function "fctCalcQuantityPlannedVsAct"
    // HEI.08 CHG2069358 IBM.AK 25.08.20
    //  # Added Field - Created By
    //  # Code added on InitRecord()

    // HEI.09 CHG2070663 IBM POENAB02 18.09.2020 Role Centre Production Bottling Role Centre
    //  # New field: 50002 Role Centre Tile Code
    //  # New function: UpdateTileCode
    // HEI.10 CHG2098891 IBM.LS      19.07.2021
    //   # Changed caption on Field: 28 - from Blocked to Admin. Completed
    // HEI.11 CHG2119017 IBM.LS      20.08.2021
    //   # Added Code
    // HEI.12 CHG2120096 IBM.LS      09.09.2021
    //   # Added Code
    // HEI.13 CHG2129985 IBM.LS      15.03.2022
    //   # Created New Fields: 50003 - Prod. Order Interface
    //                         50004 - Prod. Order Output Interface
    //                         50005 - Parked for LogoPak
    //                         50006 - Parked from LogoPak
    //                         50007 - Posted from LogoPak
    //   # Added CaptionML for above fields
    // HEI.14 CHG2149734 SAHAL01 07.09.2022
    //   # Created New Fields: 50020 - Prod. ORDER Interface Astro
    //                         50021 - Parked ORDER Astro
    //                         50022 - Last Parked Date ORDER Astro
    //                         50023 - Last Parked Time ORDER Astro
    //   # Added Code to restrict modification after Parked the Prod. Order for Astro.
    // HEI.15 CHG2154370 SAHAL01 05.09.2022
    //   # Created New Fields: 50040 - Prod. CLOSE Interface Astro
    //                         50041 - Last Parked Date CLOSE Astro
    //                         50042 - Last Parked Time CLOSE Astro
    // HEI.16 CHG2154367 SAHAL01 12.09.2022
    //   # Created New Fields: 50030 - Prod. OUTPUT Interface Astro
    //                         50031 - Parked OUTPUT Astro
    //                         50032 - Last Parked Date OUTPUT Astro
    //                         50033 - Last Parked Time OUTPUT Astro
    //                         50034 - Posted OUTPUT Astro
    // HEI.17 CHG2154364 SAHAL01 20.10.2022
    //   # Created New Fields: 50025 - Prod. LINEPICK Interface Astro
    //                         50026 - Parked LINEPICK Astro
    //                         50027 - Last Parked Date LINEPICKAstro
    //                         50028 - Last Parked Time LINEPICKAstro
    //                         50029 - Posted LINEPICK Astro
    // HEI.18 CHG2154372 SAHAL01 15.12.2022 Astro - I/F Inventory Management - BalanceChange
    //   # Created New Fields: 50035 - OUTPUT Revers Interface Astro
    //                         50036 - Parked OUTPUT Revers Astro
    //                         50037 - Last Parked Date OUTPUTR Astro
    //                         50038 - Last Parked Time OUTPUTR Astro
    //                         50039 - Posted OUTPUT Revers Astro
    // HEI.19 CHG2211537 IBM PRASAA03 18.04.2024 # Mass Upload of Production Orders
    //   # 50043 Loading date and time field is added.

    //BC Upgrade PATHAA02-HEI.04(Description non-editable not supported as it is std field-try on page, HEI.06-DIT
    //Astro-HEI.14 to HEI.18-commented (Fields 50020-50042) & Function-ValidateAstroProdOrderModification commented

    // BC Upgrade SHUKLP03 >> Added in the interface extension.
    // HEI.13 CHG2129985 IBM.LS      15.03.2022
    //   # Created New Fields: 50003 - Prod. Order Interface
    //                         50004 - Prod. Order Output Interface
    //                         50005 - Parked for LogoPak
    //                         50006 - Parked from LogoPak
    //                         50007 - Posted from LogoPak
    // BC Upgrade SHUKLP03 << Added in the interface extension.
    //FAT1-BC UPGRADE PATHAA02 22.01.26 - Added Bin code table relation to showcase Bins linked to Zones.
    // BC Upgrade Kamnay01 >> Added new field "Production Unit of Measure" and added code in Base Unit of Measure OnValidate trigger to set Production Unit of Measure.
    fields
    {
        modify(Status)
        {
            CaptionML = ENU = 'Status', FRA = 'Statut';
            //OptionCaptionML = ENU = 'Simulated,Planned,Firm Planned,Released,Finished', FRA = 'Simulé,Planifié,Planifié ferme,Lancé,Terminé';

        }
        modify("No.")
        {

            //Unsupported feature: Change TableRelation on ""No."(Field 2)". Please convert manually.

            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
            //Unsupported feature: Change Description on "Description(Field 3)". Please convert manually.
            //Unsupported feature: Change Editable on "Description(Field 3)". Please convert manually.

        }
        modify("Search Description")
        {
            CaptionML = ENU = 'Search Description', FRA = 'Désignation de recherche';
        }
        modify("Description 2")
        {
            CaptionML = ENU = 'Description 2', FRA = 'Désignation 2';
        }
        modify("Creation Date")
        {
            CaptionML = ENU = 'Creation Date', FRA = 'Date création';
        }
        modify("Last Date Modified")
        {
            CaptionML = ENU = 'Last Date Modified', FRA = 'Date dern. modification';
        }
        modify("Source Type")
        {
            CaptionML = ENU = 'Source Type', FRA = 'Type origine';
            //OptionCaptionML = ENU = 'Item,Family,Sales Header', FRA = 'Article,Famille,Ventes';
        }
        modify("Source No.")
        {

            //Unsupported feature: Change TableRelation on ""Source No."(Field 10)". Please convert manually.

            CaptionML = ENU = 'Source No.', FRA = 'N° origine';
            // BC Upgrade Kamnay01 >> Added code in OnAfterValidate trigger to set Unit of Measure Code as Production Unit of Measure from Item table when Source Type is Item.
            trigger OnAfterValidate()
            var
                RecItem: Record Item;
            begin
                //
                RecItem.get("Source No.");
                "Unit of Measure Code FND" := RecItem."Production Unit of Measure FND";
            end;
            //BC Upgrade Kamnay01 << Added code in OnAfterValidate trigger to set Unit of Measure Code as Production Unit of Measure from Item table when Source Type is Item.
        }
        modify("Routing No.")
        {
            CaptionML = ENU = 'Routing No.', FRA = 'N° gamme';
        }
        modify("Inventory Posting Group")
        {
            CaptionML = ENU = 'Inventory Posting Group', FRA = 'Groupe compta. stock';
        }
        modify("Gen. Prod. Posting Group")
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group', FRA = 'Groupe compta. produit';
        }
        modify("Gen. Bus. Posting Group")
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group', FRA = 'Groupe compta. marché';
        }
        modify(Comment)
        {

            //Unsupported feature: Change CalcFormula on "Comment(Field 19)". Please convert manually.

            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify("Starting Time")
        {
            CaptionML = ENU = 'Starting Time', FRA = 'Heure début';
        }
        modify("Starting Date")
        {
            CaptionML = ENU = 'Starting Date', FRA = 'Date début';
        }
        modify("Ending Time")
        {
            CaptionML = ENU = 'Ending Time', FRA = 'Heure fin';
        }
        modify("Ending Date")
        {
            CaptionML = ENU = 'Ending Date', FRA = 'Date fin';
        }
        modify("Due Date")
        {
            CaptionML = ENU = 'Due Date', FRA = 'Date d''échéance';
        }
        modify("Finished Date")
        {
            CaptionML = ENU = 'Finished Date', FRA = 'Date réalisation';
        }
        modify(Blocked)
        {
            CaptionML = ENU = 'Admin. Completed', FRA = 'Bloqué';

            //Unsupported feature: Change Description on "Blocked(Field 28)". Please convert manually.

        }
        modify("Shortcut Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Shortcut Dimension 1 Code"(Field 30)". Please convert manually.

            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Shortcut Dimension 2 Code"(Field 31)". Please convert manually.

            CaptionML = ENU = 'Shortcut Dimension 2 Code', FRA = 'Code raccourci axe 2';
        }
        modify("Location Code")
        {

            //Unsupported feature: Change TableRelation on ""Location Code"(Field 32)". Please convert manually.

            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';

            //BC Upgrade PATHAA02>>

            trigger OnBeforeValidate()
            var
                Item: Record Item;
            begin
                //BC Upgrade kamnay01 >> Bug fix RPO and FPO
                IF Status IN [Status::"Firm Planned", Status::Released] THEN BEGIN
                    Rec.CheckUserAuthorizedinZone("Location Code", xRec."Zone Code FND");
                    Rec.CheckUserAuthorizedinZone("Location Code", "Zone Code FND");
                end;
                //BC Upgrade kamnay01 << Bug fix RPO and FPO
                //HEI.01 PRDGAP024>>
                "Zone Code FND" := '';
                "Bin Code" := '';
                //HEI.01 PRDGAP024<<

                //BC Upgrade GUNREM01- Blocked SKU FDD-DTW 12 >>
                IF ("Source Type" = "Source Type"::Item) And ("Source No." <> '') THEN BEGIN

                    Item.GET("Source No.");
                    Item.BlockedSKU("Location Code", '', TRUE);
                END;
                //

                //  DITW110.00.11 SFI BL#30569
            end;
            //BC Upgrade GUNREM01- Blocked SKU FDD-DTW 12 <<
            //BC Upgrade PATHAA02<<

            //BC Upgrade kamnay01 >> Bug fix RPO and FPO
            trigger OnAfterValidate()
            var
                Sku: Record "Stockkeeping Unit";
                productionversn: Record "Production BOM Version";
                routingversn: Record "Routing Version";
            begin
                if (Rec."Source No." <> '') and (Rec."Location Code" <> '') then begin
                    Sku.Get(Rec."Location Code", Rec."Source No.");
                    if (Sku."Production BOM No." <> '') and (Sku."Routing No." <> '') then begin
                        Rec.Validate("Routing No. 112FDW", Sku."Routing No.");
                        Rec.Validate(Rec."Prod. BOM No. 112FDW", Sku."Production BOM No.");

                        productionversn.Reset();
                        productionversn.SetRange("Production BOM No.", Rec."Prod. BOM No. 112FDW");
                        productionversn.SetRange("Active FND", true);
                        if productionversn.FindFirst() then
                            Rec.Validate("Prod. BOM Vrsn Code 112FDW", productionversn."Version Code");

                        routingversn.Reset();
                        routingversn.SetRange("Routing No.", Rec."Routing No. 112FDW");
                        routingversn.SetRange("Active FND", true);
                        if routingversn.FindFirst() then
                            Rec.Validate("Routing Vrsn Code 112FDW", routingversn."Version Code");
                    end else begin
                        Rec.Validate("Prod. BOM No. 112FDW", '');
                        Rec.Validate("Routing No. 112FDW", '');
                        Rec.Validate("Routing Vrsn Code 112FDW", '');
                        Rec.Validate("Prod. BOM Vrsn Code 112FDW", '');
                    end;
                end;
            end;
            //BC Upgrade kamnay01 << Bug fix RPO and FPO



        }
        modify("Bin Code")
        {
            //BC UPGRADE PATHAA02-FAT1 22.01.26>>
            TableRelation = IF ("Source Type" = CONST(Item)) Bin.Code WHERE("Location Code" = FIELD("Location Code"), "Item Filter" = FIELD("Source No."), "Zone Code" = FIELD("Zone Code FND"))
            ELSE IF ("Source Type" = FILTER(<> Item)) Bin.Code WHERE("Location Code" = FIELD("Location Code"));
            //BC UPGRADE PATHAA02-FAT1 22.01.26<<

            //Unsupported feature: Change TableRelation on ""Bin Code"(Field 33)". Please convert manually.

            CaptionML = ENU = 'Bin Code', FRA = 'Code emplacement';
            //BC Upgrade PATHAA02>>
            trigger OnAfterValidate()
            var
                Bin: Record Bin;
                BinL: Record Bin;
                DefaultDimensionL: Record "Default Dimension";
                InventorySetupL: Record "Inventory Setup";
                Text000L: Label 'The Bin Code - %1 is not empty. Would you like to proceed?';
            begin
                //HEI.01 PRDGAP024>>
                //"Zone Code FND" := '';
                IF ("Bin Code" <> '') AND ("Zone Code FND" <> '') THEN BEGIN
                    IF Bin.GET("Location Code", "Bin Code") THEN
                        //HEI.03 PRDGAP024>>
                        //VALIDATE("Zone Code FND",Bin."Location Code");
                        VALIDATE("Zone Code FND", Bin."Zone Code");
                    //HEI.03 PRDGAP024<<
                end;
                //HEI.01 PRDGAP024<<

                //HEI.11>>
                IF CurrFieldNo <> 0 THEN BEGIN
                    InventorySetupL.GET();
                    IF (InventorySetupL."CMG Code for Empty Bin FND" <> '') AND ("Source Type" = "Source Type"::Item) THEN BEGIN
                        IF ("Bin Code" <> '') AND BinL.GET("Location Code", "Bin Code") AND (NOT BinL.Empty) THEN BEGIN
                            DefaultDimensionL.SETCURRENTKEY("Table ID", "No.", "Dimension Code", "Dimension Value Code");
                            DefaultDimensionL.SETRANGE("Table ID", DATABASE::Item);
                            DefaultDimensionL.SETRANGE("No.", "Source No.");
                            DefaultDimensionL.SETRANGE("Dimension Code", 'CMG');
                            DefaultDimensionL.SETFILTER("Dimension Value Code", InventorySetupL."CMG Code for Empty Bin FND");
                            IF DefaultDimensionL.FINDFIRST() THEN BEGIN
                                IF NOT CONFIRM(Text000L, FALSE, "Bin Code") THEN
                                    ERROR('');
                            end;
                        end;
                    end;
                end;
                //HEI.11<<

            end;
            //BC Upgrade PATHAA02<<

        }
        modify("Replan Ref. No.")
        {
            CaptionML = ENU = 'Replan Ref. No.', FRA = 'N° réf. replanification';
        }
        modify("Replan Ref. Status")
        {
            CaptionML = ENU = 'Replan Ref. Status', FRA = 'Statut réf. replanification';
            //OptionCaptionML = ENU = 'Simulated,Planned,Firm Planned,Released,Finished', FRA = 'Simulé,Planifié,Planifié ferme,Lancé,Terminé';
        }
        modify("Low-Level Code")
        {
            CaptionML = ENU = 'Low-Level Code', FRA = 'Code plus bas niveau';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Unit Cost")
        {
            CaptionML = ENU = 'Unit Cost', FRA = 'Coût unitaire';
        }
        modify("Cost Amount")
        {
            CaptionML = ENU = 'Cost Amount', FRA = 'Coût total';
        }
        modify("Work Center Filter")
        {
            CaptionML = ENU = 'Work Center Filter', FRA = 'Filtre centre de charge';
        }
        modify("Capacity Type Filter")
        {
            CaptionML = ENU = 'Capacity Type Filter', FRA = 'Filtre type capacité';
            //OptionCaptionML = ENU = 'Work Center,Machine Center', FRA = 'Centre de charge,Poste de charge';
        }
        modify("Capacity No. Filter")
        {

            //Unsupported feature: Change TableRelation on ""Capacity No. Filter"(Field 49)". Please convert manually.

            CaptionML = ENU = 'Capacity No. Filter', FRA = 'Filtre capacité';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify("Expected Operation Cost Amt.")
        {

            //Unsupported feature: Change CalcFormula on ""Expected Operation Cost Amt."(Field 51)". Please convert manually.

            CaptionML = ENU = 'Expected Operation Cost Amt.', FRA = 'Coût opératoire total prévu';
        }
        modify("Expected Component Cost Amt.")
        {

            //Unsupported feature: Change CalcFormula on ""Expected Component Cost Amt."(Field 52)". Please convert manually.

            CaptionML = ENU = 'Expected Component Cost Amt.', FRA = 'Coût composant total prévu';
        }
        modify("Actual Time Used")
        {

            //Unsupported feature: Change CalcFormula on ""Actual Time Used"(Field 55)". Please convert manually.

            CaptionML = ENU = 'Actual Time Used', FRA = 'Temps passé réel';
        }
        modify("Allocated Capacity Need")
        {

            //Unsupported feature: Change CalcFormula on ""Allocated Capacity Need"(Field 56)". Please convert manually.

            CaptionML = ENU = 'Allocated Capacity Need', FRA = 'Charge allouée';
        }
        modify("Expected Capacity Need")
        {

            //Unsupported feature: Change CalcFormula on ""Expected Capacity Need"(Field 57)". Please convert manually.

            CaptionML = ENU = 'Expected Capacity Need', FRA = 'Charge prévue';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Planned Order No.")
        {
            CaptionML = ENU = 'Planned Order No.', FRA = 'N° O.F. planifié';
        }
        modify("Firm Planned Order No.")
        {
            CaptionML = ENU = 'Firm Planned Order No.', FRA = 'N° O.F. planifié ferme';
        }
        modify("Simulated Order No.")
        {
            CaptionML = ENU = 'Simulated Order No.', FRA = 'N° O.F. simulé';
        }
        modify("Expected Material Ovhd. Cost")
        {

            //Unsupported feature: Change CalcFormula on ""Expected Material Ovhd. Cost"(Field 92)". Please convert manually.

            CaptionML = ENU = 'Expected Material Ovhd. Cost', FRA = 'Frais généraux matière prévus';
        }
        modify("Expected Capacity Ovhd. Cost")
        {

            //Unsupported feature: Change CalcFormula on ""Expected Capacity Ovhd. Cost"(Field 94)". Please convert manually.

            CaptionML = ENU = 'Expected Capacity Ovhd. Cost', FRA = 'Frais gén. opératoires prévus';
        }
        modify("Starting Date-Time")
        {
            CaptionML = ENU = 'Starting Date-Time', FRA = 'Date/Heure début';
        }
        modify("Ending Date-Time")
        {
            CaptionML = ENU = 'Ending Date-Time', FRA = 'Date/Heure fin';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Completely Picked")
        {

            //Unsupported feature: Change CalcFormula on ""Completely Picked"(Field 7300)". Please convert manually.

            CaptionML = ENU = 'Completely Picked', FRA = 'Entièrement prélévé';
        }
        modify("Assigned User ID")
        {
            CaptionML = ENU = 'Assigned User ID', FRA = 'Code utilisateur affecté';
        }
        //BC Upgrade GUNREM01 modify DIT fields >>
        modify("Prod. BOM Vrsn Code 112FDW")
        {


            trigger OnAfterValidate()
            var
                CapLedgEntry: Record "Capacity Ledger Entry";
            begin
                // <<DITW110.00.12A HBA 22/06/2018 NRQ#68221
                IF Rec."Prod. BOM Vrsn Code 112FDW" <> xRec."Prod. BOM Vrsn Code 112FDW" THEN BEGIN
                    //<< DITW111.00.13 MZOU 07/11/2018 NRQ#91446
                    IF Status = Status::Released THEN BEGIN
                        IF CheckCapLedgEntry() THEN
                            ERROR(
                              Text2035240,
                              FIELDCAPTION("Prod. BOM Vrsn Code 112FDW"), xRec."Prod. BOM Vrsn Code 112FDW", CapLedgEntry.TABLECAPTION);
                    END;
                    //>> DITW111.00.13 MZOU NRQ#91446
                    // CALCFIELDS("Production BOM Version Desc.");
                    //<< DITW111.00.13 MZOU 07/11/2018 NRQ#91446
                END;
                //>> DITW111.00.13 MZOU NRQ#91446
                // >>DITW110.00.12A HBA NRQ#68221
            end;
        }
        modify("Routing Vrsn Code 112FDW")
        {


            trigger OnAfterValidate()
            var
                CapLedgEntry: Record "Capacity Ledger Entry";
            begin
                // <<DITW110.00.12A HBA 22/06/2018 NRQ#68221
                IF Rec."Routing Vrsn Code 112FDW" <> xRec."Routing Vrsn Code 112FDW" THEN BEGIN
                    //<< DITW111.00.13 MZOU 07/11/2018 NRQ#91446
                    IF Status = Status::Released THEN BEGIN
                        IF CheckCapLedgEntry() THEN
                            ERROR(
                              Text2035240,
                              FIELDCAPTION("Routing Vrsn Code 112FDW"), xRec."Routing Vrsn Code 112FDW", CapLedgEntry.TABLECAPTION);
                    END;
                    //>> DITW111.00.13 MZOU NRQ#91446
                    //  CALCFIELDS("Routing Version Description");
                    //<< DITW111.00.13 MZOU 07/11/2018 NRQ#91446
                END;
                //<< DITW111.00.13 MZOU NRQ#91446
                // >>DITW110.00.12A HBA NRQ#68221
            end;
        }

        modify("Prod. BOM No. 112FDW")
        {
            trigger OnAfterValidate()
            var
                CapLedgEntry: Record "Capacity Ledger Entry";
            begin
                // <<DITW110.00.12A HBA 22/06/2018 NRQ#68221
                IF Rec."Prod. BOM No. 112FDW" <> xRec."Prod. BOM No. 112FDW" THEN BEGIN
                    //<< DITW111.00.13 MZOU 07/11/2018 NRQ#91446
                    IF Status = Status::Released THEN BEGIN
                        IF CheckCapLedgEntry() THEN
                            ERROR(
                              Text2035240,
                              FIELDCAPTION("Prod. BOM No. 112FDW"), xRec."Prod. BOM No. 112FDW", CapLedgEntry.TABLECAPTION);
                    END;
                    //>> DITW111.00.13 MZOU NRQ#91446
                    VALIDATE("Prod. BOM Vrsn Code 112FDW", VersionMgt.GetBOMVersion("Prod. BOM No. 112FDW", "Due Date", TRUE));
                    //  CALCFIELDS("Prod. BOM Version Desc.");
                END;
                // >>DITW110.00.12A HBA NRQ#68221
            end;
        }
        //BC Upgrade GUNREM01 Modified DITfields <<

        //Unsupported feature: CodeModification on ""No."(Field 2).OnValidate". Please convert manually.

        //trigger "(Field 2)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "No." <> xRec."No." THEN BEGIN
            MfgSetup.GET;
            NoSeriesMgt.TestManual(GetNoSeriesCode);
            "No. Series" := '';
          end;
          */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
          if "No." <> xRec."No." then begin
          #2..4
          end;
          */
        //end;


        //Unsupported feature: CodeModification on ""Source Type"(Field 9).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
          IF "Source Type" <> xRec."Source Type" THEN
            CheckProdOrderStatus(FIELDCAPTION("Source Type"));
          */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
          if "Source Type" <> xRec."Source Type" then
            CheckProdOrderStatus(FIELDCAPTION("Source Type"));
          //<<MANXL7.00.001 WSA 11/07/2014 #87
          if rMANXLSetup.READPERMISSION then
          //>>MANXL7.00.001 WSA 11/07/2014 #87
            //<<MANXL7.00.001 DAT 03/03/2014 #10
            if "Source Type" <> "Source Type"::Item then
              "Revision No.":= '';
            //>>MANXL7.00.001 DAT 03/03/2014 #10
          */
        //end;


        //Unsupported feature: CodeModification on ""Source No."(Field 10).OnValidate". Please convert manually.

        //trigger "(Field 10)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
          IF "Source No." <> xRec."Source No." THEN
            CheckProdOrderStatus(FIELDCAPTION("Source No."));

          IF "Source No." = '' THEN
            EXIT;

          CASE "Source Type" OF
            "Source Type"::Item:
              BEGIN
                Item.GET("Source No.");
                Item.TESTFIELD(Blocked,FALSE);
                Description := Item.Description;
                "Description 2" := Item."Description 2";
                "Routing No." := Item."Routing No.";
                "Inventory Posting Group" := Item."Inventory Posting Group";
                "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
                "Unit Cost" := Item."Unit Cost";
                CreateDim(DATABASE::Item,"Source No.");
              end;
            "Source Type"::Family:
              BEGIN
                Family.GET("Source No.");
                Description := Family.Description;
                "Description 2" := Family."Description 2";
                "Routing No." := Family."Routing No.";
                "Inventory Posting Group" := '';
                "Gen. Prod. Posting Group" := '';
                "Unit Cost" := 0;
              end;
            "Source Type"::"Sales Header":
              BEGIN
                IF Status = Status::Simulated THEN
                  SalesHeader.GET(SalesHeader."Document Type"::Quote,"Source No.")
                else
                  SalesHeader.GET(SalesHeader."Document Type"::Order,"Source No.");
                Description := SalesHeader."Ship-to Name";
                "Description 2" := SalesHeader."Ship-to Name 2";
                "Routing No." := '';
                "Inventory Posting Group" := '';
                "Gen. Prod. Posting Group" := '';
                "Gen. Bus. Posting Group" := SalesHeader."Gen. Bus. Posting Group";
                "Unit Cost" := 0;
                "Location Code" := SalesHeader."Location Code";
                "Due Date" := SalesHeader."Shipment Date";
                "Ending Date" := SalesHeader."Shipment Date";
                "Dimension Set ID" := SalesHeader."Dimension Set ID";
                "Shortcut Dimension 1 Code" := SalesHeader."Shortcut Dimension 1 Code";
                "Shortcut Dimension 2 Code" := SalesHeader."Shortcut Dimension 2 Code";
              end;
          end;
          VALIDATE(Description);
          InitRecord;
          UpdateDatetime;
          */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
          if "Source No." <> xRec."Source No." then
            CheckProdOrderStatus(FIELDCAPTION("Source No."));

          if "Source No." = '' then
            exit;

          case "Source Type" of
            "Source Type"::Item:
              begin
                Item.GET("Source No.");
                Item.TESTFIELD(Blocked,false);
                // << DITW110.00.11 SFI 31/08/2017 BL#30569
                Item.BlockedSKU("Location Code",'',true);
                // >> DITW110.00.11 SFI BL#30569
                //HEI.12>>
                if (Status in [Status::Planned,Status::"Firm Planned",Status::Released]) and (CurrFieldNo <> 0) then begin
                  if ("Source No." <> xRec."Source No.") and ("Source No." <> '') then begin
                    ProdOrderLineL.SETCURRENTKEY(Status,"Prod. Order No.","Item No.");
                    ProdOrderLineL.SETRANGE(Status,Status);
                    ProdOrderLineL.SETRANGE("Prod. Order No.","No.");
                    ProdOrderLineL.SETRANGE("Item No.",xRec."Source No.");
                    if ProdOrderLineL.FINDFIRST then begin
                      if not CONFIRM(Text000L,false,ProdOrderLineL."Item No.","Source No.") then
                        ERROR('')
                      else
                        ProdOrderLineL.DELETE(true);
                    end;
                  end;
                end;
                //HEI.12<<
                Description := Item.Description;
                "Description 2" := Item."Description 2";
                //<< DITW110.00.12 AKH 21/03/2018 NRQ#64704
                "Unit of Measure Code" := Item."Production Unit of Measure";
                "Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");
                "Unit Volume HL" := Item."Unit Volume HL" * "Qty. per Unit of Measure";
                //>> DITW110.00.12 AKH NRQ#64704
          #14..17
                //<<MANXL7.00.001 WSA 11/07/2014 #87
                //<< DITW111.00.13 ISL 31/10/2018 NRQ#89922
                "Production BOM No.":=Item."Production BOM No.";
                //>> DITW111.00.13 ISL NRQ#89922
                if rMANXLSetup.READPERMISSION then begin
                //>>MANXL7.00.001 WSA 11/07/2014 #87
                  //<<MANXL7.00.001 DAT 03/03/2014 #10
                  "Planning Group":= Item."Planning Group";
                  "Production Group":= Item."Production Group";
                  "Item Category Code":= Item."Item Category Code";
                  "Item Product Group Code":= Item."Product Group Code";
                  //>>MANXL7.00.001 DAT 03/03/2014 #10
                //<<MANXL7.00.001 WSA 11/07/2014 #87
                end;
                //>>MANXL7.00.001 WSA 11/07/2014 #87
                CreateDim(DATABASE::Item,"Source No.",
                //<<DITW18.00.06 AKH 20/02/2015 DIT-770 #1197
                DATABASE::"Responsibility Center", "Responsibility Center"
                //>>DITW18.00.06 AKH 20/02/2015 DIT-770 #1197
                );
                // <<DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008 - DITW15.00.00.39 PRODW14.00.00.08.18 DDR 25/08/2011 #1372
                //MANXL "Item Category Code" := Item."Item Category Code";
                //MANXL "_Product Group Code" := Item."Product Group Code";
                // >>DITW15.00.00.39 PRODW14.00.00.08.18 DDR #1372
                //<<DITW18.00.06 MSF 02/03/2015 DIT-770 #1192
                // <<DITW15.00.00.30 DDR 09/01/2009
                if Item."Location Code" <> '' then
                  "Location Code" := Item."Location Code";
                // >>DITW15.00.00.30 DDR
                ItemLocationCode := UserSetupMgt.GetLocation(3,"Location Code","Responsibility Center");
                if ItemLocationCode <> '' then
                  "Location Code" := ItemLocationCode;

                if not UserSetupMgt.CheckLocation(3,"Location Code","Responsibility Center") then
                  ERROR(
                    Text2014414,
                    Location.TABLECAPTION,"Location Code",
                    RespCenter.TABLECAPTION,UserSetupMgt.GetProductionFilter);

                if "Location Code" <> xRec."Location Code" then
                  VALIDATE("Location Code");
                // >>DITW18.00.06 MSF DIT-770 #1192
                //<<DITW18.00.06 AKH 10/02/2015 DIT-770 #1184
                fctGetSKU;
                if rSKU."Routing No." <> '' then begin
                  "Routing No." := rSKU."Routing No.";
                  //<< DITW111.00.13 ISL 31/10/2018 NRQ#89922
                  "Production BOM No." := rSKU."Production BOM No.";
                  //<< DITW111.00.13 ISL 05/11/2018 NRQ#89922
                  VALIDATE("Routing Version Code",VersionMgt.GetRtngVersion("Routing No.","Due Date",true));
                  VALIDATE("Production BOM Version Code",VersionMgt.GetBOMVersion("Production BOM No.","Due Date",true));
                end else begin
                  "Routing No." := Item."Routing No.";
                  "Production BOM No." := Item."Production BOM No.";
                  VALIDATE("Routing Version Code",VersionMgt.GetRtngVersion("Routing No.","Due Date",true));
                  VALIDATE("Production BOM Version Code",VersionMgt.GetBOMVersion("Production BOM No.","Due Date",true));
                end;
                  //>> DITW111.00.13 ISL NRQ#89922
                  //>> DITW111.00.13 ISL NRQ#89922
                //>>DITW18.00.06 AKH 10/02/2015 DIT-770 #1184
              end;
            "Source Type"::Family:
              begin
          #22..28
                //<<MANXL7.00.001 WSA 11/07/2014 #87
                if rMANXLSetup.READPERMISSION then begin
                //>>MANXL7.00.001 WSA 11/07/2014 #87
                  //<<MANXL7.00.001 DAT 03/03/2014 #10
                  "Planning Group":='';
                  "Production Group":='';
                  "Item Category Code":='';
                  "Item Product Group Code":='';
                  //>>MANXL7.00.001 DAT 03/03/2014 #10
                //<<MANXL7.00.001 WSA 11/07/2014 #87
                end;
                //>>MANXL7.00.001 WSA 11/07/2014 #87

              end;
            "Source Type"::"Sales Header":
              begin
                if Status = Status::Simulated then
                  SalesHeader.GET(SalesHeader."Document Type"::Quote,"Source No.")
                else
          #35..43
                //<<DITW18.00.06 MSF 02/03/2015 DIT-770 #1192
                "Responsibility Center" := SalesHeader."Responsibility Center";
                "Physical Location Group Code" :=  SalesHeader."Physical Location Group Code";
                //>>DITW18.00.06 MSF 02/03/2015 DIT-770 #1192
          #44..48
                //<<MANXL7.00.001 WSA 11/07/2014 #87
                if rMANXLSetup.READPERMISSION then begin
                //>>MANXL7.00.001 WSA 11/07/2014 #87
                  //<<MANXL7.00.001 DAT 03/03/2014 #10
                  "Planning Group":='';
                  "Production Group":='';
                  "Item Category Code":='';
                  "Item Product Group Code":='';
                  //>>MANXL7.00.001 DAT 03/03/2014 #10
                //<<MANXL7.00.001 WSA 11/07/2014 #87
                end;
                //>>MANXL7.00.001 WSA 11/07/2014 #87

              end;
          end;
          #51..53
          */
        //end;


        //Unsupported feature: CodeInsertion on ""Routing No."(Field 11)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        // var
        // CapLedgEntry: Record "Capacity Ledger Entry"; //BC Upgrade PATHAA2
        //begin
        /*
          // <<DITW110.00.12A HBA 22/06/2018 NRQ#68221
          if "Routing No." <> xRec."Routing No." then begin
            //<< DITW111.00.13 MZOU 07/11/2018 NRQ#91446
            if Status = Status::Released then begin
              if CheckCapLedgEntry then
                ERROR(
                  Text2035240,
                  FIELDCAPTION("Routing No."),xRec."Routing No.",CapLedgEntry.TABLECAPTION);
            end;
            //>> DITW111.00.13 MZOU NRQ#91446
            VALIDATE("Routing Version Code",VersionMgt.GetRtngVersion("Routing No.","Due Date",true));
            CALCFIELDS("Routing Version Description");
            end;
          // >>DITW110.00.12A HBA NRQ#68221
          */
        //end;


        //Unsupported feature: CodeModification on ""Starting Time"(Field 20).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
          ProdOrderLine.SETCURRENTKEY(Status,"Prod. Order No.","Planning Level Code");
          ProdOrderLine.ASCendING(FALSE);
          ProdOrderLine.SETRANGE(Status,Status);
          ProdOrderLine.SETRANGE("Prod. Order No.","No.");
          ProdOrderLine.SETFILTER("Item No.",'<>%1','');
          ProdOrderLine.SETFILTER("Planning Level Code",'>%1',0);
          IF ProdOrderLine.FIND('-') THEN BEGIN
            "Starting Date-Time" := CREATEDATETIME("Starting Date","Starting Time");
            MODIFY;
            MultiLevelMessage;
            EXIT;
          end;
          "Due Date" := 0D;
          ProdOrderLine.SETRANGE("Planning Level Code");
          IF ProdOrderLine.FIND('-') THEN
            REPEAT
              ProdOrderLine."Starting Time" := "Starting Time";
              ProdOrderLine."Starting Date" := "Starting Date";
              ProdOrderLine.MODIFY;
              CalcProdOrder.SetParameter(TRUE);
              CalcProdOrder.Recalculate(ProdOrderLine,0,TRUE);
              IF ProdOrderLine."Planning Level Code" > 0 THEN
                ProdOrderLine."Due Date" := ProdOrderLine."Ending Date"
              else
                ProdOrderLine."Due Date" :=
                  LeadTimeMgt.PlannedDueDate(
                    ProdOrderLine."Item No.",
                    ProdOrderLine."Location Code",
                    ProdOrderLine."Variant Code",
                    ProdOrderLine."Ending Date",
                    '',
                    2);

              IF "Due Date" = 0D THEN
                "Due Date" := ProdOrderLine."Due Date";
              "Starting Date-Time" := CREATEDATETIME("Starting Date","Starting Time");
              ProdOrderLine.MODIFY(TRUE);
              ProdOrderLine.CheckEndingDate(CurrFieldNo <> 0);
            UNTIL ProdOrderLine.NEXT = 0
          else BEGIN
            "Ending Date" := "Starting Date";
            "Ending Time" := "Starting Time";
          end;
          AdjustStartEndingDate;
          MODIFY;
          */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
          ProdOrderLine.SETCURRENTKEY(Status,"Prod. Order No.","Planning Level Code");
          ProdOrderLine.ASCendING(false);
          #3..6
          if ProdOrderLine.FIND('-') then begin
          #8..10
            exit;
          end;
          "Due Date" := 0D;
          ProdOrderLine.SETRANGE("Planning Level Code");
          if ProdOrderLine.FIND('-') then
            repeat
          #17..19
              CalcProdOrder.SetParameter(true);
              CalcProdOrder.Recalculate(ProdOrderLine,0,true);
              if ProdOrderLine."Planning Level Code" > 0 then
                ProdOrderLine."Due Date" := ProdOrderLine."Ending Date"
              else
          #25..33
              if "Due Date" = 0D then
                "Due Date" := ProdOrderLine."Due Date";
              "Starting Date-Time" := CREATEDATETIME("Starting Date","Starting Time");
              ProdOrderLine.MODIFY(true);
              ProdOrderLine.CheckEndingDate(CurrFieldNo <> 0);
            until ProdOrderLine.NEXT = 0
          else begin
            "Ending Date" := "Starting Date";
            "Ending Time" := "Starting Time";
          end;
          AdjustStartEndingDate;
          MODIFY;
          */
        //end;


        //Unsupported feature: CodeModification on ""Ending Time"(Field 22).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
          ProdOrderLine.SETCURRENTKEY(Status,"Prod. Order No.","Planning Level Code");
          ProdOrderLine.ASCendING(TRUE);
          ProdOrderLine.SETRANGE(Status,Status);
          ProdOrderLine.SETRANGE("Prod. Order No.","No.");
          ProdOrderLine.SETFILTER("Item No.",'<>%1','');
          ProdOrderLine.SETFILTER("Planning Level Code",'>%1',0);
          IF ProdOrderLine.FIND('-') THEN BEGIN
            "Ending Date-Time" := CREATEDATETIME("Ending Date","Ending Time");
            MODIFY;
            MultiLevelMessage;
            EXIT;
          end;
          "Due Date" := 0D;
          ProdOrderLine.SETRANGE("Planning Level Code");
          IF ProdOrderLine.FIND('-') THEN
            REPEAT
              ProdOrderLine."Ending Time" := "Ending Time";
              ProdOrderLine."Ending Date" := "Ending Date";
              ProdOrderLine.MODIFY;
              CalcProdOrder.SetParameter(TRUE);
              CalcProdOrder.Recalculate(ProdOrderLine,1,TRUE);
              IF ProdOrderLine."Planning Level Code" > 0 THEN
                ProdOrderLine."Due Date" := ProdOrderLine."Ending Date"
              else
                ProdOrderLine."Due Date" :=
                  LeadTimeMgt.PlannedDueDate(
                    ProdOrderLine."Item No.",
                    ProdOrderLine."Location Code",
                    ProdOrderLine."Variant Code",
                    ProdOrderLine."Ending Date",
                    '',
                    2);
              IF "Due Date" = 0D THEN
                "Due Date" := ProdOrderLine."Due Date";
              "Ending Date-Time" := CREATEDATETIME("Ending Date","Ending Time");
              ProdOrderLine.MODIFY(TRUE);
              ProdOrderLine.CheckEndingDate(CurrFieldNo <> 0);
            UNTIL ProdOrderLine.NEXT = 0
          else BEGIN
            "Starting Date" := "Ending Date";
            "Starting Time" := "Ending Time";
          end;
          AdjustStartEndingDate;
          MODIFY;
          */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
          ProdOrderLine.SETCURRENTKEY(Status,"Prod. Order No.","Planning Level Code");
          ProdOrderLine.ASCendING(true);
          #3..6
          if ProdOrderLine.FIND('-') then begin
          #8..10
            exit;
          end;
          "Due Date" := 0D;
          ProdOrderLine.SETRANGE("Planning Level Code");
          if ProdOrderLine.FIND('-') then
            repeat
          #17..19
              CalcProdOrder.SetParameter(true);
              CalcProdOrder.Recalculate(ProdOrderLine,1,true);
              if ProdOrderLine."Planning Level Code" > 0 then
                ProdOrderLine."Due Date" := ProdOrderLine."Ending Date"
              else
          #25..32
              if "Due Date" = 0D then
                "Due Date" := ProdOrderLine."Due Date";
              "Ending Date-Time" := CREATEDATETIME("Ending Date","Ending Time");
              ProdOrderLine.MODIFY(true);
              ProdOrderLine.CheckEndingDate(CurrFieldNo <> 0);
            until ProdOrderLine.NEXT = 0
          else begin
            "Starting Date" := "Ending Date";
            "Starting Time" := "Ending Time";
          end;
          AdjustStartEndingDate;
          MODIFY;
          */
        //end;


        //Unsupported feature: CodeModification on ""Due Date"(Field 24).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
          IF "Due Date" = 0D THEN
            EXIT;
          IF (CurrFieldNo = FIELDNO("Due Date")) OR
             (CurrFieldNo = FIELDNO("Location Code")) OR
             UpdateEndDate
          THEN BEGIN
            ProdOrderLine.SETCURRENTKEY(Status,"Prod. Order No.","Planning Level Code");
            ProdOrderLine.ASCendING(TRUE);
            ProdOrderLine.SETRANGE(Status,Status);
            ProdOrderLine.SETRANGE("Prod. Order No.","No.");
            ProdOrderLine.SETFILTER("Item No.",'<>%1','');
            ProdOrderLine.SETFILTER("Planning Level Code",'>%1',0);
            IF NOT ProdOrderLine.ISEMPTY THEN BEGIN
              ProdOrderLine.SETRANGE("Planning Level Code",0);
              IF "Source Type" = "Source Type"::Family THEN BEGIN
                UpdateEndingDate(ProdOrderLine);
              end else BEGIN
                IF ProdOrderLine.FIND('-') THEN
                  "Ending Date" :=
                    LeadTimeMgt.PlannedEndingDate(ProdOrderLine."Item No.","Location Code",'',"Due Date",'',2)
                else
                  "Ending Date" := "Due Date";
                "Ending Date-Time" := CREATEDATETIME("Ending Date","Ending Time");
                MultiLevelMessage;
                EXIT;
              end;
            end else BEGIN
              ProdOrderLine.SETRANGE("Planning Level Code");
              IF NOT ProdOrderLine.ISEMPTY THEN
                UpdateEndingDate(ProdOrderLine)
              else BEGIN
                IF "Source Type" = "Source Type"::Item THEN
                  "Ending Date" :=
                    LeadTimeMgt.PlannedEndingDate(
                      "Source No.",
                      "Location Code",
                      '',
                      "Due Date",
                      '',
                      2)
                else
                  "Ending Date" := "Due Date";
                "Starting Date" := "Ending Date";
                "Starting Date-Time" := CREATEDATETIME("Starting Date","Starting Time");
                "Ending Date-Time" := CREATEDATETIME("Ending Date","Ending Time");
              end;
              AdjustStartEndingDate;
              MODIFY;
            end;
          end;
          */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
          if "Due Date" = 0D then
            exit;
          if (CurrFieldNo = FIELDNO("Due Date")) or
             (CurrFieldNo = FIELDNO("Location Code")) or
             UpdateEndDate
          then begin
            ProdOrderLine.SETCURRENTKEY(Status,"Prod. Order No.","Planning Level Code");
            ProdOrderLine.ASCendING(true);
          #9..12
            if not ProdOrderLine.ISEMPTY then begin
              ProdOrderLine.SETRANGE("Planning Level Code",0);
              if "Source Type" = "Source Type"::Family then begin
                UpdateEndingDate(ProdOrderLine);
              end else begin
                if ProdOrderLine.FIND('-') then
                  "Ending Date" :=
                    LeadTimeMgt.PlannedEndingDate(ProdOrderLine."Item No.","Location Code",'',"Due Date",'',2)
                else
          #22..24
                exit;
              end;
            end else begin
              ProdOrderLine.SETRANGE("Planning Level Code");
              if not ProdOrderLine.ISEMPTY then
                UpdateEndingDate(ProdOrderLine)
              else begin
                if "Source Type" = "Source Type"::Item then
          #33..40
                else
          #42..45
              end;
              AdjustStartEndingDate;
              MODIFY;
            end;
          end;
          */
        //end;


        //Unsupported feature: CodeInsertion on ""Location Code"(Field 32).OnValidate". Please convert manually.

        //trigger (Variable: Item)();
        //Parameters and return type have not been exported.
        //begin
        /*
          */
        //end;


        //Unsupported feature: CodeModification on ""Location Code"(Field 32).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
          GetDefaultBin;

          VALIDATE("Due Date"); // Scheduling consider Calendar assigned to Location
          */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
          //HEI.01 PRDGAP024>>
          "Zone Code" := '';
          "Bin Code" := '';
          //HEI.01 PRDGAP024<<
          #1..3
          // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
          if ("Responsibility Center" = xRec."Responsibility Center") and ("Location Code" <> xRec."Location Code") and
            ("Location Code" <> '')
          then begin
            Location.GET("Location Code");
            VALIDATE("Responsibility Center",UserSetupMgt.GetFirstRespCenter(3,Location."Physical Location Group Code","Location Code"));
          end;
          if (("Responsibility Center" = xRec."Responsibility Center") and ("Location Code" <> '')) or
            ("Responsibility Center" <> xRec."Responsibility Center")
          then
            if not UserSetupMgt.CheckLocation(3,"Location Code","Responsibility Center") then
              ERROR(
                Text2014412,
                Location.TABLECAPTION,"Location Code",
                RespCenter.TABLECAPTION,UserSetupMgt.GetProductionFilter);

          if "Location Code" <> '' then begin
            Location.GET("Location Code");
            if Location."Physical Location Group Code" <> "Physical Location Group Code" then
              "Physical Location Group Code" := Location."Physical Location Group Code";
          end else
            if xRec."Physical Location Group Code" = "Physical Location Group Code" then
              "Physical Location Group Code" := '';
          if xRec."Physical Location Group Code" = "Physical Location Group Code" then
            VALIDATE("Physical Location Group Code");
          // >>DITW18.00.06 MSF DIT-770 #1192

          // << DITW110.00.11 SFI 31/08/2017 BL#30569
          if ("Source Type" = "Source Type"::Item) then begin
            Item.GET("Source No.");
            Item.BlockedSKU("Location Code",'',true);
          end;
          // >> DITW110.00.11 SFI BL#30569

          //<<DITW18.00.06 AKH 10/02/2015 DIT-770 #1184
          if ("Source Type" = "Source Type"::Item) then begin
            fctGetSKU;
            if rSKU."Routing No." <> '' then begin
              "Routing No." := rSKU."Routing No.";
              //<< DITW110.00.12A HBA 18/06/2018 -22/06/2018 NRQ#68221
              "Production BOM No." := rSKU."Production BOM No.";
              "Routing No." := rSKU."Routing No.";
              VALIDATE("Routing Version Code",VersionMgt.GetRtngVersion("Routing No.","Due Date",true));
              VALIDATE("Production BOM Version Code",VersionMgt.GetBOMVersion("Production BOM No.","Due Date",true));

            end else begin

              "Routing No." := Item."Routing No.";
              "Production BOM No." := Item."Production BOM No.";
              VALIDATE("Routing Version Code",VersionMgt.GetRtngVersion("Routing No.","Due Date",true));
              VALIDATE("Production BOM Version Code",VersionMgt.GetBOMVersion("Production BOM No.","Due Date",true));
            end;
            //<< DITW110.00.12A HBA NRQ#68221
          end;
          //>>DITW18.00.06 AKH 10/02/2015 DIT-770 #1184
          */
        //end;


        //Unsupported feature: CodeModification on ""Bin Code"(Field 33).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
          IF "Bin Code" <> '' THEN
            WhseIntegrationMgt.CheckBinTypeCode(DATABASE::"Production Order",
              FIELDCAPTION("Bin Code"),
              "Location Code",
              "Bin Code",0);
          */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
          if "Bin Code" <> '' then
          #2..5
          //HEI.01 PRDGAP024>>
          //"Zone Code" := '';
          if ("Bin Code" <> '') and ("Zone Code" <> '') then begin
            if Bin.GET("Location Code","Bin Code") then
              //HEI.03 PRDGAP024>>
              //VALIDATE("Zone Code",Bin."Location Code");
              VALIDATE("Zone Code",Bin."Zone Code");
              //HEI.03 PRDGAP024<<
          end;
          //HEI.01 PRDGAP024<<

          //HEI.11>>
          if CurrFieldNo <> 0 then begin
            InventorySetupL.GET;
            if (InventorySetupL."CMG Code for Empty Bin" <> '') and ("Source Type" = "Source Type"::Item) then begin
              if ("Bin Code" <> '') and BinL.GET("Location Code","Bin Code") and (not BinL.Empty) then begin
                DefaultDimensionL.SETCURRENTKEY("Table ID","No.","Dimension Code","Dimension Value Code");
                DefaultDimensionL.SETRANGE("Table ID",DATABASE::Item);
                DefaultDimensionL.SETRANGE("No.","Source No.");
                DefaultDimensionL.SETRANGE("Dimension Code",'CMG');
                DefaultDimensionL.SETFILTER("Dimension Value Code",InventorySetupL."CMG Code for Empty Bin");
                if DefaultDimensionL.FINDFIRST then begin
                  if not CONFIRM(Text000L,false,"Bin Code") then
                    ERROR('');
                end;
              end;
            end;
          end;
          //HEI.11<<
          */
        //end;


        //Unsupported feature: CodeModification on "Quantity(Field 40).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
          IF "Source Type" = "Source Type"::Item THEN
            "Cost Amount" := ROUND(Quantity * "Unit Cost")
          else
            "Cost Amount" := 0;
          */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
          //<< DITW110.00.12 AKH 21/03/2018 NRQ#64704
          "Quantity (Base)" := ROUND(Quantity * "Qty. per Unit of Measure", 0.00001);
          "Quantity HL" := ROUND(Quantity* "Unit Volume HL", GLSetup."Unit-Amount Rounding Precision");
          //>> DITW110.00.12 AKH NRQ#64704
          if "Source Type" = "Source Type"::Item then
            "Cost Amount" := ROUND(Quantity * "Unit Cost")
          else
            "Cost Amount" := 0;
   
        */
        //end;
        field(50000; "Zone Code FND"; Code[10])
        {
            Description = 'HEI.01 PRDGAP024';
            Caption = 'Zone Code';
            TableRelation = Zone.Code where("Location Code" = FIELD("Location Code"),
                                             "Use As In-Transit FND" = FILTER(false));

            trigger OnValidate();
            begin
                //HEI.03 PRDGAP024>>
                //HEI.01 PRDGAP024>>
                /*
                IF "Zone Code" <> '' THEN
                  WHSUTILS.CheckUserAuthorizedinZone("Location Code","Zone Code");
                  VALIDATE("Bin Code",'');
   
                */
                //HEI.01 PRDGAP024<<

                if Rec."Zone Code FND" <> xRec."Zone Code FND" then begin
                    WHSUTILS.CheckUserAuthorizedinZone("Location Code", "Zone Code FND");
                    VALIDATE("Bin Code", '');
                end;
                //HEI.03 PRDGAP024<<

            end;
        }
        field(50001; "Created By FND"; Code[50])
        {
            Description = 'HEI.08';
            Caption = 'Created By';
            Editable = false;
            TableRelation = "User Setup";
        }
        field(50002; "Role Centre Tile Code FND"; Text[30])
        {
            Caption = 'Role Centre Tile Code';
            Description = 'HEI.09';
        }

        // BC Upgrade SHUKLP03 >> Added in the interface extension
        // field(50003; "Prod. Order Interface"; Code[20])
        // {
        //     Caption = 'Prod. Order Interface';
        //     Description = 'HEI.13';
        //     //TableRelation = "Interface Setup";  // BC Upgrade NANDIS03 - Blocked as "Interface Setup" table moved in Interface Extension 
        // }
        // field(50004; "Prod. Order Output Interface"; Code[20])
        // {
        //     Caption = 'Prod. Order Output Interface';
        //     Description = 'HEI.13';
        //     //TableRelation = "Interface Setup";  // BC Upgrade NANDIS03 - Blocked as "Interface Setup" table moved in Interface Extension 
        // }
        // field(50005; "Parked for LogoPak"; Boolean)
        // {
        //     Caption = 'Parked for LogoPak';
        //     Description = 'HEI.13';
        // }
        // field(50006; "Parked from LogoPak"; Boolean)
        // {
        //     Caption = 'Parked from LogoPak';
        //     Description = 'HEI.13';
        // }
        // field(50007; "Posted from LogoPak"; Boolean)
        // {
        //     Caption = 'Posted from LogoPak';
        //     Description = 'HEI.13';
        // }
        // BC Upgrade SHUKLP03 << Added in the interface extension

        //BC Upgrade PATHAA02>>
        // field(50020; "Prod. ORDER Interface Astro"; Code[20])
        // {
        //     Caption = 'Prod. ORDER Interface Astro';
        //     Description = 'HEI.14';
        //     TableRelation = "Interface Setup";
        // }
        // field(50021; "Parked ORDER Astro"; Boolean)
        // {
        //     Caption = 'Parked ORDER Astro';
        //     Description = 'HEI.14';
        // }
        // field(50022; "Last Parked Date ORDER Astro"; Date)
        // {
        //     Caption = 'Last Parked Date ORDER Astro';
        //     Description = 'HEI.14';
        // }
        // field(50023; "Last Parked Time ORDER Astro"; Time)
        // {
        //     Caption = 'Last Parked Time ORDER Astro';
        //     Description = 'HEI.14';
        // }
        // field(50025; "Prod. LINEPICK Interface Astro"; Code[20])
        // {
        //     Caption = 'Prod. LINEPICK Interface Astro';
        //     Description = 'HEI.17';
        //     TableRelation = "Interface Setup";
        // }
        // field(50026; "Parked LINEPICK Astro"; Boolean)
        // {
        //     Caption = 'Parked LINEPICK Astro';
        //     Description = 'HEI.17';
        // }
        // field(50027; "Last Parked Date LINEPICKAstro"; Date)
        // {
        //     Caption = 'Last Parked Date LINEPICK Astro';
        //     Description = 'HEI.17';
        // }
        // field(50028; "Last Parked Time LINEPICKAstro"; Time)
        // {
        //     Caption = 'Last Parked Time LINEPICK Astro';
        //     Description = 'HEI.17';
        // }
        // field(50029; "Posted LINEPICK Astro"; Boolean)
        // {
        //     Caption = 'Posted LINEPICK Astro';
        //     Description = 'HEI.17';
        // }
        // field(50030; "Prod. OUTPUT Interface Astro"; Code[20])
        // {
        //     Caption = 'Prod. OUTPUT Interface Astro';
        //     Description = 'HEI.16';
        //     TableRelation = "Interface Setup";
        // }
        // field(50031; "Parked OUTPUT Astro"; Boolean)
        // {
        //     Caption = 'Parked OUTPUT Astro';
        //     Description = 'HEI.16';
        // }
        // field(50032; "Last Parked Date OUTPUT Astro"; Date)
        // {
        //     Caption = 'Last Parked Date OUTPUT Astro';
        //     Description = 'HEI.16';
        // }
        // field(50033; "Last Parked Time OUTPUT Astro"; Time)
        // {
        //     Caption = 'Last Parked Time OUTPUT Astro';
        //     Description = 'HEI.16';
        // }
        // field(50034; "Posted OUTPUT Astro"; Boolean)
        // {
        //     Caption = 'Posted OUTPUT Astro';
        //     Description = 'HEI.16';
        // }
        // field(50035; "OUTPUT Revers Interface Astro"; Code[20])
        // {
        //     Caption = 'OUTPUT Reversal Interface Astro';
        //     Description = 'HEI.18';
        //     TableRelation = "Interface Setup";
        // }
        // field(50036; "Parked OUTPUT Revers Astro"; Boolean)
        // {
        //     Caption = 'Parked OUTPUT Reversal Astro';
        //     Description = 'HEI.18';
        // }
        // field(50037; "Last Parked Date OUTPUTR Astro"; Date)
        // {
        //     Caption = 'Last Parked Date OUTPUT Reversal Astro';
        //     Description = 'HEI.18';
        // }
        // field(50038; "Last Parked Time OUTPUTR Astro"; Time)
        // {
        //     Caption = 'Last Parked Time OUTPUT Reversal Astro';
        //     Description = 'HEI.18';
        // }
        // field(50039; "Posted OUTPUT Revers Astro"; Boolean)
        // {
        //     Caption = 'Posted OUTPUT Reversal Astro';
        //     Description = 'HEI.18';
        // }
        // field(50040; "Prod. CLOSE Interface Astro"; Code[20])
        // {
        //     Caption = 'Prod. CLOSE Interface Astro';
        //     Description = 'HEI.15';
        //     TableRelation = "Interface Setup";
        // }
        // field(50041; "Last Parked Date CLOSE Astro"; Date)
        // {
        //     Caption = 'Last Parked Date CLOSE Astro';
        //     Description = 'HEI.15';
        // }
        // field(50042; "Last Parked Time CLOSE Astro"; Time)
        // {
        //     Caption = 'Last Parked Time CLOSE Astro';
        //     Description = 'HEI.15';
        // }
        // //BC Upgrade PATHAA02<<


        //BC Upgrade PATHAA02>>
        // field(2013718; "Vol-Strength Spec. Code"; Code[20])
        // {
        //     CalcFormula = Lookup(Item."Vol-Strength Spec. Code" where("No." = FIELD("Source No.")));
        //     CaptionClass = GetTaxSpecCaption(0, FIELDNO("Vol-Strength Spec. Code"));
        //     CaptionML = ENU = 'Volume Strength Spec. Code',
        //                 FRA = 'Code spécification contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     TableRelation = "Tax Specification" where(Type = CONST(Specification));
        // }
        // field(2013719; "Balance Vol-Strength Value"; Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Balance Vol-Strength Value"));
        //     AutoFormatType = 2013664;
        //     CalcFormula = Sum("Item Ledger Entry"."Vol-Strength Spec. Value" where("Order Type" = CONST(Production),
        //                                                                             "Order No." = FIELD("No.")));
        //     CaptionClass = GetTaxSpecCaptionText(FIELDNO("Balance Vol-Strength Value"));
        //     CaptionML = ENU = 'Balance Volume Strength Value',
        //                 FRA = 'Balance valeur contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013720; "Consumption Vol-Strength Value"; Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Consumption Vol-Strength Value"));
        //     AutoFormatType = 2013664;
        //     CalcFormula = Sum("Item Ledger Entry"."Vol-Strength Spec. Value" where("Order Type" = CONST(Production),
        //                                                                             "Order No." = FIELD("No."),
        //                                                                             "Entry Type" = CONST(Consumption)));
        //     CaptionClass = GetTaxSpecCaptionText(FIELDNO("Consumption Vol-Strength Value"));
        //     CaptionML = ENU = 'Consumption Volume Strength Value',
        //                 FRA = 'Valeur contrainte volume consommation';
        //     Description = 'DITW19.00.08 BL#10443';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013721; "Output Vol-Strength Value"; Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Output Vol-Strength Value"));
        //     AutoFormatType = 2013664;
        //     CalcFormula = Sum("Item Ledger Entry"."Vol-Strength Spec. Value" where("Order Type" = CONST(Production),
        //                                                                             "Order No." = FIELD("No."),
        //                                                                             "Entry Type" = CONST(Output)));
        //     CaptionClass = GetTaxSpecCaptionText(FIELDNO("Output Vol-Strength Value"));
        //     CaptionML = ENU = 'Output Volume Strength Value',
        //                 FRA = 'Valeur contrainte volume production';
        //     Description = 'DITW19.00.08 BL#10443';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013722; "Loss Vol-Strength Value"; Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Loss Vol-Strength Value"));
        //     AutoFormatType = 2013664;
        //     CalcFormula = Sum("Loss Breakdown Entry"."Vol-Strength Spec. Value" where("Order Type" = CONST(Production),
        //                                                                                "Order No." = FIELD("No."),
        //                                                                                "Capacity Ledger Entry No." = CONST(0)));
        //     CaptionClass = GetTaxSpecCaptionText(FIELDNO("Loss Vol-Strength Value"));
        //     CaptionML = ENU = 'Loss Volume Strength Value',
        //                 FRA = 'Valeur contrainte volume perte';
        //     Description = 'DITW19.00.08 BL#10443';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013723; "Exist Loss Strength Journal"; Boolean)
        // {
        //     CalcFormula = Exist("Loss Breakdown Journal" where("Journal Template Name" = CONST(''),
        //                                                         "Journal Batch Name" = CONST(''),
        //                                                         "Order No." = FIELD("No.")));
        //     CaptionML = ENU = 'Exist Loss Strength',
        //                 FRA = 'Journal perte contrainte existe';
        //     Description = 'DITW19.00.08 BL#10443';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014410; "Responsibility Center"; Code[10])
        // {
        //     CaptionML = ENU = 'Responsibility Center',
        //                 FRA = 'Centre de gestion';
        //     Description = 'DITW18.00.06 MSF 26/02/2015 DIT-770 #1192';
        //     TableRelation = "Responsibility Center" where(Code = FIELD("Resp. Center Table Filter"));

        //     trigger OnValidate();
        //     var
        //         LocationCode: Code[20];
        //     begin
        //         // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
        //         if not UserSetupMgt.CheckRespCenter(3, "Responsibility Center") then
        //             ERROR(
        //               Text2014410,
        //               RespCenter.TABLECAPTION, UserSetupMgt.GetProductionFilter);

        //         if (CurrFieldNo <> FIELDNO("Location Code")) and
        //           (CurrFieldNo <> FIELDNO("Physical Location Group Code")) and
        //           (xRec."Physical Location Group Code" = "Physical Location Group Code") and
        //           (xRec."Location Code" = "Location Code")
        //         then begin
        //             SETRANGE("Phys. Location Table Filter");
        //             SETRANGE("Location Table Filter");
        //             VALIDATE("Physical Location Group Code", UserSetupMgt.GetphysicalLocation(3, '', "Responsibility Center"));
        //             LocationCode := UserSetupMgt.GetLocation(3, '', "Responsibility Center");
        //             if (LocationCode <> '') or ("Physical Location Group Code" = '') then
        //                 VALIDATE("Location Code", LocationCode);
        //         end;
        //         // >>DITW18.00.06 MSF DIT-770 #1192
        //         //<<DITW18.00.06 AKH 20/02/2015 DIT-770 #1197
        //         CreateDim(
        //           DATABASE::"Responsibility Center", "Responsibility Center",
        //           DATABASE::Item, "Source No.");
        //         //>>DITW18.00.06 AKH 20/02/2015 DIT-770 #1197
        //     end;
        // }
        // field(2014411; "Physical Location Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Physical Location Group Code',
        //                 FRA = 'Code groupe magasin réel';
        //     Description = 'DITW18.00.06 MSF 26/02/2015 DIT-770 #1192';
        //     TableRelation = "Physical Location Group" where(Code = FIELD("Phys. Location Table Filter"));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
        //         if ("Responsibility Center" = xRec."Responsibility Center") and
        //           ("Physical Location Group Code" <> xRec."Physical Location Group Code") and
        //           ("Physical Location Group Code" <> '')
        //         then
        //             VALIDATE("Responsibility Center", UserSetupMgt.GetFirstRespCenter(3, "Physical Location Group Code", ''));

        //         if not UserSetupMgt.CheckPhysLocation(3, "Physical Location Group Code", "Responsibility Center") then
        //             ERROR(
        //               Text2014412,
        //               PhysLocationGr.TABLECAPTION, "Physical Location Group Code",
        //               RespCenter.TABLECAPTION, UserSetupMgt.GetProductionFilter);

        //         if (xRec."Physical Location Group Code" <> "Physical Location Group Code") then begin
        //             CLEAR(Location);
        //             if "Location Code" <> '' then
        //                 Location.GET("Location Code");
        //             if (Location."Physical Location Group Code" <> "Physical Location Group Code") then begin
        //                 if ((CurrFieldNo <> FIELDNO("Location Code")) and (xRec."Responsibility Center" = "Responsibility Center")) then
        //                     VALIDATE("Location Code", '')
        //                 else
        //                     "Location Code" := '';
        //             end;
        //         end;
        //         // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
        //     end;
        // }
        // field(2014412; "Resp. Center Table Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Resp. Center Table Filter',
        //                 FRA = 'Filtre Centre de gestion (table)';
        //     Description = 'DITW18.00.06 MSF 26/02/2015 DIT-770 #1192';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Responsibility Center";
        // }
        // field(2014413; "Phys. Location Table Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Phys. Location Table Filter',
        //                 FRA = 'Filtre groupe magasin réel (table)';
        //     Description = 'DITW18.00.06 MSF 26/02/2015 DIT-770 #1192';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Physical Location Group";
        // }
        // field(2014414; "Location Table Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Location Table Filter',
        //                 FRA = 'Filtre Magasin (table)';
        //     Description = 'DITW18.00.06 MSF 26/02/2015 DIT-770 #1192';
        //     FieldClass = FlowFilter;
        //     TableRelation = Location;
        // }


        //BC Upgrade Kamnay01 >> Added Unit of Measure Code and Qty. per Unit of Measure DITW fields 
        field(50008; "Unit of Measure Code FND"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            Description = 'DITW110.00.12 NRQ#64704';
            TableRelation = IF ("Source Type" = CONST(Item)) "Item Unit of Measure".Code where("Item No." = FIELD("Source No."))
            else
            "Unit of Measure";

            trigger OnValidate();
            var
                Item: Record Item;
            begin
                //<< DITW110.00.12 AKH 21/03/2018 NRQ#64704
                if ("Unit of Measure Code FND" <> xRec."Unit of Measure Code FND") and ("Source Type" = "Source Type"::Item) then begin
                    Item.GET("Source No.");
                    "Qty. per Unit of Measure FND" := UOMMgt.GetQtyPerUnitOfMeasure(Item, "Unit of Measure Code FND");
                end;
                //>> DITW110.00.12 AKH NRQ#64704
            end;
        }
        field(50009; "Qty. per Unit of Measure FND"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Description = 'DITW110.00.12 NRQ#64704';
            Editable = false;
            InitValue = 1;
        }
        //BC Upgrade Kamnay01 << Added Unit of Measure Code and Qty. per Unit of Measure DITW fields 
        //BC Upgrade GUNREM01 >> added DIT field
        field(50010; "Gyle No. FND"; Code[20])
        {
            CaptionML = ENU = 'Gyle No.',
                        FRA = 'Gyle N°';
            Description = 'DITW15.00.00.22 PRODW14.00.00.08';
            Width = 15;
        }
        //BC Upgrade GUNREM01 << added DIT  field

        // field(2014422; "Quantity (Base)"; Decimal)
        // {
        //     Caption = 'Quantity (Base)';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW110.00.12 NRQ#64704';
        //     Editable = false;
        // }
        // field(2014423; "Unit Volume HL"; Decimal)
        // {
        //     CaptionClass = GetUomCaptionClassHL(FIELDNO("Unit Volume HL"));
        //     Caption = 'Unit Volume';
        //     Description = 'DITW110.00.12 NRQ#64704';
        //     MinValue = 0;
        // }
        // field(2014424; "Quantity HL"; Decimal)
        // {
        //     CaptionClass = GetUomCaptionClassHL(FIELDNO("Quantity HL"));
        //     Caption = 'Quantity';
        //     Description = 'DITW110.00.12 NRQ#64704';
        //     Editable = false;
        // }
        // field(2029610; "Emergency Order"; Boolean)
        // {
        //     CaptionML = ENU = 'Emergency',
        //                 FRA = 'Urgence';
        //     Description = 'FINXL8.00.001';
        // }
        // field(2035090; "Certification Status"; Option)
        // {
        //     CaptionML = ENU = 'Certification Status',
        //                 FRA = 'Status certification';
        //     Description = 'QXL9.00';
        //     OptionCaptionML = ENU = 'Under Development,Awaiting Certification,Certified,Rejected',
        //                       FRA = 'En développement,Attente de certification,Certifié,Rejetée';
        //     OptionMembers = "Under Development","Awaiting Certification",Certified,Rejected;

        //     trigger OnValidate();
        //     begin
        //         //<<FINXL9.00.001 DAT 23/03/2016
        //         ChangeCertificationStatus;
        //         //>>FINXL9.00.001 DAT 23/03/2016
        //     end;
        // }
        // field(2035091; "Certified by"; Code[20])
        // {
        //     CaptionML = ENU = 'Certified by',
        //                 FRA = 'Certifié par';
        //     Description = 'QXL9.00';
        //     Editable = false;
        // }
        // field(2035092; "Operations Completed"; Boolean)
        // {
        //     CaptionML = ENU = 'Operations Completed',
        //                 FRA = 'Opérations effectuées';
        //     Description = 'QXL9.00';
        //     Editable = false;
        // }
        // field(2035093; "No. of Lot Tests"; Integer)
        // {
        //     CalcFormula = Count("Quality Test Header" where("Document Type" = CONST("Lot/SN Test"),
        //                                                      "Source ID" = FIELD("No."),
        //                                                      "Item No." = FIELD("Source No.")));
        //     CaptionML = ENU = 'No. of Lot Tests',
        //                 FRA = 'Nbre de Test lots';
        //     Description = 'QXL9.00';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035094; "No. of In Process Tests"; Integer)
        // {
        //     CalcFormula = Count("Quality Test Header" where("Document Type" = CONST("In Process Test"),
        //                                                      "Source ID" = FIELD("No.")));
        //     CaptionML = ENU = 'No. of In Process Tests',
        //                 FRA = 'Nbre de Lots en traitement';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035166; "_Product Group Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Product Group Code',
        //                 FRA = 'Code groupe produits';
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        //     Enabled = false;
        //     TableRelation = IF ("Source Type" = CONST(Item)) "Product Group".Code where("Item Category Code" = FIELD("Item Category Code"));
        // }
        // field(2035172; "Gyle No."; Code[20])
        // {
        //     CaptionML = ENU = 'Gyle No.',
        //                 FRA = 'Gyle N°';
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        //     Width = 15;
        // }
        // field(2035181; "Gyle No. Series"; Code[10])
        // {
        //     CaptionML = ENU = 'Gyle No. Series',
        //                 FRA = 'Souches de n° Gyle';
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        // }
        // field(2035183; "Parti-Gyle"; Boolean)
        // {
        //     CaptionML = ENU = 'Parti-Gyle',
        //                 FRA = 'Parti-Gyle';
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        //     Editable = false;
        // }
        // field(2035208; "_Item Category Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Category Code',
        //                 FRA = 'Code catégorie article';
        //     Description = 'DITW15.00.00.39 PRODW14.00.00.08.18 #1372';
        //     Enabled = false;
        //     TableRelation = IF ("Source Type" = CONST(Item)) "Item Category";

        //     trigger OnValidate();
        //     var
        //         ProductGrp: Record "Product Group";
        //     begin
        //         // <<DITW15.00.00.38 PRODW14.00.00.08.18 DDR 25/08/2011
        //         if "Item Category Code" <> xRec."Item Category Code" then begin
        //             if not ProductGrp.GET("Item Category Code", "_Product Group Code") then
        //                 VALIDATE("_Product Group Code", '')
        //             else
        //                 VALIDATE("_Product Group Code");
        //         end;
        //     end;
        // }
        // field(2035251; "Actual Quantity"; Decimal)
        // {
        //     CaptionML = ENU = 'Actual Quantity',
        //                 FRA = 'Quantité réel';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        //     Editable = false;
        // }
        // field(2035252; "Calculation Required"; Boolean)
        // {
        //     CaptionML = ENU = 'Calculation Required',
        //                 FRA = 'Calcul nécessaire';
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        //     Editable = false;
        // }
        // field(2035253; "Calculation Completed"; Boolean)
        // {
        //     CaptionML = ENU = 'Calculation Completed',
        //                 FRA = 'Calcul effectué';
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        // }
        // field(2035256; "Original Quantity"; Decimal)
        // {
        //     CaptionML = ENU = 'Original Quantity',
        //                 FRA = 'Quantité initiale';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        // }
        // field(2035270; "Routing Version Code"; Code[20])
        // {
        //     Caption = 'Routing Version Code';
        //     Description = 'DITW110.00.12A NRQ#68221';
        //     TableRelation = "Routing Version"."Version Code" where("Routing No." = FIELD("Routing No."));

        //     trigger OnValidate();
        //     var
        //         CapLedgEntry: Record "Capacity Ledger Entry";
        //     begin
        //         // <<DITW110.00.12A HBA 22/06/2018 NRQ#68221
        //         if "Routing Version Code" <> xRec."Routing Version Code" then begin
        //             //<< DITW111.00.13 MZOU 07/11/2018 NRQ#91446
        //             if Status = Status::Released then begin
        //                 if CheckCapLedgEntry then
        //                     ERROR(
        //                       Text2035240,
        //                       FIELDCAPTION("Routing Version Code"), xRec."Routing Version Code", CapLedgEntry.TABLECAPTION);
        //             end;
        //             //>> DITW111.00.13 MZOU NRQ#91446
        //             CALCFIELDS("Routing Version Description");
        //             //<< DITW111.00.13 MZOU 07/11/2018 NRQ#91446
        //         end;
        //         //<< DITW111.00.13 MZOU NRQ#91446
        //         // >>DITW110.00.12A HBA NRQ#68221
        //     end;
        // }
        // field(2035271; "Routing Version Description"; Text[50])
        // {
        //     CalcFormula = Lookup("Routing Version".Description where("Routing No." = FIELD("Routing No."),
        //                                                               "Version Code" = FIELD("Routing Version Code")));
        //     Caption = 'Routing Description';
        //     Description = 'DITW110.00.12A NRQ#68221';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035272; "Production BOM No."; Code[20])
        // {
        //     Caption = 'Production BOM No.';
        //     Description = 'DITW110.00.12A NRQ#68221';
        //     TableRelation = "Production BOM Header";

        //     trigger OnValidate();
        //     var
        //         ItemMinorRevision: Record "Item Minor Revision";
        //         CapLedgEntry: Record "Capacity Ledger Entry";
        //     begin
        //         // <<DITW110.00.12A HBA 22/06/2018 NRQ#68221
        //         if "Production BOM No." <> xRec."Production BOM No." then begin
        //             //<< DITW111.00.13 MZOU 07/11/2018 NRQ#91446
        //             if Status = Status::Released then begin
        //                 if CheckCapLedgEntry then
        //                     ERROR(
        //                       Text2035240,
        //                       FIELDCAPTION("Production BOM No."), xRec."Production BOM No.", CapLedgEntry.TABLECAPTION);
        //             end;
        //             //>> DITW111.00.13 MZOU NRQ#91446
        //             VALIDATE("Production BOM Version Code", VersionMgt.GetBOMVersion("Production BOM No.", "Due Date", true));
        //             CALCFIELDS("Production BOM Version Desc.");
        //         end;
        //         // >>DITW110.00.12A HBA NRQ#68221
        //     end;
        // }
        // field(2035273; "Production BOM Version Code"; Code[20])
        // {
        //     Caption = 'Production BOM Version Code';
        //     Description = 'DITW110.00.12A NRQ#68221';
        //     TableRelation = "Production BOM Version"."Version Code" where("Production BOM No." = FIELD("Production BOM No."));

        //     trigger OnValidate();
        //     var
        //         CapLedgEntry: Record "Capacity Ledger Entry";
        //     begin
        //         // <<DITW110.00.12A HBA 22/06/2018 NRQ#68221
        //         if "Production BOM Version Code" <> xRec."Production BOM Version Code" then begin
        //             //<< DITW111.00.13 MZOU 07/11/2018 NRQ#91446
        //             if Status = Status::Released then begin
        //                 if CheckCapLedgEntry then
        //                     ERROR(
        //                       Text2035240,
        //                       FIELDCAPTION("Production BOM Version Code"), xRec."Production BOM Version Code", CapLedgEntry.TABLECAPTION);
        //             end;
        //             //>> DITW111.00.13 MZOU NRQ#91446
        //             CALCFIELDS("Production BOM Version Desc.");
        //             //<< DITW111.00.13 MZOU 07/11/2018 NRQ#91446
        //         end;
        //         //>> DITW111.00.13 MZOU NRQ#91446
        //         // >>DITW110.00.12A HBA NRQ#68221
        //     end;
        // }
        // field(2035274; "Production BOM Version Desc."; Text[50])
        // {
        //     CalcFormula = Lookup("Production BOM Version".Description where("Production BOM No." = FIELD("Production BOM No."),
        //                                                                      "Version Code" = FIELD("Production BOM Version Code")));
        //     Caption = 'Production BOM Description';
        //     Description = 'DITW110.00.12A NRQ#68221';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2036301; "Item Category Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Item Category Code',
        //                 FRA = 'Code catégorie article';
        //     Description = 'MANXL7.00.001';
        //     Editable = false;
        //     TableRelation = "Item Category";

        //     trigger OnValidate();
        //     var
        //         ProductGrp: Record "Product Group";
        //     begin
        //         // <<DITW15.00.00.38 PRODW14.00.00.08.18 DDR 25/08/2011
        //         if "Item Category Code" <> xRec."Item Category Code" then begin
        //             if not ProductGrp.GET("Item Category Code", "_Product Group Code") then
        //                 VALIDATE("_Product Group Code", '')
        //             else
        //                 VALIDATE("_Product Group Code");
        //         end;
        //     end;
        // }
        // field(2036302; "Item Product Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Product Group Code',
        //                 FRA = 'Code groupe produits article';
        //     Description = 'MANXL7.00.001';
        //     Editable = false;
        //     TableRelation = "Product Group".Code where("Item Category Code" = FIELD("Item Category Code"));
        // }
        // field(2036303; "Planning Group"; Code[10])
        // {
        //     CaptionML = ENU = 'Planning Group',
        //                 FRA = 'Groupe de planification';
        //     Description = 'MANXL7.00.001';
        //     Editable = false;
        // }
        // field(2036304; "Production Group"; Code[10])
        // {
        //     CaptionML = ENU = 'Production Group',
        //                 FRA = 'Groupe de production';
        //     Description = 'MANXL7.00.001';
        //     Editable = false;
        // }
        // field(2036305; "Revision No."; Code[10])
        // {
        //     CaptionML = ENU = 'Revision No.',
        //                 FRA = 'N° révision';
        //     Description = 'MANXL7.00.001';
        //     TableRelation = IF ("Source Type" = CONST(Item)) "Item Minor Revision"."Revision No." where("Item No." = FIELD("Source No."));
        // }
        //BC Upgrade PATHAA02<<
    }
    keys
    {
        // key(Key1; "Item Category Code", "Item Product Group Code", "Planning Group", "Production Group")
        // {
        // } //BC Upgrade PATHAA02-DIT field
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Status = Status::Released THEN BEGIN
        ItemLedgEntry.SETRANGE("Order Type",ItemLedgEntry."Order Type"::Production);
        ItemLedgEntry.SETRANGE("Order No.","No.");
        IF NOT ItemLedgEntry.ISEMPTY THEN
          ERROR(
            Text000,
            Status,TABLECAPTION,"No.",ItemLedgEntry.TABLECAPTION);

        CapLedgEntry.SETRANGE("Order Type",CapLedgEntry."Order Type"::Production);
        CapLedgEntry.SETRANGE("Order No.","No.");
        IF NOT CapLedgEntry.ISEMPTY THEN
          ERROR(
            Text000,
            Status,TABLECAPTION,"No.",CapLedgEntry.TABLECAPTION);
      end;

      IF Status IN [Status::Released,Status::Finished] THEN BEGIN
        PurchLine.SETRANGE("Document Type",PurchLine."Document Type"::Order);
        PurchLine.SETRANGE(Type,PurchLine.Type::Item);
        PurchLine.SETRANGE("Prod. Order No.","No.");
        IF NOT PurchLine.ISEMPTY THEN
          ERROR(
            Text000,
            Status,TABLECAPTION,"No.",PurchLine.TABLECAPTION);
      end;

      IF Status = Status::Finished THEN
        DeleteFnshdProdOrderRelations
      else
        DeleteRelations;
      */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
      if Status = Status::Released then begin
        ItemLedgEntry.SETRANGE("Order Type",ItemLedgEntry."Order Type"::Production);
        ItemLedgEntry.SETRANGE("Order No.","No.");
        if not ItemLedgEntry.ISEMPTY then
      #5..10
        if not CapLedgEntry.ISEMPTY then
      #12..14
      end;

      if Status in [Status::Released,Status::Finished] then begin
      #18..20
        if not PurchLine.ISEMPTY then
      #22..24
      end;

      if Status = Status::Finished then
        DeleteFnshdProdOrderRelations
      else
        DeleteRelations;
      */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
      MfgSetup.GET;
      IF "No." = '' THEN BEGIN
        TestNoSeries;
        NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series","Due Date","No.","No. Series");
      end;

      IF Status = Status::Released THEN BEGIN
        IF ProdOrder.GET(Status::Finished,"No.") THEN
          ERROR(Text007,Status,TABLECAPTION,ProdOrder."No.",ProdOrder.Status);
        InvtAdjmtEntryOrder.SETRANGE("Order Type",InvtAdjmtEntryOrder."Order Type"::Production);
        InvtAdjmtEntryOrder.SETRANGE("Order No.","No.");
        IF NOT InvtAdjmtEntryOrder.ISEMPTY THEN
          ERROR(Text007,Status,TABLECAPTION,ProdOrder."No.",InvtAdjmtEntryOrder.TABLECAPTION);
      end;

      InitRecord;

      "Starting Time" := MfgSetup."Normal Starting Time";
      "Ending Time" := MfgSetup."Normal Ending Time";
      "Creation Date" := TODAY;
      UpdateDatetime;
      */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
      MfgSetup.GET;
      if "No." = '' then begin
        TestNoSeries;
        NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series","Due Date","No.","No. Series");
      end;

      if Status = Status::Released then begin
        if ProdOrder.GET(Status::Finished,"No.") then
      #9..11
        if not InvtAdjmtEntryOrder.ISEMPTY then
          ERROR(Text007,Status,TABLECAPTION,ProdOrder."No.",InvtAdjmtEntryOrder.TABLECAPTION);
      end;
      //<<DITW18.00.06 MSF 03/03/2015 DIT-770 #1192
      "Responsibility Center" :=UserSetupMgt.GetRespCenter(3,"Responsibility Center");
      "Physical Location Group Code" := UserSetupMgt.GetphysicalLocation(3,'',"Responsibility Center");
      //>>DITW18.00.06 MSF 03/03/2015 DIT-770 #1192
      #16..21
      */
    //end;


    //Unsupported feature: CodeInsertion on "OnModify". Please convert manually.

    //trigger (Variable: WHSUTILS)();
    //Parameters and return type have not been exported.
    //begin
    /*
      */
    //end;


    //Unsupported feature: CodeModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
      "Last Date Modified" := TODAY;
      IF Status = Status::Finished THEN
        ERROR(Text006);
      */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
      "Last Date Modified" := TODAY;
      if Status = Status::Finished then
        ERROR(Text006);
      //HEI.01>>
      if Status in [Status::"Firm Planned",Status::Released] then begin
        WHSUTILS.CheckUserAuthorizedinZone("Location Code",xRec."Zone Code");
        WHSUTILS.CheckUserAuthorizedinZone("Location Code","Zone Code");
      end;
      //HEI.01<<
      //HEI.14>>
      ValidateAstroProdOrderModification;
      //HEI.14<<
   
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

    //BC Upgrade PATHAA02>>-local variables
    // var
    //     ProductGroup: Record "Product Group";
    //     ItemLocationCode: Code[20];
    //     ProdOrderLineL: Record "Prod. Order Line";
    //     Text000L: Label 'Item No. - %1 already exists in the Line. Would you like to delete the Line to change the Source No. - %2?';

    // var
    //     Item: Record Item;

    // var
    //     Bin: Record Bin;
    //     InventorySetupL: Record "Inventory Setup";
    //     BinL: Record Bin;
    //     DefaultDimensionL: Record "Default Dimension";
    //     Text000L: Label 'The Bin Code - %1 is not empty. Would you like to proceed?';

    // var
    //     WHSUTILS: Codeunit "WHS-UTILS";

    // var
    //     Bin: Record Bin;
    //BC Upgrade PATHAA02<<


    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : @@@="%1 = Document status; %2 = Table caption; %3 = Field value; %4 = Table Caption";ENU=You cannot delete %1 %2 %3 because there is at least one %4 associated with it.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : @@@="%1 = Document status; %2 = Table caption; %3 = Field value; %4 = Table Caption";ENU=You cannot delete %1 %2 %3 because there is at least one %4 associated with it.;FRA=Vous ne pouvez pas supprimer %1 %2 %3 car il existe au moins un %4 qui lui est associé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot rename a %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot rename a %1.;FRA=Vous ne pouvez pas renommer l'enregistrement %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : @@@="%1 = Field caption; %2 = Document status; %3 = Table caption; %4 = Field value; %5 = Table Caption";ENU=You cannot change %1 on %2 %3 %4 because there is at least one %5 associated with it.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : @@@="%1 = Field caption; %2 = Document status; %3 = Table caption; %4 = Field value; %5 = Table Caption";ENU=You cannot change %1 on %2 %3 %4 because there is at least one %5 associated with it.;FRA=Vous ne pouvez pas modifier %1 sur %2 %3 %4, car au moins un %5 lui est associé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=The production order contains lines connected in a multi-level structure and the production order lines have not been automatically rescheduled.\;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=The production order contains lines connected in a multi-level structure and the production order lines have not been automatically rescheduled.\;FRA=L'O.F. contient des lignes associées à une structure multi-niveau et les lignes O.F. n'ont pas été automatiquement replanifiées.\;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=Use Refresh if you want to reschedule the lines.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=Use Refresh if you want to reschedule the lines.;FRA=Utilisez la fonction Actualiser si vous souhaitez replanifier les lignes.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1016)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=A Finished Production Order cannot be modified.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=A Finished Production Order cannot be modified.;FRA=Un O.F. terminé ne peut pas être modifié.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1017)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=%1 %2 %3 cannot be created, because a %4 %2 %3 already exists.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=%1 %2 %3 cannot be created, because a %4 %2 %3 already exists.;FRA=Vous ne pouvez pas créer d'%2 %1 %3 car il existe déjà un %2 %4 %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text008(Variable 1019)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=Nothing to handle.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=Nothing to handle.;FRA=Il n'y a rien à traiter.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text010(Variable 1023)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text010 : ENU=You may have changed a dimension.\\Do you want to update the lines?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text010 : ENU=You may have changed a dimension.\\Do you want to update the lines?;FRA=Vous avez probablement modifié un axe analytique.\\Souhaitez-vous mettre à jour les lignes ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text011(Variable 1024)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text011 : ENU=You cannot change Finished Production Order dimensions.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text011 : ENU=You cannot change Finished Production Order dimensions.;FRA=Vous ne pouvez pas modifier les axes analytiques de l'O.F. terminé.;
    //Variable type has not been exported.

    var
        GLSetup: Record "General Ledger Setup";
        InvtSetup: Record "Inventory Setup";
        Item: Record Item;
        recManufacturingSetup: Record "Manufacturing Setup";
        RespCenter: Record "Responsibility Center";
        // cduCalenderMgmt: Codeunit CalendarManagement; //BC Upgrade PATHAA02 -DIT func-fctCalcHoursPlannedVsAct
        //rMANXLSetup: Record "Manufacturing XL Setup"; //BC Upgrade PATHAA02 -Used in DIT func-
        rSKU: Record "Stockkeeping Unit";
        // SSCCSetup: Record "SSCC Setup"; //BC Upgrade PATHAA02
        ProdBOMCheck: Codeunit "Production BOM-Check";
        UOMMgt: Codeunit "Unit of Measure Management";
        UserSetupMgt: Codeunit "User Setup Management";
        VersionMgt: Codeunit VersionManagement;
        WHSUTILS: Codeunit "WHS-UTILS";
        decFinQty: Decimal;
        decQty: Decimal;
        Text020: TextConst ENU = 'A "%1" Production Order cannot be modified.', FRA = 'Un O.F. terminé ne peut pas être modifié.';
        Text2013660: TextConst ENU = 'Balance', FRA = 'Solde';
        Text2013661: TextConst ENU = 'Consumption', FRA = 'Consommation';
        Text2013662: TextConst ENU = 'Output', FRA = 'Production';
        Text2013663: TextConst ENU = 'Loss', FRA = 'Perte';
        Text2014410: TextConst ENU = 'Your identification is set up to process from %1 %2 only.', FRA = 'Le paramétrage de votre code utilisateur ne vous permet de travailler que sur %1 %2.';
        //PhysLocationGr: Record "Physical Location Group";//BC Upgrade PATHAA02 -Used in DIT func-
        Text2014412: TextConst ENU = 'You cannot use the %1 %2 because your identification is set up to process from %3 %4 only.', FRA = 'Vous ne pouvez pas utiliser le %1 %2 parce que votre identification est mis en place pour traiter de %3 %4 seulement.';
        Text2014413: TextConst ENU = 'If you change %1, all existing will be updated and all sales charge lines will be deleted and new sales charge lines based on the new information on the header will be created.\\', FRA = 'Si vous changez %1, tous les existants seront mis à jour et toutes les lignes de frais de souscription seront supprimés et de nouvelles lignes de frais d''acquisition sur la base de nouvelles informations sur l''en-tête seront créés \\.';
        Text2014414: TextConst ENU = 'You cannot use the %1 %2 because your identification is set up to process from %3 %4 only.', FRA = 'Vous ne pouvez pas utiliser le %1 %2 parce que votre identification est mis en place pour traiter de %3 %4 seulement.';
        Text2035040: TextConst ENU = 'The %1 %2 %3 has SSCC tracking. Do you want to delete it anyway?', FRA = 'Le/la %1 %2 %3 a une traçabilité SSCC. Souhaitez-vous quand même le/la supprimer ?';
        Text2035100: TextConst ENU = 'You do not have permission to change the %1.\\Please contact your system administrator if you need your permissions changing.', FRA = 'Vous n''êtes pas autorisé à modifier le %1. S''il vous plaît contacter \\ votre administrateur système si vous avez besoin de changer vos permissions.';
        Text2035101: TextConst ENU = '%1 cannot be changed to %2.', FRA = '%1 ne peut pas changé vers %2.';
        Text2035102: TextConst ENU = 'Are you sure you want to change the %1 from %2 to %3?', FRA = 'Etes-vous sûr que vous voulez changer %1 à partir de %2 vers %3?';
        Text2035240: TextConst Comment = '%1 = Field Caption; %2 = Field Value; %3 = Table Caption', ENU = 'You cannot modify %1 %2 because there is at least one %3 associated with it.';

    trigger OnModify()
    begin
        //HEI.01>>
        //BC Upgrade Kamnay01 >>Bug fix RPO and FPO commented here and wrote code in the location code onbeforevalidate.
        // IF Status IN [Status::"Firm Planned", Status::Released] THEN BEGIN
        //     WHSUTILS.CheckUserAuthorizedinZone("Location Code", xRec."Zone Code FND");
        //     WHSUTILS.CheckUserAuthorizedinZone("Location Code", "Zone Code FND");
        // end;
        //BC Upgrade Kamnay01 << bug fix  RPO and FPO commented here and wrote code in the location code onbeforevalidate.

        //HEI.01<<
        //HEI.14>>
        //ValidateAstroProdOrderModification; //BC Upgrade PATHAA02-Astro
        //HEI.14<<
    end;

    //BC Upgrade PATHAA02-Astro>>
    // procedure ValidateAstroProdOrderModification()
    // var
    //     AstroInterfaceSetupL: Record "Astro Interface Setup";
    //     InterfaceSetupL: Record "Interface Setup";
    // begin
    //     //HEI.14>>
    //     IF GUIALLOWED AND "Parked ORDER Astro" THEN
    //         IF Status IN [Status::"Firm Planned", Status::Released] THEN
    //             IF AstroInterfaceSetupL.GET AND AstroInterfaceSetupL."Enabled Astro Integration" THEN
    //                 IF AstroInterfaceSetupL."Activate Prod. Order" AND (AstroInterfaceSetupL."Prod. Order Interface" <> '') THEN
    //                     IF InterfaceSetupL.GET(AstroInterfaceSetupL."Prod. Order Interface") THEN
    //                         ERROR(Text020, FIELDCAPTION("Parked ORDER Astro"));
    //     //HEI.14<<
    // end;
    // //BC Upgrade PATHAA02-Astro<<
    //BC upgrade Kamnay01 >>BUG fix RPO and FPO
    procedure CheckUserAuthorizedinZone(LocationCode: Code[10]; ZoneCode: Code[10]);
    var
        WarehouseEmpl: Record "Warehouse Employee_DTW FND";
        ItemJnlPostBatchL: Codeunit "Item Jnl.-Post Batch";
        ErrorTextL: Text[250];
        Text002: Label 'User ID %1 is not authorized for Location %2 Zone %3. Remove location code then reselect';
    begin
        WarehouseEmpl.SETRANGE("User ID", UPPERCASE(USERID));
        if LocationCode = '' then
            exit;
        if ZoneCode = '' then
            exit;
        WarehouseEmpl.SETRANGE("Location Code", LocationCode);
        WarehouseEmpl.SETRANGE("Zone Code", ZoneCode);
        if WarehouseEmpl.ISEMPTY then begin
            //HEI.18>>
            //HEI.18<<
            //Rec.Validate("Location Code", xRec."Location Code");
            ERROR(STRSUBSTNO(Text002, USERID, LocationCode, ZoneCode));
            // Error(Text002);
        end;
    end;
    //BC upgrade Kamnay01 <<BUG fix RPO and FPO


    //BC Upgrade PATHAA02 HEI.09>>
    procedure UpdateTileCode()
    var
        lDimensionSetEntry: Record "Dimension Set Entry";
        lRoleCenterTileSetup: Record "Role Center Tile Setup FND";
        lProdOrderNo: Code[20];
        lStatus: Enum "Production Order Status";
        lRoleCentreTileCode: Text[30];

    begin
        //HEI.09>>
        lRoleCentreTileCode := Rec."Role Centre Tile Code FND";
        Rec."Role Centre Tile Code FND" := '';
        lStatus := Rec.Status;
        lProdOrderNo := Rec."No.";

        lRoleCenterTileSetup.RESET();
        lRoleCenterTileSetup.SETRANGE("Location Code", Rec."Location Code");
        lRoleCenterTileSetup.SETRANGE("Zone Code", Rec."Zone Code FND");
        IF lRoleCenterTileSetup.FINDFIRST() THEN
            REPEAT
                IF ((lRoleCenterTileSetup."Dimension Code" = '') AND (lRoleCenterTileSetup."Dimension Filter Value" = '')) THEN
                    Rec."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";

                IF ((lRoleCenterTileSetup."Dimension Code" <> '') OR (lRoleCenterTileSetup."Dimension Filter Value" <> '')) THEN BEGIN
                    lDimensionSetEntry.RESET();
                    lDimensionSetEntry.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
                    IF (lRoleCenterTileSetup."Dimension Code" <> '') THEN
                        lDimensionSetEntry.SETRANGE("Dimension Code", lRoleCenterTileSetup."Dimension Code");
                    IF (lRoleCenterTileSetup."Dimension Filter Value" <> '') THEN
                        lDimensionSetEntry.SETFILTER("Dimension Value Code", lRoleCenterTileSetup."Dimension Filter Value");
                    IF lDimensionSetEntry.FINDFIRST() THEN
                        Rec."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";
                end;
            UNTIL lRoleCenterTileSetup.NEXT() = 0;

        lRoleCenterTileSetup.RESET();
        lRoleCenterTileSetup.SETRANGE("Location Code", Rec."Location Code");
        lRoleCenterTileSetup.SETRANGE("Zone Code", '');
        IF lRoleCenterTileSetup.FINDFIRST() THEN
            REPEAT
                IF ((lRoleCenterTileSetup."Dimension Code" = '') AND (lRoleCenterTileSetup."Dimension Filter Value" = '')) THEN
                    Rec."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";

                IF ((lRoleCenterTileSetup."Dimension Code" <> '') OR (lRoleCenterTileSetup."Dimension Filter Value" <> '')) THEN BEGIN
                    lDimensionSetEntry.RESET();
                    lDimensionSetEntry.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
                    IF (lRoleCenterTileSetup."Dimension Code" <> '') THEN
                        lDimensionSetEntry.SETRANGE("Dimension Code", lRoleCenterTileSetup."Dimension Code");
                    IF (lRoleCenterTileSetup."Dimension Filter Value" <> '') THEN
                        lDimensionSetEntry.SETFILTER("Dimension Value Code", lRoleCenterTileSetup."Dimension Filter Value");
                    IF lDimensionSetEntry.FINDFIRST() THEN
                        Rec."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";
                end;
            UNTIL lRoleCenterTileSetup.NEXT() = 0;


        lRoleCenterTileSetup.RESET();
        lRoleCenterTileSetup.SETRANGE("Location Code", '');
        lRoleCenterTileSetup.SETRANGE("Zone Code", Rec."Zone Code FND");
        IF lRoleCenterTileSetup.FINDFIRST() THEN
            REPEAT
                IF ((lRoleCenterTileSetup."Dimension Code" = '') AND (lRoleCenterTileSetup."Dimension Filter Value" = '')) THEN
                    Rec."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";

                IF ((lRoleCenterTileSetup."Dimension Code" <> '') OR (lRoleCenterTileSetup."Dimension Filter Value" <> '')) THEN BEGIN
                    lDimensionSetEntry.RESET();
                    lDimensionSetEntry.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
                    IF (lRoleCenterTileSetup."Dimension Code" <> '') THEN
                        lDimensionSetEntry.SETRANGE("Dimension Code", lRoleCenterTileSetup."Dimension Code");
                    IF (lRoleCenterTileSetup."Dimension Filter Value" <> '') THEN
                        lDimensionSetEntry.SETFILTER("Dimension Value Code", lRoleCenterTileSetup."Dimension Filter Value");
                    IF lDimensionSetEntry.FINDFIRST() THEN
                        Rec."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";
                end;
            UNTIL lRoleCenterTileSetup.NEXT() = 0;

        lRoleCenterTileSetup.RESET();
        lRoleCenterTileSetup.SETRANGE("Location Code", '');
        lRoleCenterTileSetup.SETRANGE("Zone Code", '');
        IF lRoleCenterTileSetup.FINDFIRST() THEN
            REPEAT
                IF ((lRoleCenterTileSetup."Dimension Code" <> '') OR (lRoleCenterTileSetup."Dimension Filter Value" <> '')) THEN BEGIN
                    lDimensionSetEntry.RESET();
                    lDimensionSetEntry.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
                    IF (lRoleCenterTileSetup."Dimension Code" <> '') THEN
                        lDimensionSetEntry.SETRANGE("Dimension Code", lRoleCenterTileSetup."Dimension Code");
                    IF (lRoleCenterTileSetup."Dimension Filter Value" <> '') THEN
                        lDimensionSetEntry.SETFILTER("Dimension Value Code", lRoleCenterTileSetup."Dimension Filter Value");
                    IF lDimensionSetEntry.FINDFIRST() THEN
                        Rec."Role Centre Tile Code FND" := lRoleCenterTileSetup."Role Center Tile Code";
                end;
            UNTIL lRoleCenterTileSetup.NEXT() = 0;

        IF ((Rec."Role Centre Tile Code FND" = '') AND (lRoleCentreTileCode <> '')) THEN
            Rec."Role Centre Tile Code FND" := lRoleCentreTileCode;
        //HEI.09<<
    end;
    //BC Upgrade GUNREM01 added DIT code >>
    local procedure CheckCapLedgEntry(): Boolean
    var
        myInt: Integer;
        CapLedgEntry: Record "Capacity Ledger Entry";
    begin
        CapLedgEntry.SETCURRENTKEY("Order Type", "Order No.", "Order Line No.");
        CapLedgEntry.SETRANGE("Order Type", CapLedgEntry."Order Type"::Production);
        CapLedgEntry.SETRANGE("Order No.", "No.");

        EXIT(NOT CapLedgEntry.ISEMPTY);
    end;
    //BC Upgrade GUNREM01 added DIT code <<
}



