tableextension 50173 ManufacturingCueExtFND extends "Manufacturing Cue"
{
    // version NAVW110.0,MANXL7.00.001,QXL9.00.001,DITW110.00.08,Role,HEI.10

    //     MANXL7.00.001 WSA 12/08/2014 : Added Field Subcontractor Tasks

    // DITW16.00.00.37 KCO 22/11/2010 DIT-715 #57 RTC Role Centers
    // DITW16.00.00.39 KCO 30/06/2011 DIT-715 #128 RTC Role Center adjustments
    //                 DDR 26/09/2011 DIT-715 #139 Removed filter "Planned Test Date" for fields2014475,2014476
    //                 KCO 04/10/2011 DIT-715 #139 Added filter "Status" = Quarantine for fields2014472,2014473,2014474,2014475,2014476
    //                                             Added/Replaced filter "Planned Test Date" with "Document Date"
    // DITW17.10.04 MSF 11/11/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // QXL9.00.001 MTR 07/09/2016 : Quality Management

    // HEI.01 Bugfixing IBM NASTAA02 22.11.2017 # Base Heilite
    //   # Added new fields
    // HEI.02 Defect #1534 IBM NASTAA02 22.02.2018 # Role Center Tiles
    //  # Wrong tables behind the role center tiles

    // HEI.03 defect #1543 IBM POSTOI01 27.02.2018
    //   #role center tiles : modified Properties , CalcFormula from Description-> Description 2

    // HEI.04 defect #1544 IBM POSTOI01 28.02.2018
    //   #role center tiles : modified field 50035 Lot Tests in Progress , property Count("Quality Test Header" WHERE (Status=FILTER(Quarantine|Pending)))

    // HEI.05 Defect #2020 IBM NASTAA02 24.04.2018 # Tile “Registered Goods Movement” is not correct
    //   # Added filter on Type "Movement" for Field "Registered Goods Movements"
    // HEI.06 Defect #2028 IBM NASTAA02 07.05.2018 # Role Tile Amount incorrect
    //   # Filter on Type "Movement" moved on table for Goods Movements
    // HEI.07 RFC-CHG0255624 IBM.LS 19.11.2018
    //   # Increased the following fields length to 250 from 10.
    //   # Brewing Zone", "FMat Zone", "FMix Zone" and "Packaging Zone".
    //   # Changed the FlowFields property to count the number of Production Order on tiles correctly.
    // HEI.08 CHG2089898 BULIMC01 IBM 18/11/2020
    //   #new flowfilter added: 50039 -"Responsability Center"
    //   # Responsibility Center=FIELD(Responsability Center Filter) added to flowfields marked with HEI.08
    // HEI.09 CHG2118467 IBM.LS      22.09.2021
    //   # Created New Field: 50040 - Bulk Transfer
    // HEI.10 HB1487 - CHG2070737 IBM NASTAA02 31.03.2022 # Mass Upload of Production Orders
    //   # New Field created: 50041 - Imported Production Orders
    //****************************************************************************************
    //BC UPGRADE PATHAA02- 12.11.25-Done
    //1. "Lot Tests in Progress"-calcformula error removed 
    //2. ("Responsibility Filter"-F2014410) is DIT field in Production Order table-commented all calcformulas, for the fields to work correctly, need to handle after we get aptean extension
    //3. Fields having Flowfields with DIT field -"Responsibility filter" will not work for now as the calcformula is commented
    //4. Field-50041, commented as No Opco is using this functionality
    //*******************************************************************************************
    fields
    {
        modify("Primary Key")
        {
            CaptionML = ENU = 'Primary Key', FRA = 'Clé primaire';
        }
        modify("Planned Prod. Orders - All")
        {
            CaptionML = ENU = 'Planned Prod. Orders - All', FRA = 'O.F. planifiés - Tous';
        }
        modify("Firm Plan. Prod. Orders - All")
        {
            CaptionML = ENU = 'Firm Plan. Prod. Orders - All', FRA = 'O.F. planifiés fermes - Tous';
        }
        modify("Released Prod. Orders - All")
        {
            CaptionML = ENU = 'Released Prod. Orders - All', FRA = 'O.F. lancés - Tous';
        }
        modify("Prod. BOMs under Development")
        {
            CaptionML = ENU = 'Prod. BOMs under Development', FRA = 'Nomenclatures prod. en cours de modification';
        }
        modify("Routings under Development")
        {
            CaptionML = ENU = 'Routings under Development', FRA = 'Gammes en cours de modification';
        }
        modify("Purchase Orders")
        {
            CaptionML = ENU = 'Purchase Orders', FRA = 'Commandes achat';
        }
        modify("Prod. Orders Routings-in Queue")
        {
            CaptionML = ENU = 'Prod. Orders Routings-in Queue', FRA = 'Gammes O.F. - en file d''attente';
        }
        modify("Prod. Orders Routings-in Prog.")
        {
            CaptionML = ENU = 'Prod. Orders Routings-in Prog.', FRA = 'Gammes O.F. - en cours';
        }
        modify("Invt. Picks to Production")
        {
            CaptionML = ENU = 'Invt. Picks to Production', FRA = 'Prélèvements stock vers la production';
        }
        modify("Invt. Put-aways from Prod.")
        {
            CaptionML = ENU = 'Invt. Put-aways from Prod.', FRA = 'Rangements stock à partir de la production';
        }
        modify("Rlsd. Prod. Orders Until Today")
        {
            CaptionML = ENU = 'Rlsd. Prod. Orders Until Today', FRA = 'Ordres de fabrication lancés à ce jour';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify("User ID Filter")
        {
            CaptionML = ENU = 'User ID Filter', FRA = 'Filtre code utilisateur';
        }
        field(50000; "Planned PO - Brewing FND"; Integer)
        {
            Caption = 'Planned PO - Brewing';
            //BC UPGRADE PATHAA02-DIT field-"Responsibility center">>
            // CalcFormula = Count("Production Order" where(Status = CONST(Planned),
            //                                               "Zone Code" = FIELD("Brewing Zone"),
            //                                               "Responsibility Center" = FIELD("Responsability Center Filter")));
            //BC UPGRADE PATHAA02-DIT field-"Responsibility center"<<
            Description = 'HEI.08';
            // FieldClass = FlowField; //BC UPGRADE PATHAA02
        }
        field(50001; "Firm Plan. PO - Brewing FND"; Integer)
        {
            //BC UPGRADE PATHAA02-DIT field-"Responsibility center">>
            FieldClass = FlowField;
            CalcFormula = Count("Production Order" where(Status = CONST("Firm Planned"),
                                                          "Zone Code FND" = FIELD(FILTER("Brewing Zone FND"))));
            //   "Responsibility Center" = FIELD("Responsability Center Filter"))); //BC Upgrade GUNREM01 -FDD-DTW 029 commented.
            //BC UPGRADE PATHAA02-DIT field-"Responsibility center"<<
            Caption = 'Firm Plan. Prod. Orders - All';
            Description = 'HEI.07,HEI.08';
            //FieldClass = FlowField; //BC UPGRADE PATHAA02
        }
        field(50002; "Released PO - Brewing FND"; Integer)
        {
            //BC UPGRADE PATHAA02-DIT field-"Responsibility center">>
            FieldClass = FlowField;
            CalcFormula = Count("Production Order" where(Status = CONST(Released),
                                                          "Zone Code FND" = FIELD(FILTER("Brewing Zone FND"))));
            //  "Responsibility Center" = FIELD("Responsability Center Filter"))); //BC Upgrade GUNREM01 -FDD-DTW 029 commented.
            //BC UPGRADE PATHAA02-DIT field-"Responsibility center"<<
            Caption = 'Released Prod. Orders - All';
            Description = 'HEI.07,HEI.08';
            //FieldClass = FlowField; //BC UPGRADE PATHAA02
        }
        field(50003; "Finished PO - Brewing FND"; Integer)
        {
            Caption = 'Finished PO - Brewing';
            //BC UPGRADE PATHAA02-DIT field-"Responsibility center">>
            FieldClass = FlowField;
            CalcFormula = Count("Production Order" where(Status = CONST(Finished),
                                                          "Zone Code FND" = FIELD(FILTER("Brewing Zone fnd"))));
            //   "Responsibility Center" = FIELD("Responsability Center Filter"))); //BC Upgrade GUNREM01 -FDD-DTW 029 commented.
            //BC UPGRADE PATHAA02-DIT field-"Responsibility center"<<
            Description = 'HEI.07,HEI.08';
            //FieldClass = FlowField; //BC UPGRADE PATHAA02
        }
        field(50004; "Warehouse Movements FND"; Integer)
        {
            Caption = 'Warehouse Movements';
            CalcFormula = Count("Warehouse Activity Header" where("Location Code" = CONST('DZ01')));
            FieldClass = FlowField;
        }
        field(50005; "Posted Whse. Rec List- Bre FND"; Integer)
        {
            Caption ='Posted Whse. Receipt List- Bre';
            CalcFormula = Count("Posted Whse. Receipt Header" where("Zone Code" = FIELD("Brewing Zone FND")));
            FieldClass = FlowField;
        }
        field(50006; "Warehouse Rec - Brewing FND"; Integer)
        {
            Caption ='Warehouse Rec - Brewing';
            CalcFormula = Count("Warehouse Receipt Header" where("Location Code" = CONST('DZ01'),
                                                                  "Zone Code" = CONST('BREWING')));
            FieldClass = FlowField;
        }
        field(50007; "Items FND"; Integer)
        {
            Caption ='Items';
            CalcFormula = Count(Item);
            FieldClass = FlowField;
        }
        field(50008; "SKU FND"; Integer)
        {
            Caption = 'SKU';
            CalcFormula = Count("Stockkeeping Unit");
            FieldClass = FlowField;
        }
        field(50009; "WorkCenter FND"; Integer)
        {
            Caption = 'WorkCenter';
            CalcFormula = Count("Work Center");
            FieldClass = FlowField;
        }
        field(50010; "Routings FND"; Integer)
        {
            Caption = 'Routings';
            CalcFormula = Count("Routing Header");
            FieldClass = FlowField;
        }
        field(50011; "Routing Links FND"; Integer)
        {
            Caption = 'Routing Links';
            CalcFormula = Count("Routing Link");
            FieldClass = FlowField;
        }
        field(50012; "BOM FND"; Integer)
        {
            Caption = 'BOM';
            CalcFormula = Count("Production BOM Header");
            FieldClass = FlowField;
        }
        field(50013; "Brewing Zone FND"; Code[250])
        {
            Caption = 'Brewing Zone';
            CalcFormula = Lookup("General OpCo Setup FND"."RC Brewing Zone code");
            Description = 'Role,HEI.07';
            FieldClass = FlowField;
        }
        field(50014; "FMat Zone FND"; Code[250])
        {
            Caption = 'FMat Zone';
            CalcFormula = Lookup("General OpCo Setup FND"."RC F&Mat Zone Code");
            Description = 'Role,HEI.07';
            FieldClass = FlowField;
        }
        field(50015; "FMix Zone FND"; Code[250])
        {
            Caption = 'FMix Zone';
            CalcFormula = Lookup("General OpCo Setup FND"."RC F&Mix Zone Code");
            Description = 'Role,HEI.07';
            FieldClass = FlowField;
        }
        field(50016; "Packaging Zone FND"; Code[250])
        {
            Caption = 'Packaging Zone';
            CalcFormula = Lookup("General OpCo Setup FND"."RC Packaging Zone Code");
            Description = 'Role,HEI.07';
            FieldClass = FlowField;
        }
        field(50017; "FPPO - Yeast FND"; Integer)
        {
            Caption = 'FPPO - Yeast';
            //BC UPGRADE PATHAA02-DIT field-"Responsibility center">>
            FieldClass = FlowField;
            CalcFormula = Count("Production Order" where(Status = CONST("Firm Planned"),
                                                          "Zone Code FND" = FIELD(FILTER("FMat Zone FND")),
                                                          "Description 2" = FILTER('propagated')));
            //     "Responsibility Center"=FIELD("Responsability Center Filter"))); //BC Upgrade GUNREM01 -FDD-DTW 029 commented.

            Description = 'Role,HEI.03,HEI.07,HEI.08';

            //BC UPGRADE PATHAA02-DIT field-"Responsibility center"<<
        }
        field(50018; "RPO - Yeast FND"; Integer)
        {
            Caption = 'RPO - Yeast';
            //BC UPGRADE PATHAA02-DIT field-"Responsibility center">>
            FieldClass = FlowField;
            CalcFormula = Count("Production Order" where(Status = CONST(Released),
                                                          "Zone Code FND" = FIELD(FILTER("FMat Zone FND")),
                                                          "Description 2" = FILTER('propagated')));
            //   "Responsibility Center"=FIELD("Responsability Center Filter"))); //BC Upgrade GUNREM01 -FDD-DTW 029 commented.

            Description = 'Role,HEI.03,HEI.07,HEI.08';

            //BC UPGRADE PATHAA02-DIT field-"Responsibility center"<<
        }
        field(50019; "FPO yeast FND"; Integer)
        {
            Caption = 'FPO yeast';
            //BC UPGRADE PATHAA02-DIT field-"Responsibility center">>
            FieldClass = FlowField;
            CalcFormula = Count("Production Order" where(Status = CONST(Finished),
                                                          "Zone Code FND" = FIELD(FILTER("FMat Zone FND")),
                                                          "Description 2" = FILTER('propagated')));
            //   "Responsibility Center"=FIELD("Responsability Center Filter")));  //BC Upgrade GUNREM01 -FDD-DTW 029 commented.

            Description = 'Role,HEI.03,HEI.07,HEI.08';

            //BC UPGRADE PATHAA02-DIT field-"Responsibility center"<<
        }
        field(50020; "FPPO <> Yeast FND"; Integer)
        {
            Caption = 'FPPO <> Yeast';
            //BC UPGRADE PATHAA02>>
            FieldClass = FlowField;
            CalcFormula = Count("Production Order" where(Status = CONST("Firm Planned"),
                                                          "Zone Code FND" = FIELD(FILTER("FMat Zone FND")),
                                                          "Description 2" = FILTER(<> 'propagated')));
            //  "Responsibility Center"=FIELD("Responsability Center Filter"))); //BC Upgrade GUNREM01 -FDD-DTW 029 commented.

            Description = 'Role,HEI.03,HEI.07,HEI.08';

            //BC UPGRADE PATHAA02<<
        }
        field(50021; "RPO <> yeast FND"; Integer)
        {
            Caption = 'RPO <> yeast';
            //BC UPGRADE PATHAA02>>
            FieldClass = FlowField;
            CalcFormula = Count("Production Order" where(Status = CONST(Released),
                                                          "Zone Code FND" = FIELD(FILTER("FMat Zone FND")),
                                                          "Description 2" = FILTER(<> 'propagated')));
            // "Responsibility Center"=FIELD("Responsability Center Filter"))); //BC Upgrade GUNREM01 -FDD-DTW 029 commented.
            Description = 'Role,HEI.03,HEI.07,HEI.08';

            //BC UPGRADE PATHAA02<<
        }
        field(50022; "FPO <> Yeast FND"; Integer)
        {
            Caption = 'FPO <> Yeast';
            //BC UPGRADE PATHAA02-DIT field-"Responsibility center">>
            FieldClass = FlowField;
            CalcFormula = Count("Production Order" where(Status = CONST(Finished),
                                                          "Zone Code FND" = FIELD(FILTER("FMat Zone FND")),
                                                          "Description 2" = FILTER(<> 'propagated')));
            //  "Responsibility Center"=FIELD("Responsability Center Filter")));//BC Upgrade GUNREM01 -FDD-DTW 029 commented.
            Description = 'Role,HEI.03,HEI.07,HEI.08';

            //BC UPGRADE PATHAA02-DIT field-"Responsibility center"<<
        }
        field(50023; "FPPO - Filtration Capacity FND"; Integer)
        {
            Caption = 'FPPO - Filtration Capacity';
            //BC UPGRADE PATHAA02-DIT field-"Responsibility center">>
            FieldClass = FlowField;
            CalcFormula = Count("Production Order" where(Status = CONST("Firm Planned"),
                                                          "Zone Code FND" = FIELD(FILTER("FMix Zone FND")),
                                                          "Description 2" = FILTER('filtration')));
            //  "Responsibility Center"=FIELD("Responsability Center Filter")));//BC Upgrade GUNREM01 -FDD-DTW 029 commented.
            Description = 'Role,HEI.03,HEI.07,HEI.08';

            //BC UPGRADE PATHAA02-DIT field-"Responsibility center"<<
        }
        field(50024; "RPO - Filtration Capacity FND"; Integer)
        {
            Caption = 'RPO - Filtration Capacity';
            //BC UPGRADE PATHAA02-DIT field-"Responsibility center">>
            FieldClass = FlowField;
            CalcFormula = Count("Production Order" where(Status = CONST(Released),
                                                          "Zone Code FND" = FIELD(FILTER("FMix Zone FND")),
                                                          "Description 2" = FILTER('filtration')));
            // "Responsibility Center"=FIELD("Responsability Center Filter"))); //BC Upgrade GUNREM01 -FDD-DTW 029 commented.
            Description = 'Role,HEI.03,HEI.07,HEI.08';

            //BC UPGRADE PATHAA02-DIT field-"Responsibility center"<<
        }
        field(50025; "FPO - Filtration Capacity FND"; Integer)
        {
            Caption = 'FPO - Filtration Capacity';
            //BC UPGRADE PATHAA02-DIT field-"Responsibility center">>
            FieldClass = FlowField;
            CalcFormula = Count("Production Order" where(Status = CONST(Finished),
                                                          "Zone Code FND" = FIELD(FILTER("FMix Zone FND")),
                                                          "Description 2" = FILTER('filtration')));
            //   "Responsibility Center"=FIELD("Responsability Center Filter"))); //BC Upgrade GUNREM01 -FDD-DTW 029 commented.
            Description = 'Role,HEI.03,HEI.07,HEI.08';

            //BC UPGRADE PATHAA02-DIT field-"Responsibility center"<<
        }
        field(50026; "FPPO <> Filtration Capacit FND"; Integer)
        {
            Caption = 'FPPO <> Filtration Capacity';
            //BC UPGRADE PATHAA02-DIT field-"Responsibility center">>
            FieldClass = FlowField;
            CalcFormula = Count("Production Order" where(Status = CONST("Firm Planned"),
                                                          "Zone Code FND" = FIELD(FILTER("FMix Zone FND")),
                                                          "Description 2" = FILTER(<> 'filtration')));
            //  "Responsibility Center"=FIELD("Responsability Center Filter")));//BC Upgrade GUNREM01 -FDD-DTW 029 commented.
            Description = 'Role,HEI.03,HEI.07,HEI.08';

            //BC UPGRADE PATHAA02-DIT field-"Responsibility center"<<
        }
        field(50027; "RPO <> Filtration Capacity FND"; Integer)
        {
            Caption = 'RPO <> Filtration Capacity';
            //BC UPGRADE PATHAA02-DIT field-"Responsibility center">>
            FieldClass = FlowField;
            CalcFormula = Count("Production Order" where(Status = CONST(Released),
                                                          "Zone Code FND" = FIELD(FILTER("FMix Zone FND")),
                                                          "Description 2" = FILTER(<> 'filtration')));
            //  "Responsibility Center"=FIELD("Responsability Center Filter"))); //BC Upgrade GUNREM01 -FDD-DTW 029 commented.
            Description = 'Role,HEI.03,HEI.07,HEI.08';

            //BC UPGRADE PATHAA02-DIT field-"Responsibility center"<<
        }
        field(50028; "FPO <> Filtration Capacity FND"; Integer)
        {
            Caption = 'FPO <> Filtration Capacity';
            //BC UPGRADE PATHAA02-DIT field-"Responsibility center">>
            FieldClass = FlowField;
            CalcFormula = Count("Production Order" where(Status = CONST(Finished),
                                                          "Zone Code FND" = FIELD(FILTER("FMix Zone FND")),
                                                          "Description 2" = FILTER(<> 'filtration')));
            //  "Responsibility Center"=FIELD("Responsability Center Filter")));//BC Upgrade GUNREM01 -FDD-DTW 029 commented.
            Description = 'Role,HEI.03,HEI.07,HEI.08';

            //BC UPGRADE PATHAA02-DIT field-"Responsibility center"<<
        }
        field(50029; "FPPO - Pack FND"; Integer)
        {
            Caption = 'FPPO - Pack';
            //BC UPGRADE PATHAA02-DIT field-"Responsibility center">>
            FieldClass = FlowField;
            CalcFormula = Count("Production Order" where(Status = CONST("Firm Planned"),
                                                          "Zone Code FND" = FIELD(FILTER("Packaging Zone FND"))));
            // "Responsibility Center" = FIELD("Responsability Center Filter")));//BC Upgrade GUNREM01 -FDD-DTW 029 commented.
            Description = 'Role,HEI.07,HEI.08';

            //BC UPGRADE PATHAA02-DIT field-"Responsibility center"<<
        }
        field(50030; "RPO - Pack FND"; Integer)
        {
            Caption = 'RPO - Pack';
            //BC UPGRADE PATHAA02-DIT field-"Responsibility center">>
            CalcFormula = Count("Production Order" where(Status = CONST(Released),
                                                          "Zone Code FND" = FIELD(FILTER("Packaging Zone FND"))));
            // "Responsibility Center" = FIELD("Responsability Center Filter")));//BC Upgrade GUNREM01 -FDD-DTW 029 commented.
            Description = 'Role,HEI.07,HEI.08';
            FieldClass = FlowField;
            //BC UPGRADE PATHAA02-DIT field-"Responsibility center"<<
        }
        field(50031; "FPO - Pack FND"; Integer)
        {
            Caption = 'FPO - Pack';
            //BC UPGRADE PATHAA02-DIT field-"Responsibility center">>
            CalcFormula = Count("Production Order" where(Status = CONST(Finished),
                                                          "Zone Code FND" = FIELD(FILTER("Packaging Zone FND"))));
            //  "Responsibility Center" = FIELD("Responsability Center Filter")));//BC Upgrade GUNREM01 -FDD-DTW 029 commented.
            Description = 'Role,HEI.07,HEI.08';
            FieldClass = FlowField;
            //BC UPGRADE PATHAA02-DIT field-"Responsibility center"<<
        }
        field(50032; "Goods Movement FND"; Integer)
        {
            Caption = 'Goods Movement';
            CalcFormula = Count("Warehouse Activity Header" where(Type = CONST(Movement)));
            Description = 'Role';
            FieldClass = FlowField;
        }
        field(50033; "Item Reclass FND"; Integer)
        {
            Caption = 'Item Reclass';
            CalcFormula = Count("Item Journal Line");
            Description = 'Role';
            FieldClass = FlowField;
        }
        field(50034; "Lot No. Information FND"; Integer)
        {
            Caption = 'Lot No. Information';
            CalcFormula = Count("Lot No. Information");
            Description = 'Role';
            FieldClass = FlowField;
        }
        field(50035; "Lot Tests in Progress FND"; Integer)
        {
            Caption = 'Lot Tests in Progress';
            //BC UPGRADE PATHAA02 DIT>>
            //CalcFormula = Count("Quality Test Header" WHERE (Status=FILTER(Quarantine|Pending))); //BC UPGRADE PATHAA02-error
            //CalcFormula = Count("Quality Test Header" where(Status = FILTER(Quarantine) OR Status=FILTER(Pending))); //BC UPGRADE PATHAA02 Table-2035096-"Quality Test Header"
            // Description = 'Role,HEI.04';
            // FieldClass = FlowField;
            //BC UPGRADE PATHAA02<<
        }
        field(50036; "Goods Receipts FND"; Integer)
        {
            Caption = 'Goods Receipts';
            CalcFormula = Count("Warehouse Receipt Header");
            Description = 'HEI.01';
            FieldClass = FlowField;
        }
        field(50037; "Registered Goods Receipts FND"; Integer)
        {
            Caption = 'Registered Goods Receipts';
            CalcFormula = Count("Posted Whse. Receipt Header");
            Description = 'HEI.01,HEI.02';
            FieldClass = FlowField;
        }
        field(50038; "Registered Goods Movements FND"; Integer)
        {
            Caption = 'Registered Goods Movements';
            CalcFormula = Count("Registered Whse. Activity Hdr." where(Type = FILTER(Movement)));
            Description = 'HEI.01,HEI.02,HEI.05';
            FieldClass = FlowField;
        }
        field(50039; "Responsability Cent Filter FND"; Code[20])
        {
            Caption = 'Responsability Cent Filter';
            Description = 'HEI.08';
            FieldClass = FlowFilter;
        }
        field(50040; "Bulk Transfer FND"; Integer)
        {
            Caption = 'Bulk Transfer';
            CalcFormula = Count("Item Journal Line" where("Entry Type" = CONST(Transfer),
                                                           "Bulk Transfer FND" = CONST(true)));
            Description = 'HEI.09';
            FieldClass = FlowField;
        }
        ////BC UPGRADE PATHAA02-No Opco is using this functionality>>
        // field(50041; "Imported Production Orders"; Integer)
        // {
        //     CalcFormula = Count("Imported Production Order");
        //     Caption = 'Imported Production Orders';
        //     Description = 'HEI.10';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        //BC UPGRADE PATHAA02-No Opco is using this functionality<<

        //BC UPGRADE PATHAA02-DIT>>
        // field(2014460;"Released Brewing Orders -Today";Integer)
        // {
        //     CalcFormula = Count("Prod. Order Line" WHERE (Status=CONST(Released),
        //                                                   "Starting Date"=FIELD("Date Filter")));
        //     CaptionML = ENU='Released Brewing Orders - Today',
        //                 FRA='O.F. Brasserie lancés - Aujourd''hui';
        //     Description = 'DIT-715 #128';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014461;"Released Brewing Orders - All";Integer)
        // {
        //     CalcFormula = Count("Prod. Order Line" WHERE (Status=CONST(Released)));
        //     CaptionML = ENU='Released Brewing Orders - All',
        //                 FRA='O.F. Brasserie lancés - Tous';
        //     Description = 'DIT-715 #128';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035090;"Quarantine Lot Tests - All";Integer)
        // {
        //     CalcFormula = Count("Quality Test Header" WHERE ("Document Type"=CONST("Lot/SN Test"),
        //                                                      Status=CONST(Quarantine)));
        //     CaptionML = ENU='Quarantine Lot Tests - All',
        //                 FRA='Tests de lot en quarantaine - Tous';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035091;"Pending Lot Tests - All";Integer)
        // {
        //     CalcFormula = Count("Quality Test Header" WHERE ("Document Type"=CONST("Lot/SN Test"),
        //                                                      Status=CONST(Pending)));
        //     CaptionML = ENU='Pending Lot Tests - All',
        //                 FRA='Tests de lot suspendus - Tous';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035092;"Date Filter Overdue";Date)
        // {
        //     CaptionML = ENU='Date Filter Overdue',
        //                 FRA='Filtre date échu';
        //     Description = 'QXL9.00.001';
        //     FieldClass = FlowFilter;
        // }
        // field(2035093;"Date Filter Due Today";Date)
        // {
        //     CaptionML = ENU='Date Filter Due Today',
        //                 FRA='Filtre date échéance aujourd''hui';
        //     Description = 'QXL9.00.001';
        //     FieldClass = FlowFilter;
        // }
        // field(2035094;"Date Filter Not Due Today";Date)
        // {
        //     CaptionML = ENU='Date Filter Not Due Today',
        //                 FRA='Filtre date non échéance aujourd''hui';
        //     Description = 'QXL9.00.001';
        //     FieldClass = FlowFilter;
        // }
        // field(2035095;"Released PO - Overdue";Integer)
        // {
        //     CalcFormula = Count("Production Order" WHERE (Status=CONST(Released),
        //                                                   "Due Date"=FIELD("Date Filter Overdue")));
        //     CaptionML = ENU='Released Prod. Orders - Overdue',
        //                 FRA='O.F. lancés - échus';
        //     Description = 'QXL9.00.001';
        //     FieldClass = FlowField;
        // }
        // field(2035096;"Released PO - Due Today";Integer)
        // {
        //     CalcFormula = Count("Production Order" WHERE (Status=CONST(Released),
        //                                                   "Due Date"=FIELD("Date Filter Due Today")));
        //     CaptionML = ENU='Released Prod. Orders - Due Today',
        //                 FRA='O.F. lancés - échu aujourd''hui';
        //     Description = 'QXL9.00.001';
        //     FieldClass = FlowField;
        // }
        // field(2035097;"Released PO - Not Due Today";Integer)
        // {
        //     CalcFormula = Count("Production Order" WHERE (Status=CONST(Released),
        //                                                   "Due Date"=FIELD("Date Filter Not Due Today")));
        //     CaptionML = ENU='Released Prod. Orders - Not Due Today',
        //                 FRA='O.F. lancés - non échu aujourd''hui';
        //     Description = 'QXL9.00.001';
        //     FieldClass = FlowField;
        // }
        // field(2035098;"Lot Tests";Integer)
        // {
        //     CalcFormula = Count("Quality Test Header" WHERE ("Document Type"=CONST("Lot/SN Test"),
        //                                                      Status=CONST(Quarantine)));
        //     CaptionML = ENU='Lot Tests',
        //                 FRA='Test lots';
        //     Description = 'QXL9.00.001';
        //     FieldClass = FlowField;
        // }
        // field(2035099;"In Process Tests";Integer)
        // {
        //     CalcFormula = Count("Quality Test Header" WHERE ("Document Type"=CONST("In Process Test"),
        //                                                      Status=CONST(Quarantine)));
        //     CaptionML = ENU='In Process Tests',
        //                 FRA='Tests en traitement';
        //     Description = 'QXL9.00.001';
        //     FieldClass = FlowField;
        // }
        // field(2035100;"Lot Tests - Overdue";Integer)
        // {
        //     CalcFormula = Count("Quality Test Header" WHERE ("Document Type"=CONST("Lot/SN Test"),
        //                                                      Status=CONST(Quarantine),
        //                                                      "Document Date"=FIELD("Date Filter Overdue")));
        //     CaptionML = ENU='Lot Tests - Overdue',
        //                 FRA='Test lots - échus';
        //     Description = 'QXL9.00.001';
        //     FieldClass = FlowField;
        // }
        // field(2035101;"In Process Tests - Overdue";Integer)
        // {
        //     CalcFormula = Count("Quality Test Header" WHERE ("Document Type"=CONST("In Process Test"),
        //                                                      Status=CONST(Quarantine),
        //                                                      "Document Date"=FIELD("Date Filter Overdue")));
        //     CaptionML = ENU='In Process Tests - Overdue',
        //                 FRA='Tests en traitement - Expiré';
        //     Description = 'QXL9.00.001';
        //     FieldClass = FlowField;
        // }
        // field(2035102;"Lot Tests - Today";Integer)
        // {
        //     CalcFormula = Count("Quality Test Header" WHERE ("Document Type"=CONST("Lot/SN Test"),
        //                                                      Status=CONST(Quarantine),
        //                                                      "Document Date"=FIELD("Date Filter Due Today")));
        //     CaptionML = ENU='Lot Tests - Today',
        //                 FRA='Lot tests - Aujourd''hui';
        //     Description = 'QXL9.00.001';
        //     FieldClass = FlowField;
        // }
        // field(2035103;"In Process Tests - Today";Integer)
        // {
        //     CalcFormula = Count("Quality Test Header" WHERE ("Document Type"=CONST("In Process Test"),
        //                                                      Status=CONST(Quarantine),
        //                                                      "Document Date"=FIELD("Date Filter Due Today")));
        //     CaptionML = ENU='In Process Tests - Today',
        //                 FRA='Tests en traitement - Aujourd''hui';
        //     Description = 'QXL9.00.001';
        //     FieldClass = FlowField;
        // }
        // field(2036301;"Subcontractor Tasks";Integer)
        // {
        //     CalcFormula = Count("Prod. Order Routing Line" WHERE ("Subcontractor No."=FILTER(<>''),
        //                                                           Status=FILTER(Released),
        //                                                           "Routing Status"=FILTER("In Progress")));
        //     CaptionML = ENU='Subcontractor Tasks',
        //                 FRA='Planification sous-traitants';
        //     Description = 'MANXL7.00.001';
        //     FieldClass = FlowField;
        // }
        //BC UPGRADE PATHAA02-DIT<<
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

