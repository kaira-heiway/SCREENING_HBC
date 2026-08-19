tableextension 50203 ProdOrderLineExtFND extends "Prod. Order Line"
{
    // version NAVW111.00.16585,FINXL10.00,MANXL10.01,QXL9.00.001,DITW111.00.13,HEI.03,HEI.06,HEI.10

    // DITW16.00.00.40 DDR 13/06/2012 DIT-715 #338 Added functions AllItemsAvailability()

    // FINXL7.00.001 RBE 20/03/2013 : Item description extend from 30 -> 80 chars

    // MANXL7.00.001 DAT 03/03/2014 #10: Subcontractors Dispatch Screen
    // MANXL7.00.001 DAT 03/03/2014 #12: Version Management
    // MANXL7.00.001 DAT 05/03/2014 #18: Add field "Requester ID"
    // MANXL7.00.001 WSA 11/07/2014 #87: Added code MANXL security
    // MANXL7.00.001 WSA 15/07/2014 #76: Resize the field "Requester ID" 20 -> 50
    // FINXL8.00.001 BSA 02/06/2015 #178: Added field "Cross Reference No."

    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //                                          Disabled fields
    //                                            2035166 _Product Group Code
    //                                            2035208 _Item Category Code
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00 MSF 27/04/2015 DIT-770 #1363 Fix Upgrade Tag
    // DITW18.00.06 AKH 10/02/2015 DIT-770 #1184 Multisite - Production Orders: Consider possible BOM and Routing setup on SKU card
    // DITW18.00.06 AKH 16/02/2015 DIT-770 #1189 Multisite - User access per site:  Limit user access to locations in Warehouse Employee Setup
    // DITW18.00.06 MSF 16/02/2015 DIT-770 #1185 Get "Indirect Cost %" From SKU card
    // DITW18.00.06 MSF 28/02/2015 DIT-770 #1192 Added fields 2014410 "Responsibility Center"
    //                                                        2014411 "Physical Location Group Code"
    //                                                        2014412 "Resp. Center Table Filter"
    //                                                        2014513 "Phys. Location Table Filter"
    //                                                        2014514 "Location Table Filter"
    //                                                        Modify Function createDim
    // DITW18.00.06 MSF 01/03/2015 DIT-770 #1192 Bug Fix
    // DITW18.00.06 AKH 04/03/2015 DIT-770 #1197 Multisite - Site dimension in item transactions : Added code to generate dimension from Responsibility Center
    // DITW18.00.06 MSF 05/06/2015 DIT-770 #1416 #1417 Error message when no setup on Resp Center employee location
    // DITW18.00.06 MSF 11/06/2015 DIT-770 #1416 #1417 Restore Code
    // DITW18.00.07 VSC 14/01/2016 DIT-770 #1668 Unit Cost from SKU
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    // DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                      Added fields
    //                                                        2013716 Strength Spec. Code
    //                                                        2013717 Strength Spec. Value
    //                                                        2013718 Vol-Strength Spec. Code
    //                                                        2013719 Vol-Strength Spec. Value
    //                                                        2013767 Unit Volume HL
    //                                                        2035242 Quantity (Brewing Base)
    // DITW19.00.08 AKH 22/09/2016 BL#11719 (DIT-770 #2188) Removed unnecessary Validate for "Responsibility Center" and "Physical Location Group Code"
    // DITW19.00.08 DDR 29/09/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                      Added functions CheckItemCarrySNLot(),IsItemCarrySNLot()
    //                                                      Added text constants Text2013763
    // DITW19.00.08 DDR 17/10/2016 BL#10443 Modified function GetTaxSpecCaption()
    //                                      Added functions UpdateStrengthValues()
    // DITW19.00.08 DDR 20/10/2016 BL#10443 Bugfix function GetTaxSpecCaption()
    //                                      Removed functions UpdateStrengthValues(),CalcVolumeStrength()
    //                                      Removed fields
    //                                        2013717 Strength Spec. Value
    //                                        2013719 Vol-Strength Spec. Value

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 02/02/2017 NRQ#20692 Item Category Code length 20
    // DITW110.00.08 DDR 03/02/2017 NRQ#20685 Bugfix bad character in filter of flowfields 2013717,2013719
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // DITW110.00.09 AKH 29/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #added fields Zone Code
    // HEI.02 FDD-PRDGAP032 IBM HORTOC01 17.07.2017 #standard code comment
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // FINXL10.00 YHE 15/06/2017 NXL#29836: added code in fctValidateCrossReference
    // DITW110.00.11 SFI 31/08/2017 BL#30569 Added changes for SKU blocking
    // DITW110.00.12 DDR 20/02/2018 NRQ#55983 Fix NRQ#17693 + DIT-770 #1184
    // DITW110.00.12 AKH 21/03/2018 NRQ#64704 Adjusted code to use the "Production Unit of Measure" instead of "Base Unit of Measure" of the item
    // DITW110.00.12A HBA 18/06/2018 NRQ#68221 Adjusted code in function GetUpdateFromSKU()
    // DITW111.00.13 MZOU 07/11/2018 NRQ#91446 Routing, BOM and Version should not be changed in the production order when ledger entries exist

    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #added fields Zone Code
    // HEI.02 FDD-PRDGAP032 IBM HORTOC01 17.07.2017 #standard code comment
    // HEI.03 FDD-PRDGAP024 IBM SOICAD01 25.07.2017 #Changed Zone code table relation to not show in transit zones
    // HEI.04 FDD-GAPID031 IBM.PATHAA02 17.08.2017
    //   # Description made non-Editable
    // HEI.05 FDD-PRDGAP027 , No Lot No., Bin code in FPO and RPO, Production Journal Page, IBM.NAIKH01 22.08.2017
    //   # Code Commented in Function "GetDefaultBin()" , to avoid default Bin Code in the Line Item and in Production Journal Page for Entry type "Output"
    // HEI.06 FDD-PRDGAP032 IBM HORTOC01 12.09.2017 - DefectID 213
    // HEI.07 CHG2007832 IBM ISYED01 3.21.2019
    //  #System is not auto populating Zone Code and bin Code fields after production order refreshing.
    // HEI.08 RFC-CHG0257267 IBM.AB 15.10.2018
    //   # Code added to to take Active version of BOM and Routing
    // HEI.09 CHG2119017 IBM.LS      24.08.2021
    //   # Added Code
    // HEI.10 CHG2149734 SAHAL01 07.09.2022
    //   # Added Code to restrict modification after Parked the Prod. Order for Astro.

    //Bc Upgrade YADAVM09 Production Bom No on Validate code add in event OnValidateProductionBOMNoOnBeforeTestStatus.
    //Bc Upgrade YADAVM09 Getdefault Function code//HEI.07 handled on field onvalidate trigger on below fields:
    //   #Item No
    //   #Varient Code
    //   #Location code
    //Bc Upgrade YADAVM09 Rount no onvalidate code added on event OnBeforeValidateRoutingNo.
    fields
    {
        modify(Status)
        {
            CaptionML = ENU = 'Status', FRA = 'Statut';
            // OptionCaptionML = ENU = 'Simulated,Planned,Firm Planned,Released,Finished', FRA = 'Simulé,Planifié,Planifié ferme,Lancé,Terminé';
        }
        modify("Prod. Order No.")
        {
            CaptionML = ENU = 'Prod. Order No.', FRA = 'N° ordre de fabrication';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify("Item No.")
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
            //BC Upgrade YADAVM09>>
            trigger OnAfterValidate()
            var
                ProdOrderWarehouseMgt: Codeunit "Prod. Order Warehouse Mgt.";
                WMSManagement: Codeunit "WMS Management";
                item: Record Item;
            begin
                "Bin Code" := '';
                if ("Location Code" <> '') and ("Item No." <> '') then begin
                    "Bin Code" :=
                        ProdOrderWarehouseMgt.GetLastOperationFromBinCode(
                            "Routing No.", "Routing Version Code", "Location Code", false, Enum::"Flushing Method"::Manual);
                    GetLocation("Location Code");
                    if "Bin Code" = '' then
                        "Bin Code" := Location."From-Production Bin Code";
                    //HEI.07>>
                    IF Bin.GET("Location Code", "Bin Code") THEN
                        "Zone Code FND" := Bin."Zone Code";
                    IF "Zone Code FND" <> '' THEN
                        WHSUTILS.CheckUserAuthorizedinZone("Location Code", "Zone Code FND");
                    //HEI.07<<
                end;
                VALIDATE("Bin Code");
                //BC Upgrade Kamnay01- Bug Fix >>
                item.Get("Item No.");
                Rec.Validate("Unit of Measure Code", item."Production Unit of Measure FND");
                //BC Upgrade Kamnay01- Bug Fix<<
            end;


            //BC Upgrade YADAVM09<<

        }
        modify("Variant Code")
        {
            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
            //BC Upgrade YADAVM09>>
            trigger OnAfterValidate()
            var
                ProdOrderWarehouseMgt: Codeunit "Prod. Order Warehouse Mgt.";
                WMSManagement: Codeunit "WMS Management";
            begin
                "Bin Code" := '';
                if ("Location Code" <> '') and ("Item No." <> '') then begin
                    "Bin Code" :=
                        ProdOrderWarehouseMgt.GetLastOperationFromBinCode(
                            "Routing No.", "Routing Version Code", "Location Code", false, Enum::"Flushing Method"::Manual);
                    GetLocation("Location Code");
                    if "Bin Code" = '' then
                        "Bin Code" := Location."From-Production Bin Code";
                    //HEI.07>>
                    IF Bin.GET("Location Code", "Bin Code") THEN
                        "Zone Code FND" := Bin."Zone Code";
                    IF "Zone Code FND" <> '' THEN
                        WHSUTILS.CheckUserAuthorizedinZone("Location Code", "Zone Code FND");
                    //HEI.07<<
                end;
                VALIDATE("Bin Code");
            end;
            //BC Upgrade YADAVM09<<
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';

            //Unsupported feature: Change Description on "Description(Field 13)". Please convert manually.


            //Unsupported feature: Change Editable on "Description(Field 13)". Please convert manually.

        }
        modify("Description 2")
        {
            CaptionML = ENU = 'Description 2', FRA = 'Désignation 2';
        }
        modify("Location Code")
        {

            //Unsupported feature: Change TableRelation on ""Location Code"(Field 20)". Please convert manually.

            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
            //BC Upgrade YADAVM09>>
            trigger OnAfterValidate()
            var
                ProdOrderWarehouseMgt: Codeunit "Prod. Order Warehouse Mgt.";
                WMSManagement: Codeunit "WMS Management";
            begin
                "Bin Code" := '';
                if ("Location Code" <> '') and ("Item No." <> '') then begin
                    "Bin Code" :=
                        ProdOrderWarehouseMgt.GetLastOperationFromBinCode(
                            "Routing No.", "Routing Version Code", "Location Code", false, Enum::"Flushing Method"::Manual);
                    GetLocation("Location Code");
                    if "Bin Code" = '' then
                        "Bin Code" := Location."From-Production Bin Code";
                    //HEI.07>>
                    IF Bin.GET("Location Code", "Bin Code") THEN
                        "Zone Code FND" := Bin."Zone Code";
                    IF "Zone Code FND" <> '' THEN
                        WHSUTILS.CheckUserAuthorizedinZone("Location Code", "Zone Code FND");
                    //HEI.07<<
                end;
                VALIDATE("Bin Code");
            end;
            //BC Upgrade YADAVM09<<
        }

        modify("Shortcut Dimension 1 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 2 Code', FRA = 'Code raccourci axe 2';
        }
        modify("Bin Code")
        {
            CaptionML = ENU = 'Bin Code', FRA = 'Code emplacement';

            trigger OnAfterValidate()
            begin
                //HEI.09>>
                IF CurrFieldNo <> 0 THEN BEGIN
                    InventorySetupL.GET();
                    IF InventorySetupL."CMG Code for Empty Bin FND" <> '' THEN BEGIN
                        IF ("Bin Code" <> '') AND BinL.GET("Location Code", "Bin Code") AND (NOT BinL.Empty) THEN BEGIN
                            DefaultDimensionL.SETCURRENTKEY("Table ID", "No.", "Dimension Code", "Dimension Value Code");
                            DefaultDimensionL.SETRANGE("Table ID", DATABASE::Item);
                            DefaultDimensionL.SETRANGE("No.", "Item No.");
                            DefaultDimensionL.SETRANGE("Dimension Code", 'CMG');
                            DefaultDimensionL.SETFILTER("Dimension Value Code", InventorySetupL."CMG Code for Empty Bin FND");
                            IF DefaultDimensionL.FINDFIRST() THEN BEGIN
                                IF NOT CONFIRM(Text000L, FALSE, "Bin Code") THEN
                                    ERROR('');
                            end;
                        end;
                    end;
                    //HEI.10>>
                    //HEI.10>>
                    //IF xRec."Bin Code" <> "Bin Code" THEN BEGIN //BCUPGRADE YADAVM09 Blocked as Astro is out of scope
                    // ValidateAstroProdOrderLineModification;//BCUPGRADE YADAVM09 Blocked as Astro is out of scope

                end;
                //HEI.10<<
            end;
            //HEI.09<<
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Finished Quantity")
        {
            CaptionML = ENU = 'Finished Quantity', FRA = 'Quantité réalisée';
        }
        modify("Remaining Quantity")
        {
            CaptionML = ENU = 'Remaining Quantity', FRA = 'Quantité restante';
        }
        modify("Scrap %")
        {
            CaptionML = ENU = 'Scrap %', FRA = '% perte';
        }
        modify("Due Date")
        {
            CaptionML = ENU = 'Due Date', FRA = 'Délai';
        }
        modify("Starting Date")
        {
            CaptionML = ENU = 'Starting Date', FRA = 'Date début';
        }
        modify("Starting Time")
        {
            CaptionML = ENU = 'Starting Time', FRA = 'Heure début';
        }
        modify("Ending Date")
        {
            CaptionML = ENU = 'Ending Date', FRA = 'Date fin';
        }
        modify("Ending Time")
        {
            CaptionML = ENU = 'Ending Time', FRA = 'Heure fin';
        }
        modify("Planning Level Code")
        {
            CaptionML = ENU = 'Planning Level Code', FRA = 'Code niveau de planification';
        }
        modify(Priority)
        {
            CaptionML = ENU = 'Priority', FRA = 'Priorité';
        }
        modify("Production BOM No.")
        {
            CaptionML = ENU = 'Production BOM No.', FRA = 'N° nomenclature production';
        }
        modify("Routing No.")
        {
            CaptionML = ENU = 'Routing No.', FRA = 'N° gamme';
        }
        modify("Inventory Posting Group")
        {
            CaptionML = ENU = 'Inventory Posting Group', FRA = 'Groupe compta. stock';
        }
        modify("Routing Reference No.")
        {
            CaptionML = ENU = 'Routing Reference No.', FRA = 'N° référence gamme';
        }
        modify("Unit Cost")
        {
            CaptionML = ENU = 'Unit Cost', FRA = 'Coût unitaire';
            /* //BC Upgrade YadavM09 Blocked as Astro is out of scope>>
            trigger OnAfterValidate()
            begin
                HEI.10>>
                 IF (xRec."Unit Cost" <> "Unit Cost") AND (CurrFieldNo <> 0) THEN BEGIN
                    ValidateAstroProdOrderLineModification;
                end;
                HEI.10<<
            end;
            */ //BC Upgrade YadavM09 Blocked as Astro is out of scope<<

        }
        modify("Cost Amount")
        {
            CaptionML = ENU = 'Cost Amount', FRA = 'Coût total';
        }
        modify("Reserved Quantity")
        {
            CaptionML = ENU = 'Reserved Quantity', FRA = 'Quantité réservée';
        }
        modify("Capacity Type Filter")
        {
            CaptionML = ENU = 'Capacity Type Filter', FRA = 'Filtre type capacité';
            //OptionCaptionML = ENU = 'Work Center,Machine Center', FRA = 'Centre de charge,Poste de charge';
        }
        modify("Capacity No. Filter")
        {
            CaptionML = ENU = 'Capacity No. Filter', FRA = 'Filtre capacité';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }

        modify("Unit of Measure Code")
        {
            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
            /* //BC Upgrade YadavM09 Blocked as Astro is out of scope>>
                       trigger OnAfterValidate()
                       begin
                           //HEI.10>>
                            IF (xRec."Unit of Measure Code" <> "Unit of Measure Code") AND (CurrFieldNo <> 0) THEN BEGIN
                                ValidateAstroProdOrderLineModification;
                            end;
                           //HEI.10<<
                       end;
             */ //BC Upgrade YadavM09 Blocked as Astro is out of scope<<
        }

        modify("Quantity (Base)")
        {
            CaptionML = ENU = 'Quantity (Base)', FRA = 'Quantité (base)';
        }
        modify("Finished Qty. (Base)")
        {
            CaptionML = ENU = 'Finished Qty. (Base)', FRA = 'Quantité réalisée (base)';
        }
        modify("Remaining Qty. (Base)")
        {
            CaptionML = ENU = 'Remaining Qty. (Base)', FRA = 'Quantité restante (base)';
        }
        modify("Reserved Qty. (Base)")
        {
            CaptionML = ENU = 'Reserved Qty. (Base)', FRA = 'Quantité réservée (base)';
        }
        modify("Expected Operation Cost Amt.")
        {
            CaptionML = ENU = 'Expected Operation Cost Amt.', FRA = 'Coût opératoire total prévu';
        }
        modify("Total Exp. Oper. Output (Qty.)")
        {
            CaptionML = ENU = 'Total Exp. Oper. Output (Qty.)', FRA = 'Production totale prévue (qté)';
        }
        modify("Expected Component Cost Amt.")
        {
            CaptionML = ENU = 'Expected Component Cost Amt.', FRA = 'Coût composant total prévu';
        }

        modify("Starting Date-Time")
        {
            CaptionML = ENU = 'Starting Date-Time', FRA = 'Date/Heure début';
            /* //BC Upgrade YADAV09 Astro code Commented>>
           trigger OnAfterValidate()
           begin
               //HEI.10>>
                IF (xRec."Starting Date-Time" <> "Starting Date-Time") AND (CurrFieldNo <> 0) THEN BEGIN
                   ValidateAstroProdOrderLineModification;
                end;
               //HEI.10<<
           end;
           */ //BC Upgrade YADAV09 Astro code Commented<<
        }

        modify("Ending Date-Time")
        {
            CaptionML = ENU = 'Ending Date-Time', FRA = 'Date/Heure fin';
            /*// BC Upgrade YADAV09 Astro code Commented>>
            trigger OnAfterValidate()
            begin           
                //HEI.10>>
                 IF (xRec."Ending Date-Time" <> "Ending Date-Time") AND (CurrFieldNo <> 0) THEN BEGIN
                    ValidateAstroProdOrderLineModification;
                 end;
                HEI.10<<              
            end;
            */ // BC Upgrade YADAV09 Astro code Commented<<
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Cost Amount (ACY)")
        {
            CaptionML = ENU = 'Cost Amount (ACY)', FRA = 'Coût total DR';
        }
        modify("Unit Cost (ACY)")
        {
            CaptionML = ENU = 'Unit Cost (ACY)', FRA = 'Coût unitaire DR';
        }
        modify("Production BOM Version Code")
        {
            CaptionML = ENU = 'Production BOM Version Code', FRA = 'Code version nomenclature';
        }
        modify("Routing Version Code")
        {
            CaptionML = ENU = 'Routing Version Code', FRA = 'Code version gamme';
        }
        modify("Routing Type")
        {
            CaptionML = ENU = 'Routing Type', FRA = 'Type gamme';
            OptionCaptionML = ENU = 'Serial,Parallel', FRA = 'Séquentielle,Parallèle';
        }
        modify("Qty. per Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Unit of Measure', FRA = 'Quantité par unité';
        }
        modify("MPS Order")
        {
            CaptionML = ENU = 'MPS Order', FRA = 'Ordre PDP';
        }
        modify("Planning Flexibility")
        {
            CaptionML = ENU = 'Planning Flexibility', FRA = 'Flexibilité planification';
            // OptionCaptionML = ENU = 'Unlimited,None', FRA = 'Illimitée,Aucune';
        }
        modify("Indirect Cost %")
        {
            CaptionML = ENU = 'Indirect Cost %', FRA = '% coût indirect';
        }
        modify("Overhead Rate")
        {
            CaptionML = ENU = 'Overhead Rate', FRA = 'Frais généraux';
        }



        //Unsupported feature: CodeModification on ""Item No."(Field 11).OnValidate". Please convert manually.

        //trigger "(Field 11)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReserveProdOrderLine.VerifyChange(Rec,xRec);
        TESTFIELD("Finished Quantity",0);
        CALCFIELDS("Reserved Quantity");
        TESTFIELD("Reserved Quantity",0);
        WhseValidateSourceLine.ProdOrderLineVerifyChange(Rec,xRec);
        if "Item No." <> xRec."Item No." then begin
          DeleteRelations;
          "Variant Code" := '';
        end;
        if "Item No." = '' then
          INIT
        #12..16
          "Ending Time" := ProdOrder."Ending Time";
          "Due Date" := ProdOrder."Due Date";
          "Location Code" := ProdOrder."Location Code";
          "Bin Code" := ProdOrder."Bin Code";
          if "Bin Code" = '' then
            GetDefaultBin;

          GetItem;
          Item.TESTFIELD("Inventory Posting Group");
          "Inventory Posting Group" := Item."Inventory Posting Group";

          Description := Item.Description;
        #29..33
          "Unit Cost" := Item."Unit Cost";
          "Indirect Cost %" := Item."Indirect Cost %";
          "Overhead Rate" := Item."Overhead Rate";
          if "Item No." <> xRec."Item No." then begin
            VALIDATE("Production BOM No.",Item."Production BOM No.");
            VALIDATE("Routing No.",Item."Routing No.");
            VALIDATE("Unit of Measure Code",Item."Base Unit of Measure");
          end;
          if ProdOrder."Source Type" = ProdOrder."Source Type"::Family then
            "Routing Reference No." := 0
          else
            if "Line No." = 0 then
              "Routing Reference No." := -10000
            else
              "Routing Reference No." := "Line No.";
        end;
        if "Item No." <> xRec."Item No." then
          VALIDATE(Quantity);
        GetUpdateFromSKU;

        CreateDim(DATABASE::Item,"Item No.");
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..8
          //HEI.10>>
          if CurrFieldNo <> 0 then begin
            ValidateAstroProdOrderLineModification;
          end;
          //HEI.10<<
        #9..19
          //<<DITW18.00.06 MSF 02/03/2015 DIT-770 #1192 - DITW19.00.08 AKH 22/09/2016 BL#11719
          "Physical Location Group Code" := ProdOrder."Physical Location Group Code";
          "Responsibility Center" := ProdOrder."Responsibility Center";
          //>>DITW18.00.06 MSF DIT-770 #1192 - DITW19.00.08 AKH BL#11719
        #20..25
          // << DITW110.00.11 SFI 31/08/2017 BL#30569
          Item.BlockedSKU("Location Code","Variant Code",true);
          // >> DITW110.00.11 SFI BL#30569
        #26..36

          // <<DITW19.00.08 DDR 17/08/2016 17/10/2016 BL#10443
          "Unit Volume HL" := Item."Unit Volume HL" * UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");
          "Strength Spec. Code" := Item."Strength Spec. Code";
          "Vol-Strength Spec. Code" := Item."Vol-Strength Spec. Code";
          // >>DITW19.00.08 DDR BL#10443

        #37..39
            //<< DITW110.00.12 AKH 21/03/2018 NRQ#64704
            //VALIDATE("Unit of Measure Code",Item."Base Unit of Measure");
            if (ProdOrder."Unit of Measure Code" <> '') then
              VALIDATE("Unit of Measure Code",ProdOrder."Unit of Measure Code")
            else
              VALIDATE("Unit of Measure Code",Item."Production Unit of Measure");
            //>> DITW110.00.12 AKH NRQ#64704
        #41..48
          // <<DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008
          "Planning Colour" := Item."Planning Colour";
          // >>DITW15.00.00.22 PRODW14.00.00.08 DDR
          // <<DITW15.00.00.39 PRODW14.00.00.08.18 DDR 25/08/2011 #1372
          "Item Category Code" := Item."Item Category Code";
          "_Product Group Code" := Item."Product Group Code";
          // >>DITW15.00.00.39 PRODW14.00.00.08.18 DDR #1372
        #49..53
        CreateDim(DATABASE::Item,"Item No.",
        //<<DITW18.00.06 MSF DIT-770 #1192
        DATABASE::"Responsibility Center", "Responsibility Center"
        //>>DITW18.00.06 MSF DIT-770 #1192
         );

        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        //<<FINXL8.00.001 BSA 02/06/2015 #178
        if recFinXLSetup.READPERMISSION then fctGetCrossReference;
        //>>FINXL8.00.001 BSA 02/06/2015 #178
        */
        //end;


        //Unsupported feature: CodeModification on ""Variant Code"(Field 12).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReserveProdOrderLine.VerifyChange(Rec,xRec);
        TESTFIELD("Finished Quantity",0);
        CALCFIELDS("Reserved Quantity");
        #4..10
        ItemVariant.GET("Item No.","Variant Code");
        Description := ItemVariant.Description;
        "Description 2" := ItemVariant."Description 2";
        GetUpdateFromSKU;
        GetDefaultBin;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..13
        // << DITW110.00.11 SFI 31/08/2017 BL#30569
        GetItem();
        Item.BlockedSKU("Location Code","Variant Code",true);
        // >> DITW110.00.11 SFI BL#30569
        GetUpdateFromSKU;
        GetDefaultBin;
        //HEI.10>>
        if (xRec."Variant Code" <> "Variant Code") and (CurrFieldNo <> 0) then begin
          ValidateAstroProdOrderLineModification;
        end;
        //HEI.10<<
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Description 2"(Field 14)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //HEI.10>>
        if (xRec."Description 2" <> "Description 2") and (CurrFieldNo <> 0) then begin
          ValidateAstroProdOrderLineModification;
        end;
        //HEI.10<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Location Code"(Field 20).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReserveProdOrderLine.VerifyChange(Rec,xRec);
        WhseValidateSourceLine.ProdOrderLineVerifyChange(Rec,xRec);
        GetUpdateFromSKU;
        GetDefaultBin;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ReserveProdOrderLine.VerifyChange(Rec,xRec);
        WhseValidateSourceLine.ProdOrderLineVerifyChange(Rec,xRec);
        // <<DITW18.00.06 MSF 01/03/2015 DIT-770 #1192
        if ("Responsibility Center" = xRec."Responsibility Center") and ("Location Code" <> xRec."Location Code") and
          ("Location Code" <> '')
        then begin
          Location.GET("Location Code");
          VALIDATE("Responsibility Center",UserSetupMgt.GetFirstRespCenter(3,Location."Physical Location Group Code","Location Code"));
        end;
        // <<DITW18.00.06 MSF 01/03/2015 DIT-770 #1192
        // <<DITW18.00.06 MSF 28/02/2015 DIT-770 #1192
        if "Responsibility Center" <> xRec."Responsibility Center" then
          if not UserSetupMgt.CheckLocation(3,"Location Code","Responsibility Center") then
            ERROR(
              Text2014414,
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
        // >>DITW18.00.06 MSF 28/02/2015 DIT-770 #1192
        // << DITW110.00.11 SFI 31/08/2017 BL#30569
        GetItem();
        Item.BlockedSKU("Location Code","Variant Code",true);
        // >> DITW110.00.11 SFI BL#30569

        GetUpdateFromSKU;
        GetDefaultBin;
        //HEI.10>>
        if (xRec."Location Code" <> "Location Code") and (CurrFieldNo <> 0) then begin
          ValidateAstroProdOrderLineModification;
        end;
        //HEI.10<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Shortcut Dimension 1 Code"(Field 21).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
        //HEI.10>>
        if (xRec."Shortcut Dimension 1 Code" <> "Shortcut Dimension 1 Code") and (CurrFieldNo <> 0) then begin
          ValidateAstroProdOrderLineModification;
        end;
        //HEI.10<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Shortcut Dimension 2 Code"(Field 22).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
        //HEI.10>>
        if (xRec."Shortcut Dimension 2 Code" <> "Shortcut Dimension 2 Code") and (CurrFieldNo <> 0) then begin
          ValidateAstroProdOrderLineModification;
        end;
        //HEI.10<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Bin Code"(Field 23).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if Quantity < 0 then
          BinCode := WMSManagement.BinContentLookUp("Location Code","Item No.","Variant Code",'',"Bin Code")
        else
          BinCode := WMSManagement.BinLookUp("Location Code","Item No.","Variant Code",'');

        if BinCode <> '' then
          VALIDATE("Bin Code",BinCode);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if Quantity < 0 then
          //HEI.01 PRDGAP024 delete BinCode := WMSManagement.BinContentLookUp("Location Code","Item No.","Variant Code",'',"Bin Code")
          BinCode := WMSManagement.BinContentLookUp("Location Code","Item No.","Variant Code","Zone Code","Bin Code")//HEI.01 PRDGAP024 SINGLE
        else
          //HEI.01 PRDGAP024 delete BinCode := WMSManagement.BinLookUp("Location Code","Item No.","Variant Code",'');
          BinCode := WMSManagement.BinLookUp("Location Code","Item No.","Variant Code","Zone Code");//HEI.01 PRDGAP024 SINGLE
        #5..7
        */
        //end;


        //Unsupported feature: CodeModification on ""Bin Code"(Field 23).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Bin Code" <> '' then begin
          if Quantity < 0 then
            WMSManagement.FindBinContent("Location Code","Bin Code","Item No.","Variant Code",'')
        #4..8
            "Bin Code",0);
          CheckBin;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..11

        //HEI.09>>
        if CurrFieldNo <> 0 then begin
          InventorySetupL.GET;
          if InventorySetupL."CMG Code for Empty Bin" <> '' then begin
            if ("Bin Code" <> '') and BinL.GET("Location Code","Bin Code") and (not BinL.Empty) then begin
              DefaultDimensionL.SETCURRENTKEY("Table ID","No.","Dimension Code","Dimension Value Code");
              DefaultDimensionL.SETRANGE("Table ID",DATABASE::Item);
              DefaultDimensionL.SETRANGE("No.","Item No.");
              DefaultDimensionL.SETRANGE("Dimension Code",'CMG');
              DefaultDimensionL.SETFILTER("Dimension Value Code",InventorySetupL."CMG Code for Empty Bin");
              if DefaultDimensionL.FINDFIRST then begin
                if not CONFIRM(Text000L,false,"Bin Code") then
                  ERROR('');
              end;
            end;
          end;
          //HEI.10>>
          if xRec."Bin Code" <> "Bin Code" then begin
            ValidateAstroProdOrderLineModification;
          end;
          //HEI.10<<
        end;
        //HEI.09<<
        */
        //end;


        //Unsupported feature: CodeModification on "Quantity(Field 40).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "Quantity (Base)" := Quantity * "Qty. per Unit of Measure";
        "Remaining Quantity" := Quantity - "Finished Quantity";
        if "Remaining Quantity" < 0 then
          "Remaining Quantity" := 0;
        "Remaining Qty. (Base)" := "Remaining Quantity" * "Qty. per Unit of Measure";
        ReserveProdOrderLine.VerifyQuantity(Rec,xRec);
        WhseValidateSourceLine.ProdOrderLineVerifyChange(Rec,xRec);

        UpdateProdOrderComp(xRec."Qty. per Unit of Measure");

        if CurrFieldNo <> 0 then
          VALIDATE("Ending Time");
        "Cost Amount" := ROUND(Quantity * "Unit Cost");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..7
        // <<DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008
        if "Refresh Components" then
        // >>DITW15.00.00.22 PRODW14.00.00.08 DDR
          UpdateProdOrderComp(xRec."Qty. per Unit of Measure");
        #10..13

        // <<DITW19.00.08 DDR 17/08/2016 20/10/2016 BL#10443
        if BeverageSetup.READPERMISSION then
          "Quantity (Brewing Base)" := ROUND(Quantity * "Unit Volume HL",0.00001);
        // >>DITW19.00.08 DDR BL#10443
        //HEI.10>>
        if (xRec.Quantity <> Quantity) and (CurrFieldNo <> 0) then begin
          ValidateAstroProdOrderLineModification;
        end;
        //HEI.10<<
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Scrap %"(Field 45)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //HEI.10>>
        if (xRec."Scrap %" <> "Scrap %") and (CurrFieldNo <> 0) then begin
          ValidateAstroProdOrderLineModification;
        end;
        //HEI.10<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Starting Date"(Field 48).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Ending Date" < "Starting Date" then
          "Ending Date" := "Starting Date";

        VALIDATE("Starting Time");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        //HEI.10>>
        if (xRec."Starting Date" <> "Starting Date") and (CurrFieldNo <> 0) then begin
          ValidateAstroProdOrderLineModification;
        end;
        //HEI.10<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Starting Time"(Field 49).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ProdOrderLine.GET(Status,"Prod. Order No.","Line No.") then begin
          MODIFY;

        #4..8
          VALIDATE("Due Date");

        UpdateDatetime;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..11
        //HEI.10>>
        if (xRec."Starting Time" <> "Starting Time") and (CurrFieldNo <> 0) then begin
          ValidateAstroProdOrderLineModification;
        end;
        //HEI.10<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Ending Date"(Field 50).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VALIDATE("Ending Time");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        VALIDATE("Ending Time");
        //HEI.10>>
        if (xRec."Ending Date" <> "Ending Date") and (CurrFieldNo <> 0) then begin
          ValidateAstroProdOrderLineModification;
        end;
        //HEI.10<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Ending Time"(Field 51).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ProdOrderLine.GET(Status,"Prod. Order No.","Line No.") then begin
          MODIFY;

        #4..8
          VALIDATE("Due Date");

        UpdateDatetime;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..11
        //HEI.10>>
        if (xRec."Ending Time" <> "Ending Time") and (CurrFieldNo <> 0) then begin
          ValidateAstroProdOrderLineModification;
        end;
        //HEI.10<<
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Production BOM No."(Field 60).OnValidate". Please convert manually.

        //trigger (Variable: CapLedgEntry)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Production BOM No."(Field 60).OnValidate". Please convert manually.

        //trigger "(Field 60)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "Production BOM Version Code" := '';
        if "Production BOM No." = '' then
          exit;

        VALIDATE("Production BOM Version Code",VersionMgt.GetBOMVersion("Production BOM No.","Due Date",true));
        if "Production BOM Version Code" = '' then begin
          ProdBOMHeader.GET("Production BOM No.");
          ProdBOMHeader.TESTFIELD(Status,ProdBOMHeader.Status::Certified);
          VALIDATE("Unit of Measure Code",ProdBOMHeader."Unit of Measure Code");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        "Production BOM Version Code" := '';
        //<< DITW111.00.13 MZOU 07/11/2018 NRQ#91446
        if "Production BOM No." <> xRec."Production BOM No." then begin
          if Status = Status::Released then begin
            if CheckCapLedgEntry then
              ERROR(
                Text99000004Err,
                FIELDCAPTION("Production BOM No."),xRec."Production BOM No.",CapLedgEntry.TABLECAPTION);
          end;
        end;
        //>> DITW111.00.13 MZOU NRQ#91446
        if "Production BOM No." = '' then
          exit;
        //HEI.06>>
        //HEI.08>>
        if "Production BOM Version Code" = '' then begin
          ProdBOMVersion := VersionManagement.GetBOMVersion("Production BOM No.",WORKDATE,true);
          VALIDATE("Production BOM Version Code",ProdBOMVersion);
        end;
          //VALIDATE("Production BOM Version Code",DefProdBOMVersion);
        //HEI.08<<
        //HEI.06<<

        //VALIDATE("Production BOM Version Code",VersionMgt.GetBOMVersion("Production BOM No.","Due Date",TRUE));//HEI.02
        #6..10
        //HEI.10>>
        if (xRec."Production BOM No." <> "Production BOM No.") and (CurrFieldNo <> 0) then begin
          ValidateAstroProdOrderLineModification;
        end;
        //HEI.10<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Routing No."(Field 61).OnValidate". Please convert manually.

        //trigger "(Field 61)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "Routing Version Code" := '';

        if "Routing No." <> xRec."Routing No." then begin
          if Status = Status::Released then begin
            if CheckCapLedgEntry then
              ERROR(
        #7..10
              ERROR(
                Text99000004Err,
                FIELDCAPTION("Routing No."),xRec."Routing No.",PurchLine.TABLECAPTION);
          end;

          ProdOrderRtngLine.SETRANGE(Status,Status);
        #17..21
        if "Routing No." = '' then
          exit;

        VALIDATE("Routing Version Code",VersionMgt.GetRtngVersion("Routing No.","Due Date",true));
        if "Routing Version Code" = '' then begin
          RtngHeader.GET("Routing No.");
          RtngHeader.TESTFIELD(Status,RtngHeader.Status::Certified);
          "Routing Type" := RtngHeader.Type;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //"Routing Version Code" := '';//HEI.02>>

        if "Routing No." <> xRec."Routing No." then begin
          //HEI.02>>
          //VALIDATE("Routing Version Code",VersionMgt.GetRtngVersion("Routing No.","Due Date",TRUE));
          //HEI.02<<
        #4..13


        #14..24
        if "Routing Version Code" = '' then begin
          //HEI.08>>
          RoutingVersion := VersionManagement.GetRtngVersion("Routing No.",WORKDATE,true);
          VALIDATE("Routing Version Code",RoutingVersion);
          //VALIDATE("Routing Version Code",DefProdBOMVersion);//HEI.06
          //HEI.08<<
        #27..30
        //HEI.07>>
        if "Bin Code" = '' then
            GetDefaultBin;
        //HEI.07<<
        //HEI.10>>
        if (xRec."Routing No." <> "Routing No.") and (CurrFieldNo <> 0) then begin
          ValidateAstroProdOrderLineModification;
        end;
        //HEI.10<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit Cost"(Field 65).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Item No.");
        GetItem;
        Item.TESTFIELD("Inventory Value Zero",false);
        #4..13
        end;

        "Cost Amount" := ROUND(Quantity * "Unit Cost");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..16
        //HEI.10>>
        if (xRec."Unit Cost" <> "Unit Cost") and (CurrFieldNo <> 0) then begin
          ValidateAstroProdOrderLineModification;
        end;
        //HEI.10<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit of Measure Code"(Field 80).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetItem;
        GetGLSetup;
        WhseValidateSourceLine.ProdOrderLineVerifyChange(Rec,xRec);
        "Unit Cost" := Item."Unit Cost";

        "Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");

        "Unit Cost" :=
          ROUND(Item."Unit Cost" * "Qty. per Unit of Measure",
            GLSetup."Unit-Amount Rounding Precision");
        "Overhead Rate" :=
          ROUND(
            Item."Overhead Rate" * "Qty. per Unit of Measure",
            GLSetup."Unit-Amount Rounding Precision");

        VALIDATE(Quantity);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        "Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");
        //<<  DITW18.00.07 VSC 14/01/2016 DIT-770 #1668
        if GetSKU then begin
          "Unit Cost" :=
            ROUND(SKU."Unit Cost" * "Qty. per Unit of Measure",
              GLSetup."Unit-Amount Rounding Precision");
        end else begin
        #8..10
        end;
        //>> DITW18.00.07 VSC DIT-770 #1668

        //<<DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
        if GetSKU then
          "Overhead Rate" :=
            ROUND(
              SKU."Overhead Rate" * "Qty. per Unit of Measure",
              GLSetup."Unit-Amount Rounding Precision")
        else
        //>>DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
        #11..15
        // <<DITW19.00.08 DDR 17/08/2016 20/2016 BL#10443
        "Unit Volume HL" := Item."Unit Volume HL" * "Qty. per Unit of Measure";
        // >>DITW19.00.08 DDR BL#10443

        VALIDATE(Quantity);
        //HEI.10>>
        if (xRec."Unit of Measure Code" <> "Unit of Measure Code") and (CurrFieldNo <> 0) then begin
          ValidateAstroProdOrderLineModification;
        end;
        //HEI.10<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Starting Date-Time"(Field 198).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "Starting Date" := DT2DATE("Starting Date-Time");
        "Starting Time" := DT2TIME("Starting Date-Time");
        VALIDATE("Starting Time");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        //HEI.10>>
        if (xRec."Starting Date-Time" <> "Starting Date-Time") and (CurrFieldNo <> 0) then begin
          ValidateAstroProdOrderLineModification;
        end;
        //HEI.10<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Ending Date-Time"(Field 199).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "Ending Date" := DT2DATE("Ending Date-Time");
        "Ending Time" := DT2TIME("Ending Date-Time");
        VALIDATE("Ending Time");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        //HEI.10>>
        if (xRec."Ending Date-Time" <> "Ending Date-Time") and (CurrFieldNo <> 0) then begin
          ValidateAstroProdOrderLineModification;
        end;
        //HEI.10<<
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Production BOM Version Code"(Field 99000750).OnValidate". Please convert manually.

        //trigger (Variable: CapLedgEntry)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Production BOM Version Code"(Field 99000750).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Production BOM Version Code" = '' then
          exit;

        ProdBOMVersion.GET("Production BOM No.","Production BOM Version Code");
        ProdBOMVersion.TESTFIELD(Status,ProdBOMVersion.Status::Certified);
        VALIDATE("Unit of Measure Code",ProdBOMVersion."Unit of Measure Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW111.00.13 MZOU 07/11/2018 NRQ#91446
        if "Production BOM Version Code" <> xRec."Production BOM Version Code" then begin
          if Status = Status::Released then begin
            if CheckCapLedgEntry then
              ERROR(
                Text99000004Err,
                FIELDCAPTION("Production BOM Version Code"),xRec."Production BOM Version Code",CapLedgEntry.TABLECAPTION);
          end;
        end;
        //>> DITW111.00.13 MZOU NRQ#91446
        #1..5
        //<< DITW110.00.12 AKH 21/03/2018 NRQ#64704
        //VALIDATE("Unit of Measure Code",ProdBOMVersion."Unit of Measure Code");
        //>> DITW110.00.12 AKH NRQ#64704
        //HEI.10>>
        if (xRec."Production BOM Version Code" <> "Production BOM Version Code") and (CurrFieldNo <> 0) then begin
          ValidateAstroProdOrderLineModification;
        end;
        //HEI.10<<
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Routing Version Code"(Field 99000751).OnValidate". Please convert manually.

        //trigger (Variable: CapLedgEntry)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Routing Version Code"(Field 99000751).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Routing Version Code" = '' then
          exit;

        RtngVersion.GET("Routing No.","Routing Version Code");
        RtngVersion.TESTFIELD(Status,RtngVersion.Status::Certified);
        "Routing Type" := RtngVersion.Type;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW111.00.13 MZOU 07/11/2018 NRQ#91446
        if "Routing Version Code" <> xRec."Routing Version Code" then begin
          if Status = Status::Released then begin
            if CheckCapLedgEntry then
              ERROR(
                Text99000004Err,
                FIELDCAPTION("Routing Version Code"),xRec."Routing Version Code",CapLedgEntry.TABLECAPTION);
          end;
        end;
        //>> DITW111.00.13 MZOU NRQ#91446
        #1..6
        //HEI.10>>
        if (xRec."Routing Version Code" <> "Routing Version Code") and (CurrFieldNo <> 0) then begin
          ValidateAstroProdOrderLineModification;
        end;
        //HEI.10<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Planning Flexibility"(Field 99000755).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Planning Flexibility" <> xRec."Planning Flexibility" then
          ReserveProdOrderLine.UpdatePlanningFlexibility(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Planning Flexibility" <> xRec."Planning Flexibility" then
          ReserveProdOrderLine.UpdatePlanningFlexibility(Rec);
        //HEI.10>>
        if (xRec."Planning Flexibility" <> "Planning Flexibility") and (CurrFieldNo <> 0) then begin
          ValidateAstroProdOrderLineModification;
        end;
        //HEI.10<<
        */
        //end;
        field(50000; "Zone Code FND"; Code[10])
        {
            Caption = 'Zone Code';
            Description = 'HEI.01 PRDGAP024';
            TableRelation = Zone.Code where("Location Code" = FIELD("Location Code"),
                                             "Use As In-Transit FND" = FILTER(false));

            trigger OnValidate();
            begin
                //HEI.01 PRDGAP024>>
                if "Zone Code FND" <> '' then begin
                    WHSUTILS.CheckUserAuthorizedinZone("Location Code", "Zone Code FND");
                    VALIDATE("Bin Code", '');
                end;
                //HEI.01 PRDGAP024<<
                // BCUPGRADE YADAV09 Astro Function Commented>>
                //HEI.10>>
                // if (xRec."Zone Code" <> "Zone Code") and (CurrFieldNo <> 0) then begin
                //     ValidateAstroProdOrderLineModification;//BCUpgrade YADAVM09
                // end;
                //HEI.10<<
                // BCUPGRADE YADAV09 Astro Function Commented>>
            end;
        }
        /* //BCUPGRADE YADAVM09 Drink it field Commented>>
        field(2013716;"Strength Spec. Code";Code[20])
        {
            CaptionClass = GetTaxSpecCaption(0,FIELDNO("Strength Spec. Code"));
            CaptionML = ENU='Strength Spec. Code',
                        FRA='Code contrainte spécification taxe';
            Description = 'DITW19.00.08 BL#10443';
            TableRelation = "Tax Specification" WHERE (Type=CONST(Specification));

            trigger OnValidate();
            begin
                //HEI.10>>
                if (xRec."Strength Spec. Code" <> "Strength Spec. Code") and (CurrFieldNo <> 0) then begin
                  ValidateAstroProdOrderLineModification;
                end;
                //HEI.10<<
            end;
        }
        field(2013717;"Strength Spec. Value";Decimal)
        {
            AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Strength Spec. Value"));
            AutoFormatType = 2013664;
            CalcFormula = Average("Reservation Entry"."Strength Spec. Value" WHERE ("Source Type"=CONST(5406),
                                                                                    "Source Subtype"=FIELD(Status),
                                                                                    "Source ID"=FIELD("Prod. Order No."),
                                                                                    "Source Batch Name"=CONST(''),
                                                                                    "Source Prod. Order Line"=FIELD("Line No."),
                                                                                    "Source Ref. No."=CONST(0)));
            CaptionClass = GetTaxSpecCaption(1,FIELDNO("Strength Spec. Value"));
            CaptionML = ENU='Strength Spec. Value',
                        FRA='Valeur contrainte spécification';
            Description = 'DITW19.00.08 BL#10443';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2013718;"Vol-Strength Spec. Code";Code[20])
        {
            CaptionClass = GetTaxSpecCaption(0,FIELDNO("Vol-Strength Spec. Code"));
            CaptionML = ENU='Vol-Strength Spec. Code',
                        FRA='Code spécification contrainte volume';
            Description = 'DITW19.00.08 BL#10443';
            TableRelation = "Tax Specification" WHERE (Type=CONST(Specification));

            trigger OnValidate();
            begin
                //HEI.10>>
                if (xRec."Vol-Strength Spec. Code" <> "Vol-Strength Spec. Code") and (CurrFieldNo <> 0) then begin
                  ValidateAstroProdOrderLineModification;
                end;
                //HEI.10<<
            end;
        }
        field(2013719;"Vol-Strength Spec. Value";Decimal)
        {
            AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Vol-Strength Spec. Value"));
            AutoFormatType = 2013664;
            CalcFormula = Sum("Reservation Entry"."Vol-Strength Spec. Value" WHERE ("Source Type"=CONST(5406),
                                                                                    "Source Subtype"=FIELD(Status),
                                                                                    "Source ID"=FIELD("Prod. Order No."),
                                                                                    "Source Batch Name"=CONST(''),
                                                                                    "Source Prod. Order Line"=FIELD("Line No."),
                                                                                    "Source Ref. No."=CONST(0)));
            CaptionClass = GetTaxSpecCaption(1,FIELDNO("Vol-Strength Spec. Value"));
            CaptionML = ENU='Vol-Strength Spec. Value',
                        FRA='Valeur spécification contrainte volume';
            Description = 'DITW19.00.08 BL#10443';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2013767;"Unit Volume HL";Decimal)
        {
            CaptionClass = GetUomCaptionClass(FIELDNO("Unit Volume HL"));
            CaptionML = ENU='Unit Volume',
                        FRA='Volume unitaire';
            DecimalPlaces = 0:5;
            Description = 'DITW19.00.08 BL#10443';
            MinValue = 0;

            trigger OnValidate();
            begin
                //HEI.10>>
                if (xRec."Unit Volume HL" <> "Unit Volume HL") and (CurrFieldNo <> 0) then begin
                  ValidateAstroProdOrderLineModification;
                end;
                //HEI.10<<
            end;
        }
        field(2014410;"Responsibility Center";Code[10])
        {
            CaptionML = ENU='Responsibility Center',
                        FRA='Centre de gestion';
            Description = 'DITW18.00.06 MSF 26/02/2015 DIT-770 #1192';
            TableRelation = "Responsibility Center" WHERE (Code=FIELD("Resp. Center Table Filter"));

            trigger OnValidate();
            var
                LocationCode : Code[20];
            begin
                // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
                if not UserSetupMgt.CheckRespCenter(3,"Responsibility Center") then
                  ERROR(
                    Text2014410,
                    RespCenter.TABLECAPTION,UserSetupMgt.GetProductionFilter);

                if (CurrFieldNo <> FIELDNO("Location Code")) and
                  (CurrFieldNo <> FIELDNO("Physical Location Group Code")) and
                  (xRec."Physical Location Group Code" = "Physical Location Group Code") and
                  (xRec."Location Code" = "Location Code")
                then begin
                    SETRANGE("Phys. Location Table Filter");
                    SETRANGE("Location Table Filter");
                    VALIDATE("Physical Location Group Code", UserSetupMgt.GetphysicalLocation(3,'',"Responsibility Center"));
                    LocationCode := UserSetupMgt.GetLocation(3,'',"Responsibility Center");
                    if (LocationCode <> '') or ("Physical Location Group Code" = '') then
                      VALIDATE("Location Code", LocationCode);
                end;
                //<<DITW18.00.06 AKH 04/03/2015 DIT-770 #1197
                CreateDim(DATABASE::"Responsibility Center", "Responsibility Center",
                DATABASE::Item,"Item No.");
                //>>DITW18.00.06 AKH 04/03/2015 DIT-770 #1197
                // >>DITW18.00.06 MSF DIT-770 #1192
                //HEI.10>>
                if (xRec."Responsibility Center" <> "Responsibility Center") and (CurrFieldNo <> 0) then begin
                  ValidateAstroProdOrderLineModification;
                end;
                //HEI.10<<
            end;
        }
        field(2014411;"Physical Location Group Code";Code[10])
        {
            CaptionML = ENU='Physical Location Group Code',
                        FRA='Code groupe magasin réel';
            Description = 'DITW18.00.06 MSF 26/02/2015 DIT-770 #1192';
            TableRelation = "Physical Location Group" WHERE (Code=FIELD("Phys. Location Table Filter"));

            trigger OnValidate();
            begin
                // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
                if ("Responsibility Center" = xRec."Responsibility Center") and
                  ("Physical Location Group Code" <> xRec."Physical Location Group Code") and
                  ("Physical Location Group Code" <> '')
                then
                  VALIDATE("Responsibility Center",UserSetupMgt.GetFirstRespCenter(3,"Physical Location Group Code",''));

                if not UserSetupMgt.CheckPhysLocation(3,"Physical Location Group Code","Responsibility Center") then
                  ERROR(
                    Text2014412,
                    PhysLocationGr.TABLECAPTION,"Physical Location Group Code",
                    RespCenter.TABLECAPTION,UserSetupMgt.GetProductionFilter);

                if (xRec."Physical Location Group Code" <> "Physical Location Group Code") then begin
                  CLEAR(Location);
                  if "Location Code" <> '' then
                    Location.GET("Location Code");
                  if (Location."Physical Location Group Code" <> "Physical Location Group Code") then begin
                    if ((CurrFieldNo <> FIELDNO("Location Code")) and (xRec."Responsibility Center" = "Responsibility Center")) then
                      VALIDATE("Location Code",'')
                    else
                      "Location Code" := '';
                  end;
                end;
                // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
                //HEI.10>>
                if (xRec."Physical Location Group Code" <> "Physical Location Group Code") and (CurrFieldNo <> 0) then begin
                  ValidateAstroProdOrderLineModification;
                end;
                //HEI.10<<
            end;
        }
        field(2014412;"Resp. Center Table Filter";Code[10])
        {
            CaptionML = ENU='Resp. Center Table Filter',
                        FRA='Filtre Centre de gestion (table)';
            Description = 'DITW18.00.06 MSF 26/02/2015 DIT-770 #1192';
            FieldClass = FlowFilter;
            TableRelation = "Responsibility Center";
        }
        field(2014413;"Phys. Location Table Filter";Code[10])
        {
            CaptionML = ENU='Phys. Location Table Filter',
                        FRA='Filtre groupe magasin réel (table)';
            Description = 'DITW18.00.06 MSF 26/02/2015 DIT-770 #1192';
            FieldClass = FlowFilter;
            TableRelation = "Physical Location Group";
        }
        field(2014414;"Location Table Filter";Code[10])
        {
            CaptionML = ENU='Location Table Filter',
                        FRA='Filtre Magasin (table)';
            Description = 'DITW18.00.06 MSF 26/02/2015 DIT-770 #1192';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(2029610;"Cross-Reference No.";Code[20])
        {
            CaptionML = ENU='Cross-Reference No.',
                        FRA='Référence externe';
            Description = 'FINXL8.00.001';

            trigger OnLookup();
            begin
                //<<FINXL8.00.001 BSA 02/06/2015 #178
                if recFinXLSetup.READPERMISSION then fctLookupCrossReference();
                //>>FINXL8.00.001 BSA 02/06/2015 #178
            end;

            trigger OnValidate();
            begin
                //<<FINXL8.00.001 BSA 02/06/2015 #178
                if recFinXLSetup.READPERMISSION then fctValidateCrossReference;
                //>>FINXL8.00.001 BSA 02/06/2015 #178
            end;
        }
        field(2029611;"Emergency Order";Boolean)
        {
            CaptionML = ENU='Emergency',
                        FRA='Urgence';
            Description = 'FINXL8.00.001';

            trigger OnValidate();
            begin
                //HEI.10>>
                if (xRec."Emergency Order" <> "Emergency Order") and (CurrFieldNo <> 0) then begin
                  ValidateAstroProdOrderLineModification;
                end;
                //HEI.10<<
            end;
        }
        field(2035090;"No. of Quality Tests";Integer)
        {
            CalcFormula = Count("Quality Test Header" WHERE ("Document Type"=CONST("Lot/SN Test"),
                                                             "Source Type"=CONST(5406),
                                                             "Source Subtype"=FIELD(Status),
                                                             "Source ID"=FIELD("Prod. Order No."),
                                                             "Source Prod. Order Line"=FIELD("Line No."),
                                                             "Item No."=FIELD("Item No.")));
            CaptionML = ENU='No. of Quality Tests',
                        FRA='<Nbre de Tests Qualité>';
            Description = 'QXL9.00.001';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2035091;"Operations Completed";Boolean)
        {
            CaptionML = ENU='Operations Completed',
                        FRA='Opérations effectuées';
            Description = 'QXL9.00.001';
            Editable = false;
        }
        field(2035166;"_Product Group Code";Code[20])
        {
            CaptionML = ENU='Product Group Code',
                        FRA='Code groupe produits';
            Description = 'DITW15.00.00.22 PRODW14.00.00.08';
            Enabled = false;
            TableRelation = IF ("Item No."=FILTER(<>'')) "Product Group".Code WHERE ("Item Category Code"=FIELD("Item Category Code"));
        }
        field(2035179;"Last Operation Output";Boolean)
        {
            CaptionML = ENU='Last Operation Output',
                        FRA='Dernière opération produite';
            Description = 'DITW15.00.00.22 PRODW14.00.00.08';
            Editable = false;
        }
        field(2035208;"_Item Category Code";Code[10])
        {
            CaptionML = ENU='Item Category Code',
                        FRA='Code catégorie article';
            Description = 'DITW15.00.00.39 PRODW14.00.00.08.18 #1372';
            Enabled = false;
            TableRelation = IF ("Item No."=FILTER(<>'')) "Item Category".Code;

            trigger OnValidate();
            var
                ProductGrp : Record "Product Group";
            begin
                // <<DITW15.00.00.38 PRODW14.00.00.08.18 DDR 25/08/2011
                if "Item Category Code" <> xRec."Item Category Code" then begin
                  if not ProductGrp.GET("Item Category Code","_Product Group Code") then
                    VALIDATE("_Product Group Code",'')
                  else
                    VALIDATE("_Product Group Code");
                end;
            end;
        }
        field(2035240;"Planning Colour";Code[11])
        {
            CaptionML = ENU='Planning Colour',
                        FRA='Couleur Planning';
            Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        }
        field(2035242;"Quantity (Brewing Base)";Decimal)
        {
            CaptionClass = GetQtyCaptionClass(FIELDNO("Quantity (Brewing Base)"),5);
            CaptionML = ENU='Quantity (Brewing Base)',
                        FRA='Quantité (Base Prod. Brasserie)';
            DecimalPlaces = 0:5;
            Description = 'DITW15.00.00.22 PRODW14.00.00.08 - DITW19.00.08 BL#10443';

            trigger OnValidate();
            begin
                //HEI.10>>
                if (xRec."Quantity (Brewing Base)" <> "Quantity (Brewing Base)") and (CurrFieldNo <> 0) then begin
                  ValidateAstroProdOrderLineModification;
                end;
                //HEI.10<<
            end;
        }
        field(2035252;"Calculation Required";Boolean)
        {
            CalcFormula = Exist("Prod. Order Component" WHERE (Status=FIELD(Status),
                                                               "Prod. Order No."=FIELD("Prod. Order No."),
                                                               "Prod. Order Line No."=FIELD("Line No."),
                                                               "Calculation Required"=CONST(true)));
            CaptionML = ENU='Calculation Required',
                        FRA='Calcul nécessaire';
            Description = 'DITW15.00.00.22 PRODW14.00.00.08';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2035253;"Calculation Completed";Boolean)
        {
            CaptionML = ENU='Calculation Completed',
                        FRA='Calcul effectué';
            Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        }
        field(2035255;"Refresh Components";Boolean)
        {
            CaptionML = ENU='Refresh Components',
                        FRA='Rafraîchir composants';
            Description = 'DITW15.00.00.22 PRODW14.00.00.08';
            InitValue = true;
        }
        field(2035257;"Quantity Output";Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE ("Entry Type"=CONST(Output),
                                                                  "Order No."=FIELD("Prod. Order No."),
                                                                  "Order Line No."=FIELD("Line No.")));
            CaptionML = ENU='Quantity Output',
                        FRA='Quantité produite';
            DecimalPlaces = 0:5;
            Description = 'DITW15.00.00.22 PRODW14.00.00.08';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2035258;"Quantity Output (Brewing Base)";Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Quantity in HL" WHERE ("Order No."=FIELD("Prod. Order No."),
                                                                          "Order Line No."=FIELD("Line No."),
                                                                          "Entry Type"=CONST(Output)));
            CaptionML = ENU='Output Quantity (Brewing Base)',
                        FRA='Qté Production (Base Prod. Brasserie)';
            DecimalPlaces = 0:5;
            Description = 'DITW15.00.00.22 PRODW14.00.00.08';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2035259;"Quantity Output (Degrees)";Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Vol-Strength Spec. Value" WHERE ("Order No."=FIELD("Prod. Order No."),
                                                                                    "Order Line No."=FIELD("Line No."),
                                                                                    "Entry Type"=CONST(Output)));
            CaptionML = ENU='Output Quantity (Degrees)',
                        FRA='Quantité Production (Degr.)';
            Description = 'DITW15.00.00.22 PRODW14.00.00.08';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2036308;"Item Category Code";Code[20])
        {
            CaptionML = ENU='Item Category Code',
                        FRA='Code catégorie article';
            Description = 'MANXL7.00.001';
            Editable = false;
            TableRelation = "Item Category";

            trigger OnValidate();
            var
                ProductGrp : Record "Product Group";
            begin
                // <<DITW15.00.00.38 PRODW14.00.00.08.18 DDR 25/08/2011
                if "Item Category Code" <> xRec."Item Category Code" then begin
                  if not ProductGrp.GET("Item Category Code","_Product Group Code") then
                    VALIDATE("_Product Group Code",'')
                  else
                    VALIDATE("_Product Group Code");
                end;
            end;
        }
        field(2036309;"Item Product Group Code";Code[10])
        {
            CaptionML = ENU='Item Product Group Code',
                        FRA='Code groupe produits article';
            Description = 'MANXL7.00.001';
            Editable = false;
            TableRelation = "Product Group".Code WHERE ("Item Category Code"=FIELD("Item Category Code"));
        }
        field(2036310;"Planning Group";Code[10])
        {
            CaptionML = ENU='Planning Group',
                        FRA='Groupe de planification';
            Description = 'MANXL7.00.001';
            Editable = false;
        }
        field(2036311;"Production Group";Code[10])
        {
            CaptionML = ENU='Production Group',
                        FRA='Groupe de production';
            Description = 'MANXL7.00.001';
            Editable = false;
        }
        field(2036312;"Revision No.";Code[10])
        {
            CaptionML = ENU='Revision No.',
                        FRA='N° révision';
            Description = 'MANXL7.00.001';
            TableRelation = "Item Minor Revision"."Revision No." WHERE ("Item No."=FIELD("Item No."));

            trigger OnValidate();
            begin
                //HEI.10>>
                if (xRec."Revision No." <> "Revision No.") and (CurrFieldNo <> 0) then begin
                  ValidateAstroProdOrderLineModification;
                end;
                //HEI.10<<
            end;
        }
        field(2036313;"Requester ID";Code[50])
        {
            CaptionML = ENU='Requester ID',
                        FRA='ID demandeur';
            Description = 'MANXL7.00.001';
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup();
            var
                LoginMgt : Codeunit "User Management";
            begin
                //<<MANXL7.00.001 DAT 05/03/2014 #18
                CLEAR(cduLoginMgmt);
                cduLoginMgmt.LookupUserID("Requester ID");
                //>>MANXL7.00.001 DAT 05/03/2014 #18
            end;

            trigger OnValidate();
            var
                LoginMgt : Codeunit "User Management";
            begin
                //<<MANXL7.00.001 DAT 05/03/2014 #18
                CLEAR(cduLoginMgmt);
                cduLoginMgmt.ValidateUserID("Requester ID");
                //>>MANXL7.00.001 DAT 05/03/2014 #18
                //HEI.10>>
                if (xRec."Requester ID" <> "Requester ID") and (CurrFieldNo <> 0) then begin
                  ValidateAstroProdOrderLineModification;
                end;
                //HEI.10<<
            end;
        }
        */ //BCUPGRADE YADAVM09 Drink it field Commented<<
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if Status = Status::Finished then
      ERROR(Text000,Status,TABLECAPTION);

    #4..21
    end;

    ReserveProdOrderLine.DeleteLine(Rec);

    CALCFIELDS("Reserved Qty. (Base)");
    TESTFIELD("Reserved Qty. (Base)",0);
    WhseValidateSourceLine.ProdOrderLineDelete(Rec);

    DeleteRelations;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..24
    // <<QXL9.00.001 DAT 23/03/2016
    if rQualitySetup.READPERMISSION then
      cduQualityMgt.DeleteProdOrderLine(Rec);
    // >>QXL9.00.001 DAT 23/03/2016
    #25..30
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if Status = Status::Finished then
      ERROR(Text000,Status,TABLECAPTION);

    ReserveProdOrderLine.VerifyQuantity(Rec,xRec);
    if "Routing Reference No." < 0 then
      "Routing Reference No." := "Line No.";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    //<<MANXL7.00.001 WSA 11/07/2014 #87
    if rMANXLSetup.READPERMISSION then
    //>>MANXL7.00.001 WSA 11/07/2014 #87
      //<<MANXL7.00.001 DAT 03/03/2014 #10
      if ProdOrder.GET(Status,"Prod. Order No.") then begin
        "Planning Group":= ProdOrder."Planning Group";
        "Production Group":= ProdOrder."Production Group";
        "Item Category Code":= ProdOrder."Item Category Code";
        "Item Product Group Code":= ProdOrder."Item Product Group Code";
      end;
      //>>MANXL7.00.001 DAT 03/03/2014 #10
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnModify". Please convert manually.

    //trigger (Variable: ProdOrd)();
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
    if Status = Status::Finished then
      ERROR(Text000,Status,TABLECAPTION);

    ReserveProdOrderLine.VerifyChange(Rec,xRec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    //HEI.01>>
    if Status in [Status::"Firm Planned",Status::Released] then begin
      WHSUTILS.CheckUserAuthorizedinZone("Location Code",xRec."Zone Code");
      WHSUTILS.CheckUserAuthorizedinZone("Location Code","Zone Code");
      if ProdOrd.GET(Status,"Prod. Order No.") then
        WHSUTILS.CheckUserAuthorizedinZone(ProdOrd."Location Code",ProdOrd."Zone Code");
    end;
    //HEI.01<<

    ReserveProdOrderLine.VerifyChange(Rec,xRec);
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
    trigger OnAfterModify()
    var
    begin
        //HEI.01>>
        IF Status IN [Status::"Firm Planned", Status::Released] THEN BEGIN
            WHSUTILS.CheckUserAuthorizedinZone("Location Code", xRec."Zone Code FND");
            WHSUTILS.CheckUserAuthorizedinZone("Location Code", "Zone Code FND");
            IF ProdOrd.GET(Status, "Prod. Order No.") THEN
                WHSUTILS.CheckUserAuthorizedinZone(ProdOrd."Location Code", ProdOrd."Zone Code FND");
        end;
        //HEI.01<<

    end;
    // BCUPGRADE YADAVM09>>
    local procedure GetLocation(LocationCode: Code[10])
    begin
        if LocationCode = '' then
            Clear(Location)
        else
            if Location.Code <> LocationCode then
                Location.Get(LocationCode);
    end;
    // BCUPGRADE YADAVM09<<
    var


        Bin: Record Bin;
        BinL: Record Bin;
        DefaultDimensionL: Record "Default Dimension";
        InventorySetupL: Record "Inventory Setup";
        Location: Record Location;


        //CapLedgEntry: Record "Capacity Ledger Entry";//BCUPgrade Manisha Object not used anywhere in the object
        //CapLedgEntry: Record "Capacity Ledger Entry";//BCUPgrade Manisha Object not used anywhere in the object
        ProdOrd: Record "Production Order";
        ProductionOrderL: Record "Production Order";


        // CapLedgEntry: Record "Capacity Ledger Entry";//BCUPgrade Manisha Object not used anywhere in the object
        ProdBOMVersion: Code[20];


        RoutingVersion: Code[20];
        Text000L: Label 'The Bin Code - %1 is not empty. Would you like to proceed?';


    //Unsupported feature: PropertyModification on "Text000(Variable 1034)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=A %1 %2 cannot be inserted, modified, or deleted.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=A %1 %2 cannot be inserted, modified, or deleted.;FRA=Un enregistrement %2 %1 ne peut pas être inséré, modifié ou supprimé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text99000000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text99000000 : @@@="%1 = Table Caption; %2 = Field Value; %3 = Table Caption";ENU=You cannot delete %1 %2 because there is at least one %3 associated with it.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text99000000 : @@@="%1 = Table Caption; %2 = Field Value; %3 = Table Caption";ENU=You cannot delete %1 %2 because there is at least one %3 associated with it.;FRA=Vous ne pouvez pas supprimer %1 %2 car il existe au moins un %3 qui lui est associé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text99000001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text99000001 : ENU=You cannot rename a %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text99000001 : ENU=You cannot rename a %1.;FRA=Vous ne pouvez pas renommer l'enregistrement %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text99000002(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text99000002 : ENU=You cannot change %1 when %2 is %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text99000002 : ENU=You cannot change %1 when %2 is %3.;FRA=Vous ne pouvez pas modifier %1 si %2 est %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text99000004Err(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text99000004Err : @@@="%1 = Field Caption; %2 = Field Value; %3 = Table Caption";ENU=You cannot modify %1 %2 because there is at least one %3 associated with it.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text99000004Err : @@@="%1 = Field Caption; %2 = Field Value; %3 = Table Caption";ENU=You cannot modify %1 %2 because there is at least one %3 associated with it.;FRA=Vous ne pouvez pas modifier %1 %2 car il existe au moins un %3 qui lui est associé.;
    //Variable type has not been exported.

    var
        //recFinXLSetup: Record "Finance XL Setup";//BCUPgrade Manisha Object not used anywhere in the object
        //BeverageSetup: Record "Production Setup";BCUPgrade Manisha Object not used anywhere in the object
        InvtSetup: Record "Inventory Setup";
        RespCenter: Record "Responsibility Center";
        //PhysLocationGr: Record "Physical Location Group";//BCUPGRADE YADAVM09 Object not used anywhere in the code
        cduLoginMgmt: Codeunit "User Management";
        UserSetupMgt: Codeunit "User Setup Management";
        VersionManagement: Codeunit VersionManagement;
        WHSUTILS: Codeunit "WHS-UTILS";
        //rMANXLSetup: Record "Manufacturing XL Setup";//BCUPgrade Manisha Object not used anywhere in the object
        blnValidateCrossRef: Boolean;
        DefProdBOMVersion: Label 'DEFAULT';
        Text020: TextConst ENU = 'A "%1" Production Order cannot be modified.', FRA = 'Un O.F. terminé ne peut pas être modifié.';
        Text2013763: TextConst ENU = 'If the item carries serial or lot numbers, then you must use the %1 field in the %2 window.', FRA = 'Si l''article porte des numéros de série ou de lot, alors vous devez utiliser le champ %1 dans la fenêtre %2.';
        Text2014410: TextConst ENU = 'Your identification is set up to process from %1 %2 only.', FRA = 'Le paramétrage de votre code utilisateur ne vous permet de travailler que sur %1 %2.';
        Text2014411: TextConst ENU = 'Do you want to insert the item charges for all lines?', FRA = 'Souhaitez-vous insérer les frais annexes pour toutes les lignes?';
        Text2014412: TextConst ENU = 'You cannot use the %1 %2 because your identification is set up to process from %3 %4 only.', FRA = 'Vous ne pouvez pas utiliser le %1 %2 parce que votre identification est mis en place pour traiter de %3 %4 seulement.';
        Text2014413: TextConst ENU = 'Your identification is set up to process from %1 %2 only.', FRA = 'Le paramétrage de votre code utilisateur ne vous permet de travailler que sur %1 %2.';
        Text2014414: TextConst ENU = 'You cannot use the %1 %2 because your identification is set up to process from %3 %4 only.', FRA = 'Vous ne pouvez pas utiliser le %1 %2 parce que votre identification est mis en place pour traiter de %3 %4 seulement.';

        //rQualitySetup: Record "Quality Setup";//BCUPGRADE YADAVM09 Variable not used anywhere in the code
        //cduQualityMgt: Codeunit "Quality Management";//BCUPGRADE YADAVM09 Variable not used anywhere in the code
        Text99000003: TextConst ENU = 'Change %1 from %2 to %3?', FRA = 'Remplacer %2 par %3 dans le champ %1 ?';
}

