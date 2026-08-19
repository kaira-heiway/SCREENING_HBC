tableextension 50114 ManufacturingSetupExtFND extends "Manufacturing Setup"
{
    // version NAVW110.0,MANXL10.01,DITW110.00.11,DITW110.00.12A,HEI.05,HEI.06,HEI.07

    //     DITW15.00.00.35 PRODW14.00.00.08.14 DDR 18/08/2009
    //                                issue 768 Added fields
    //                                  2035143 Editable Item Posting Groups
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM

    // MANXL7.00.001 DAT 24/02/2014 #1: Added field "Line Speed UOM"
    // MANXL7.00.001 DAT 26/02/2014 #6: Added fields "Blocked Location Code" and "Scrap Location Code"
    // MANXL7.00.001 DAT 03/03/2014 #12: Version Management
    // MANXL7.00.001 DAT 04/03/2014 #13: Prod. Order KPI's in overview screen

    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 VSC 13/04/2017 NRQ#18376 New Fields "Prod. Loss. Jnl. Template Name" and "Prod. Loss. Jnl. Batch Name"
    // DITW110.00.12A ISL 13/06/2018 NRQ#51789 Added new field 2036321 "Prod. Jnl. Flushing (Time)" (Boolean)

    //     HEI.01 FDD-BA-PRDGAP01_a IBM POSTOI01, 11.07.2018
    //   #add new field 50000 SP Item Category Filter  - Text 250
    //   #add new field 50001 SP Consumption Prod. Order Code 20
    // HEI.02 FDD-HT620 IBM BULIMC01 02.09.2019 #new field added "Consump. Tolerance Limit"
    // HEI.03 Defect 4550 IBM GUNERE01 10.10.2019 # new field "Item Attribute Value Filter" added
    // HEI.04 CHG2098327 IBM.LS      28.04.2021
    //   # Created New Fields: 50004 - CMG Dimension Code
    //                         50005 - CMG Values for Negative Consmp
    // HEI.05 HB1487 - CHG2070737 IBM NASTAA02 18.04.2022 # Mass Upload of Production Orders
    //   # New Field created: 50006 - Mand. Lot for Imp Consumpt It

    // HEI.06 HB2817 - CHG2150741 IBM GOKULS01 15.06.2022 # Production Version data
    //   # New Field created: 2036322 - Production version No series for adding new number in stagging records.
    //   # New Field created: 2036323 - Production Version Validity end date
    // HEI.07 HB3251 - CHG2181085 NORRIQ ZOGHLE01 21.11.2022 # Tool to cancel reservations coming from Finished Prod. Orders
    //   #New Field created: 50007 - Prod. order journal Filter to filter production order lines to delete
    //**************************************************************************************************************
    //BC UPGRADE PATHAA02 09.03.26 BC UPGRADE-LineSpeed,LineSpeed UoM & Show on Prod Order fields to be added
    // HEI.08- "Line Speed UOM" field(2036306-->50008) is moved to 50K series as part of BC Upgrade
    //BC UPGRADE PATHAA02 14.04.26
    // HEI.09- "Prod. Ver. No. Series" field(2036322-->50009) and "Prod. Ver. End Validity Date" field(2036323-->50010) are moved to 50K series 
    fields
    {
        modify("Primary Key")
        {
            CaptionML = ENU = 'Primary Key', FRA = 'Clé primaire';
        }
        modify("Normal Starting Time")
        {
            CaptionML = ENU = 'Normal Starting Time', FRA = 'Heure normale de début';
        }
        modify("Normal Ending Time")
        {
            CaptionML = ENU = 'Normal Ending Time', FRA = 'Heure normale de fin';
        }
        modify("Doc. No. Is Prod. Order No.")
        {
            CaptionML = ENU = 'Doc. No. Is Prod. Order No.', FRA = 'N° doc. égal n° O.F.';
        }
        modify("Cost Incl. Setup")
        {
            CaptionML = ENU = 'Cost Incl. Setup', FRA = 'Inclure coût préparation';
        }
        modify("Dynamic Low-Level Code")
        {
            CaptionML = ENU = 'Dynamic Low-Level Code', FRA = 'Code plus bas niv. dyn.';
        }
        modify("Planning Warning")
        {
            CaptionML = ENU = 'Planning Warning', FRA = 'Alerte planning';
        }
        modify("Simulated Order Nos.")
        {
            CaptionML = ENU = 'Simulated Order Nos.', FRA = 'N° O.F. simulé';
        }
        modify("Planned Order Nos.")
        {
            CaptionML = ENU = 'Planned Order Nos.', FRA = 'N° O.F. planifié';
        }
        modify("Firm Planned Order Nos.")
        {
            CaptionML = ENU = 'Firm Planned Order Nos.', FRA = 'N° O.F. planifié ferme';
        }
        modify("Released Order Nos.")
        {
            CaptionML = ENU = 'Released Order Nos.', FRA = 'N° O.F. lancé';
        }
        modify("Work Center Nos.")
        {
            CaptionML = ENU = 'Work Center Nos.', FRA = 'N° centre de charge';
        }
        modify("Machine Center Nos.")
        {
            CaptionML = ENU = 'Machine Center Nos.', FRA = 'N° poste de charge';
        }
        modify("Production BOM Nos.")
        {
            CaptionML = ENU = 'Production BOM Nos.', FRA = 'N° nomenclature';
        }
        modify("Routing Nos.")
        {
            CaptionML = ENU = 'Routing Nos.', FRA = 'N° gamme';
        }
        // modify("Current Production Forecast")
        // {
        //     CaptionML = ENU = 'Current Production Forecast', FRA = 'Prévision courante';
        // }
        // modify("Use Forecast on Locations")
        // {
        //     CaptionML = ENU = 'Use Forecast on Locations', FRA = 'Prévision sur magasin';
        // }
        // modify("Combined MPS/MRP Calculation")
        // {
        //     CaptionML = ENU = 'Combined MPS/MRP Calculation', FRA = 'Calcul PDP/MRP combiné';
        // } //BCUPG MARKED FOR REMOVAL
        modify("Components at Location")
        {

            //Unsupported feature: Change TableRelation on ""Components at Location"(Field 39)". Please convert manually.

            CaptionML = ENU = 'Components at Location', FRA = 'Mag. composant par déf.';
        }
        /*  modify("Default Dampener Period")
         {
             CaptionML = ENU = 'Default Dampener Period', FRA = 'Période seuil par défaut';
         }
         modify("Default Dampener %")
         {
             CaptionML = ENU = 'Default Dampener %', FRA = '% tampon par défaut';
         }
         modify("Default Safety Lead Time")
         {
             CaptionML = ENU = 'Default Safety Lead Time', FRA = 'Délai de sécurité par défaut';
         }
         modify("Blank Overflow Level")
         {
             CaptionML = ENU = 'Blank Overflow Level', FRA = 'Niveau de dépassement de capacité vide';
             OptionCaptionML = ENU = 'Allow Default Calculation,Use Item/SKU Values Only', FRA = 'Autoriser calcul par défaut,Utiliser uniquement les valeurs Article/Point de stock';
         } */ //marked for removal BCUPG
        modify("Show Capacity In")
        {
            CaptionML = ENU = 'Show Capacity In', FRA = 'Afficher la capacité en';
        }
        modify("Preset Output Quantity")
        {
            CaptionML = ENU = 'Preset Output Quantity', FRA = 'Quantité produite prédéfinie';
            OptionCaptionML = ENU = 'Expected Quantity,Zero on All Operations,Zero on Last Operation', FRA = 'Quantité prévue,Zéro pour toutes les opérations,Zéro pour la dernière opération';
        }
        field(50000; "SP Item Category Filter FND"; Text[250])
        {
            caption = 'SP Item Category Filter';
            Description = 'HEI.01';

            trigger OnLookup();
            var
                ItemCategory: Record "Item Category";
                ItemCategList: Page "Item Categories";
            begin
                //HEI.01+
                CLEAR(ItemCategList);
                ItemCategList.LOOKUPMODE := true;
                ItemCategList.EDITABLE := false;
                if ItemCategList.RUNMODAL() = ACTION::LookupOK then begin
                    if "SP Item Category Filter FND" <> '' then
                        "SP Item Category Filter FND" := "SP Item Category Filter FND" + '|';
                    "SP Item Category Filter FND" := "SP Item Category Filter FND" + ItemCategList.GetSelectionFilter();
                end;
                CLEAR(ItemCategList);
                //HEI.01-
            end;
        }
        field(50001; "SP Consumption Prod. Order FND"; Code[20])
        {
            caption = 'SP Consumption Prod. Order';
            Description = 'HEI.01';
            TableRelation = "Production Order"."No." where(Status = CONST(Released));
        }
        field(50002; "Consump. Tolerance Limit FND"; Boolean)
        {
            Caption = 'Consump. Tolerance Limit';
            Description = 'HEI.02';
        }
        field(50003; "Item Attri Value Filter FND"; Text[250])
        {
            caption = 'Item Attri Value Filter';
        }
        field(50004; "CMG Dimension Code FND"; Code[20])
        {
            caption = 'CMG Dimension Code';
            Description = 'HEI.04';
            TableRelation = Dimension;
        }
        field(50005; "CMG Values for Neg Consmp FND"; Code[250])
        {
            Caption = 'CMG Values for Negative Consumption';
            Description = 'HEI.04';
            TableRelation = "Dimension Value".Code where("Dimension Code" = CONST('CMG'));
            ValidateTableRelation = false;
        }
        field(50006; "Mand. Lot for ImpConsum It FND"; Boolean)
        {
            Caption = 'Mandatory Lot No for Imported Consumption Items';
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
        }
        field(50007; "Prod. order journal Filter FND"; Code[20])
        {
            Caption = 'Production order journal Filter';
            DataClassification = ToBeClassified;
            Description = 'HEI.07';
        }
        //HEI.08>>
        field(50008; "Line Speed UOM FND"; Code[10])
        {
            CaptionML = ENU = 'Line Speed Unit of Meas. Code',
                        FRA = 'Code unité de mesure - Vitesse lgine';
            TableRelation = "Capacity Unit of Measure";
        }
        //HEI.08<<

        //HEI.09>>
        field(50009; "Prod. Ver. No. Series FND"; Code[10])
        {
            Caption = 'Production Version Nos.';
            DataClassification = ToBeClassified;
            Description = 'HEI.09';
            TableRelation = "No. Series";
        }
        field(50010; "Prod. Ver. End Valid Date FND"; Date)
        {
            Caption = 'Production Version Validity End Date';
            Description = 'HEI.09';
            DataClassification = ToBeClassified;
        }
        //HEI.09<<
        //BC Upgrade kamnay01 DTW FDD 002>>
        field(50011; "Prod. Jnl. Flushing (Time) FND"; Boolean)
        {
            Caption = 'Prod. Jnl. Flushing (Time)';
            DataClassification = ToBeClassified;
        }
        //BC Upgrade kamnay01 DTW FDD 002<<

        //BC Upgrade Kamnay01 >>
        field(50012; "BOM Item FND"; Code[20])
        {
            Caption = 'BOM Item';
            DataClassification = ToBeClassified;
        }
        field(50013; "Std Cost Version FND"; Boolean)
        {
            Caption = 'Std Cost Version';
            DataClassification = ToBeClassified;
        }
        //BC Upgrade Kamnay01 <<
        //
        //---BC Upgrade KAMNAY01>>
        // field(2014411;"Prod. Loss. Jnl. Template Name";Code[10])
        // {
        //     CaptionML = ENU='Prod. Loss. Jnl. Template Name',
        //                 FRA='Nom modèle journal perte prod.';
        //     Description = 'DITW110.00.09 NRQ#18376';
        //     TableRelation = "Item Journal Template" WHERE (Type=CONST("Prod. Order"));
        // }
        // field(2014412;"Prod. Loss. Jnl. Batch Name";Code[10])
        // {
        //     CaptionML = ENU='Prod. Loss. Jnl. Batch Name',
        //                 FRA='Nom feuille journal perte prod.',
        //                 NLD='Prod. Loss. Jnl. Batch Name';
        //     Description = 'DITW110.00.09 NRQ#18376';
        //     TableRelation = "Item Journal Batch".Name WHERE ("Journal Template Name"=FIELD("Prod. Loss. Jnl. Template Name"),
        //                                                      "Template Type"=CONST("Prod. Order"));
        // }
        // field(2035040;"Default Labelprinter";Code[20])
        // {
        //     CaptionML = ENU='Default Label Printer',
        //                 FRA='Label impression par défaut';
        //     Description = 'DIT-715 #806';
        //     TableRelation = "Label Printers";
        // }
        // field(2035143;"Editable Item Posting Groups";Boolean)
        // {
        //     CaptionML = ENU='Editable Item Posting Groups',
        //                 FRA='Groupes compta. article modifiable';
        //     Description = 'PRODW14.00.00.08.14';
        // }
        // field(2036301;"Item Create Wizard";Boolean)
        // {
        //     CaptionML = ENU='Item Create Wizard',
        //                 FRA='Item Create Wizard';
        //     Description = 'MANXL7.00.001';
        // }
        // field(2036302;"Blocked Location Code";Code[10])
        // {
        //     CaptionML = ENU='Blocked Location Code',
        //                 FRA='Code magasin bloqué';
        //     Description = 'MANXL7.00.001';
        //     TableRelation = Location;
        // }
        // field(2036304;"Scrap Location Code";Code[10])
        // {
        //     CaptionML = ENU='Scrap Location Code',
        //                 FRA='Code magasin perte';
        //     Description = 'MANXL7.00.001';
        //     TableRelation = Location;
        // }
        // field(2036306;"Line Speed UOM";Code[10])
        // {
        //     CaptionML = ENU='Line Speed Unit of Meas. Code',
        //                 FRA='Code unité de mesure - Vitesse lgine';
        //     Description = 'MANXL7.00.001';
        //     TableRelation = "Capacity Unit of Measure";
        // }
        // field(2036307;"KPI UOM";Code[10])
        // {
        //     CaptionML = ENU='KPI Unit of Meas. Code',
        //                 FRA='Code unité de mesure KPI';
        //     Description = 'MANXL7.00.001';
        //     TableRelation = "Capacity Unit of Measure";
        // }
        // field(2036321;"Prod. Jnl. Flushing (Time)";Boolean)
        // {
        //     Description = 'DITW110.00.12A NRQ#51789';
        // }
        // field(2036322;"Prod. Ver. No. Series";Code[10])
        // {
        //     Caption = 'Production Version Nos.';
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.06';
        //     TableRelation = "No. Series";
        // }
        // field(2036323;"Prod. Ver. End Validity Date";Date)
        // {
        //     Caption = 'Production Version Validity End Date';
        //     DataClassification = ToBeClassified;
        // }
        //---BC Upgrade KAMNAY01<<
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

