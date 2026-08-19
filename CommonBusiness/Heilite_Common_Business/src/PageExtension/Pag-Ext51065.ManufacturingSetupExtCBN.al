pageextension 51065 ManufacturingSetupExtCBN extends "Manufacturing Setup"
{
    InsertAllowed = false;
    DeleteAllowed = false;

    // version NAVW110.0,MANXL10.01,DITW110.00.11,DITW110.00.12A,HEI.06
    // DITW15.00.00.35 PRODW14.00.00.08.14 DDR 18/08/2009
    //                                issue 768 Added fields
    //                                  2035143 Editable Item Posting Groups
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM

    // MANXL7.00.001 DAT 24/02/2014 #1: Added field "Line Speed UOM"
    // MANXL7.00.001 DAT 26/02/2014 #6: Added fields "Blocked Location Code" and "Scrap Location Code"
    // MANXL7.00.001 DAT 03/03/2014 #12: Version Management
    // MANXL7.00.001 DAT 04/03/2014 #13: Prod. Order KPI's in overview screen

    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.05 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 VSC 13/04/2017 NRQ#18376 New Fields "Prod. Loss. Jnl. Template Name" and "Prod. Loss. Jnl. Batch Name"
    // DITW110.00.12A ISL 13/06/2018 NRQ#51789 Added new field "Prod. Jnl. Flushing (Time)"
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
    //   #New Field created: 50007 - Prod. order journal Filter to filter production order 
    //***************************************************************************************
    //HEI.08 FDD-LineSpeed BC UPGRADE PATHAA02-09.03.26 # "Line Speed UOM" field added
    //BC UPGRADE PATHAA02 14.04.26
    // HEI.09- "Prod. Ver. No. Series" field(2036322-->50009) and "Prod. Ver. End Validity Date" field(2036323-->50010) are moved to 50K series 

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Normal Starting Time")
        {
            ToolTipML = ENU = 'Specifies the normal starting time of the workday.', FRA = 'Spécifie l''heure normale de début du jour ouvré.';
        }
        modify("Normal Ending Time")
        {
            ToolTipML = ENU = 'Specifies the normal ending time of a workday.', FRA = 'Spécifie l''heure normale de fin d''un jour ouvré.';
        }
        modify("Preset Output Quantity")
        {
            ToolTipML = ENU = 'Defines what to show in the Output Quantity field of a production journal when it is first opened.', FRA = 'Définit les éléments à afficher dans le champ Quantité produite d''une feuille production lorsque vous l''ouvrez pour la première fois.';
        }
        modify("Show Capacity In")
        {
            ToolTipML = ENU = 'Specifies which capacity unit of measure to use by default to record and track capacity.', FRA = 'Spécifie quelle unité de mesure capacité doit être utilisée par défaut pour enregistrer et suivre la capacité.';
        }
        modify("Planning Warning")
        {
            ToolTipML = ENU = 'Specifies whether to run the MRP engine to detect if planned shipment dates cannot be met.', FRA = 'Indique si le moteur MRP doit être exécuté pour détecter si les dates d''expédition planifiées ne peuvent pas être atteintes.';
        }
        modify("Doc. No. Is Prod. Order No.")
        {
            ToolTipML = ENU = 'Specifies that the production order number is also the document number in the ledger entries posted for the production order.', FRA = 'Spécifie que le numéro de l''ordre de fabrication est également le numéro document dans les écritures comptables validées pour l''ordre de fabrication.';
        }
        modify("Dynamic Low-Level Code")
        {
            ToolTipML = ENU = 'Specifies whether to immediately assign and calculate low-level codes for each component in the product structure.', FRA = 'Spécifie s''il faut affecter et calculer immédiatement les codes plus bas niveau de chaque composant dans la structure produit.';
        }
        modify("Cost Incl. Setup")
        {
            ToolTipML = ENU = 'Specifies whether the setup times are to be included in the cost calculation of the Standard Cost field.', FRA = 'Indique si les temps de préparation doivent être compris dans le calcul du coût du champ Coût standard.';
        }
        modify(Numbering)
        {
            CaptionML = ENU = 'Numbering', FRA = 'Numérotation';
        }
        modify("Simulated Order Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code to use when assigning numbers to a simulated production order.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée lors de l''affectation des numéros à un ordre de fabrication simulé.';
        }
        modify("Planned Order Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code to use when assigning numbers to a planned production order.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée lors de l''affectation des numéros à un ordre de fabrication prévu.';
        }
        modify("Firm Planned Order Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code to use when assigning numbers to firm planned production orders.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée lors de l''affectation des numéros à des ordres de fabrication prévus fermes.';
        }
        modify("Released Order Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code to use when assigning numbers to a released production order.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée lors de l''affectation des numéros à un ordre de fabrication lancé.';
        }
        modify("Work Center Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code to use when assigning numbers to work centers.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée lors de l''affectation aux centres de charge.';
        }
        modify("Machine Center Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code to use when assigning numbers to machine centers.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée lors de l''affectation aux postes de charge.';
        }
        modify("Production BOM Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code to use when assigning numbers to production BOMs.', FRA = 'Spécifie le code de la souche de numéros qui est utilisée lors de l''affectation aux nomenclatures de production.';
        }
        modify("Routing Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series code to use when assigning numbers to routings.', FRA = 'Spécifie le code de la souche de numéros qui est utilisé lors de l''affectation aux gammes.';
        }
        modify(Planning)
        {
            CaptionML = ENU = 'Planning', FRA = 'Planning';
        }
        // modify("Current Production Forecast")
        // {
        //     ToolTipML = ENU = 'Specifies the name of the relevant production forecast to use to calculate a plan.', FRA = 'Spécifie le nom de la prévision production appropriée à utiliser pour calculer une planification.';
        // }
        // modify("Use Forecast on Locations")
        // {
        //     ToolTipML = ENU = 'Specifies whether to filter according to location when calculating a plan.', FRA = 'Spécifie s''il faut appliquer un filtre en fonction de l''emplacement lors du calcul d''une planification.';
        // }
        // modify("Default Safety Lead Time")
        // {
        //     ToolTipML = ENU = 'Specifies a time period that is added to the lead time of all items that do not have another value specified in the Safety Lead Time field.', FRA = 'Indique une période qui est ajoutée au délai de tous les articles pour lesquels aucune autre valeur n''est spécifiée dans le champ Délai de sécurité.';
        // }
        // modify("Blank Overflow Level")
        // {
        //     ToolTipML = ENU = 'Defines how the planning system should react if the Overflow Level field on the item or SKU card is empty.', FRA = 'Définit la manière dont le système de planification doit réagir si le champ Niveau de dépassement de capacité de la fiche article ou de la fiche point de stock est vide.';
        // }
        // modify("Combined MPS/MRP Calculation")
        // {
        //     ToolTipML = ENU = 'Specifies whether MPS and MRP are calculated in one step when you run the planning worksheet.', FRA = 'Indique si les champs PDP et MRP sont calculés en une étape lorsque vous exécutez la feuille planning.';
        // }
        modify("Components at Location")
        {
            ToolTipML = ENU = 'Specifies the inventory location from where the production order components are to be taken.', FRA = 'Spécifie l''emplacement du stock à partir duquel les composants d''ordres de fabrication doivent être pris.';
        }
        /*         modify("Default Dampener Period")
                {
                    ToolTipML = ENU = 'Specifies a period of time during which you do not want the planning system to propose to reschedule existing supply orders forward.', FRA = 'Spécifie la période pendant laquelle vous ne souhaitez pas que le système de planification propose de replanifier les commandes approvisionnement existantes en aval.';
                }
                modify("Default Dampener %")
                {
                    ToolTipML = ENU = 'Specifies a percentage of an item''s lot size by which an existing supply must change before a planning suggestion is made.', FRA = 'Indique un pourcentage de la taille lot d''un article pour lequel un approvisionnement existant doit être modifié avant qu''une proposition planning soit créée.';
                } */
        //BC UpGRADE PATHAA02>>
        // addafter("Show Capacity In")
        // {
        //     field("Line Speed UOM"; "Line Speed UOM")
        //     {
        //         Description = 'MANXL7.00.001';
        //     }
        //     field("KPI UOM"; "KPI UOM")
        //     {
        //         Description = 'MANXL7.00.001';
        //     }
        // } //BC UpGRADE PATHAA02<<
        addafter("Cost Incl. Setup")
        {
            //BC UpGRADE PATHAA02>>
            // field("Item Create Wizard"; "Item Create Wizard")
            // {
            //     Description = 'MANXL7.00.001';
            // }
            // field("Blocked Location Code"; "Blocked Location Code")
            // {
            // }
            // field("Scrap Location Code"; "Scrap Location Code")
            // {
            // }
            // field("Prod. Jnl. Flushing (Time)"; "Prod. Jnl. Flushing (Time)")
            // {
            //     Description = 'DITW110.00.12A NRQ#51789';
            // }
            //BC UpGRADE PATHAA02<<
            field("<Consump. Tolerance Limit"; Rec."Consump. Tolerance Limit FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Consump. Tolerance Limit field.';
                // BC Upgrade NANDIS03                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           ToolTip = 'Specifies the value of the Consump. Tolerance Limit field.';

            }
            field("SP Item Category Filter"; Rec."SP Item Category Filter FND")
            {
                Visible = SPVisible;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SP Item Category Filter field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the SP Item Category Filter field.';

            }
            field("SP Consumption Prod. Order"; Rec."SP Consumption Prod. Order FND")
            {
                ApplicationArea = All;  // BC Upgrade NANDIS03
                Visible = SPVisible;
                ToolTip = 'Specifies the value of the SP Consumption Prod. Order field.';
            }
            field("Item Attribute Value Filter"; Rec."Item Attri Value Filter FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Attribute Value Filter field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Item Attribute Value Filter field.';

                trigger OnLookup(var Text: Text): Boolean;  //BCUPGRADE PATHAA02 -var added
                begin
                    //>> HEI.03
                    CLEAR(ItemAttributeValues);
                    ItemAttributeValues.LOOKUPMODE(true);
                    if not (ItemAttributeValues.RUNMODAL() = ACTION::LookupOK) then
                        exit(false);

                    Text := ItemAttributeValues.GetSelectionFilter();
                    exit(true);
                    //<< HEI.03
                end;
            }
            field("CMG Dimension Code"; Rec."CMG Dimension Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CMG Dimension Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the CMG Dimension Code field.';

            }
            field("CMG Values for Negative Consmp"; Rec."CMG Values for Neg Consmp FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CMG Values for Negative Consumption field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the CMG Values for Negative Consumption field.';

            }
            field("Mand. Lot for Imp Consumpt It"; Rec."Mand. Lot for ImpConsum It FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Mandatory Lot No for Imported Consumption Items field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Mandatory Lot No for Imported Consumption Items field.';

            }
            field("Prod. order journal Filter"; Rec."Prod. order journal Filter FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Production order journal Filter field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Production order journal Filter field.';

            }
            //HEI.08>>
            field("Line Speed UOM"; Rec."Line Speed UOM FND")
            {
                ApplicationArea = All;
            }
            //HEI.08<<
        }
        //HEI.09 BC UpGRADE PATHAA02 14.04.26>>
        addafter("Routing Nos.")
        {
            field("Prod. Ver. No. Series"; Rec."Prod. Ver. No. Series FND")
            {
                ApplicationArea = All;
            }
            field("Prod. Ver. End Validity Date"; Rec."Prod. Ver. End Valid Date FND")
            {
                ApplicationArea = All;
            }
        }
        //HEI.09 BC UpGRADE PATHAA02 14.04.26<<
        //BC Upgrade kamnay01 DTW FDD 002>>
        addafter("Manual Scheduling")
        {
            field("Prod. Jnl. Flushing (Time) FND"; Rec."Prod. Jnl. Flushing (Time) FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the time when the production journal is flushed.';
            }
        }
        //BC Upgrade kamnay01 DTW FDD 002<<

        // addafter(Planning)
        // {
        //     group("Drink-It")
        //     {
        //         CaptionML = ENU = 'Drink-It',
        //                     FRA = 'Drink-It';
        //         field("Editable Item Posting Groups"; "Editable Item Posting Groups")
        //         {
        //         }
        //         field("Prod. Loss. Jnl. Template Name"; "Prod. Loss. Jnl. Template Name")
        //         {
        //             Description = 'DITW110.00.09 NRQ#18376';
        //         }
        //         field("Prod. Loss. Jnl. Batch Name"; "Prod. Loss. Jnl. Batch Name")
        //         {
        //             Description = 'DITW110.00.09 NRQ#18376';
        //         }
        //         field("Default Labelprinter"; "Default Labelprinter")
        //         {
        //             Description = 'DIT-715 #806';
        //         }
        //     }
        // }
    }

    var
        ItemAttributeValues: Page "Item Attribute Values";
        SPVisible: Boolean;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger (Variable: GeneralOpCoSetup)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    trigger OnOpenPage();
    var
        GeneralOpCoSetup: Record "General OpCo Setup FND";
    begin
        //HEI.01+
        if GeneralOpCoSetup.GET() then
            SPVisible := GeneralOpCoSetup."Spare Part Consumption";
        //HEI.01-

    end;

    //>>>> ORIGINAL CODE:
    //begin
    /*
    RESET;
    IF NOT GET THEN BEGIN
      INIT;
      INSERT;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    RESET;
    if not GET then begin
      INIT;
      INSERT;
    end;
    //HEI.01+
    if GeneralOpCoSetup.GET then
      SPVisible := GeneralOpCoSetup."Spare Part Consumption";
    //HEI.01-
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
}

