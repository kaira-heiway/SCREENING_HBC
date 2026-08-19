pageextension 54000 WorkCenterCardExt extends "Work Center Card"
{
    // version NAVW110.0,MANXL7.00,DITW110.00.08,HEI.02

    //     MANXL7.00.001 DAT 04/04/2014 #16: Added "Bottleneck" and "Planning"

    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) Added field "Scrap Code","Max. Scrap %"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD- GAPID-001 IBM.NAIKH01 :
    //   # Added a new Fiels "Partial Output"
    // HEI.01 FDD-BPMGAP001_BPMGAP002 IBM HORTOC01 06.09.2017
    //   New fields
    // HEI.02 CHG2135085 SAHAL01      24.03.2022
    //   # Added New Tab - COGS Allocation
    //   # Moved Fields under COGS Allocation - Estimated Energy
    //                                        - Estimated Water Consumption
    //                                        - Other Variable Expenses
    //                                        - Production Fix Expenses



    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the work center.', FRA = 'Indique le numéro du poste de charge.';
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the name of the work center.', FRA = 'Indique le nom du centre de charge.';
        }
        modify("Work Center Group Code")
        {
            ToolTipML = ENU = 'Specifies the work center group, if the work center or underlying machine center is assigned to a work center group.', FRA = 'Spécifie le groupe de centres de charge auquel le centre de charge ou le poste de charge sous-jacent a éventuellement été affecté.';
        }
        modify("Alternate Work Center")
        {
            ToolTipML = ENU = 'Specifies an alternate work center.', FRA = 'Spécifie un autre centre de charge.';
        }
        modify("Search Name")
        {
            ToolTipML = ENU = 'Specifies the search name for the work center.', FRA = 'Spécifie le nom de recherche du centre de charge.';
        }
        modify(Blocked)
        {
            ToolTipML = ENU = 'Specifies whether the work center account is blocked.', FRA = 'Indique si le compte du centre de charge est bloqué.';
        }
        modify("Last Date Modified")
        {
            ToolTipML = ENU = 'Specifies when the work center card was last modified.', FRA = 'Indique la date à laquelle la fiche centre de charge a été modifiée pour la dernière fois.';
        }
        modify(Posting)
        {
            CaptionML = ENU = 'Posting', FRA = 'Validation';
        }
        modify("Direct Unit Cost")
        {
            ToolTipML = ENU = 'Specifies the direct unit cost of the work center at one unit of measure.', FRA = 'Spécifie le coût unitaire d''achat du centre de charge pour une unité de mesure.';
        }
        modify("Indirect Cost %")
        {
            ToolTipML = ENU = 'Specifies the indirect costs of the work center, in percent.', FRA = 'Spécifie les coûts indirects du centre de charge, exprimés en pourcentage.';
        }
        modify("Overhead Rate")
        {
            ToolTipML = ENU = 'Specifies the overhead rate of this work center.', FRA = 'Spécifie les frais généraux du centre de charge.';
        }
        modify("Unit Cost")
        {
            ToolTipML = ENU = 'Specifies the unit cost at one unit of measure for the machine center.', FRA = 'Spécifie le coût unitaire à une unité de mesure pour le poste de charge.';
        }
        modify("Unit Cost Calculation")
        {
            ToolTipML = ENU = 'Specifies the unit cost calculation that is to be made.', FRA = 'Indique le calcul du coût unitaire à effectuer.';
        }
        modify("Specific Unit Cost")
        {
            ToolTipML = ENU = 'Specifies where to define the unit costs.', FRA = 'Spécifie où définir les coûts unitaires.';
        }
        modify("Global Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the work center.', FRA = 'Spécifie le code section analytique lié au centre de charge.';
        }
        modify("Global Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code that the work center is linked to.', FRA = 'Spécifie le code raccourci section analytique auquel le centre de charge est lié.';
        }
        modify("Subcontractor No.")
        {
            ToolTipML = ENU = 'Specifies the number of a subcontractor who supplies this work center.', FRA = 'Spécifie le numéro d''un sous-traitant qui approvisionne ce centre de charge.';
        }
        modify("Flushing Method")
        {
            ToolTipML = ENU = 'Specifies the method to use to calculate the output quantity at this work center.', FRA = 'Spécifie la méthode pour calculer la quantité produite de ce centre de charge.';
        }
        modify("Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies a general product posting group.', FRA = 'Spécifie un groupe comptabilisation produit.';
        }
        modify(Scheduling)
        {
            CaptionML = ENU = 'Scheduling', FRA = 'Planification';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies a unit for production at the work center.', FRA = 'Spécifie une unité pour la fabrication dans ce centre de charge.';
        }
        modify(Capacity)
        {
            ToolTipML = ENU = 'Specifies the capacity of the work center.', FRA = 'Indique la capacité du centre de charge.';
        }
        modify(Efficiency)
        {
            ToolTipML = ENU = 'Specifies the efficiency factor as a percentage of the work center.', FRA = 'Spécifie le facteur de rendement (en pourcentage) du centre de charge.';
        }
        modify("Consolidated Calendar")
        {
            ToolTipML = ENU = 'Specifies whether the consolidated calendar is used.', FRA = 'Indique si le calendrier consolidé est utilisé.';
        }
        modify("Shop Calendar Code")
        {
            ToolTipML = ENU = 'Specifies the shop calendar code that the planning of this work center refers to.', FRA = 'Spécifie le code calendrier usine auquel le planning du centre de charge fait référence.';
        }
        modify("Queue Time")
        {
            ToolTipML = ENU = 'Specifies the queue time of the work center.', FRA = 'Indique la file d''attente du centre de charge.';
        }
        modify("Queue Time Unit of Meas. Code")
        {
            ToolTipML = ENU = 'Specifies the queue time unit of measure code.', FRA = 'Spécifie le code unité de mesure de la file d''attente.';
        }
        modify(Warehouse)
        {
            CaptionML = ENU = 'Warehouse', FRA = 'Entrepôt';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location where the work center operates by default.', FRA = 'Spécifie le magasin où le centre de charge fonctionne par défaut.';
        }
        modify("Open Shop Floor Bin Code")
        {
            ToolTipML = ENU = 'Specifies the bin that functions as the default open shop floor bin at the work center.', FRA = 'Spécifie l''emplacement qui fonctionne comme emplacement atelier ouvert par défaut dans le centre de charge.';
        }
        modify("To-Production Bin Code")
        {
            ToolTipML = ENU = 'Specifies the bin in the production area where components that are picked for production are placed by default before they can be consumed.', FRA = 'Spécifie l''emplacement dans la zone de production où les composants qui sont prélevés pour la production sont stockés par défaut avant de pouvoir être consommés.';
        }
        modify("From-Production Bin Code")
        {
            ToolTipML = ENU = 'Specifies the bin in the production area where finished end items are taken by default when the process involves warehouse activity.', FRA = 'Spécifie l''emplacement dans la zone de production où les produits finis sont extraits par défaut si le processus implique l''activité entrepôt.';
        }
        /* //BCUPGRADE YADAVM09 Drink it field commented>>
        addafter("Search Name")
        {
            field(Bottleneck;Bottleneck)
            {
                Description = 'MANXL7.00.001';
            }
            field("Scrap Code";"Scrap Code")
            {
            }
            field("Max. Scrap %";"Max. Scrap %")
            {
            }
        }
        *///BCUPGRADE YADAVM09 Drink it field commented<<
        addafter("Last Date Modified")
        {
            field("Batch sequential number"; Rec."Batch sequential number FND")
            {
                ApplicationArea = All;
            }
        }
        //BC Upgrade kamnay01 >>make field visible true
        addafter("Gen. Prod. Posting Group")
        {
            field("Partial Output"; Rec."Partial Output FND")
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
        //BC upgrade Kamnay01 << make field visible true
        /* BCUPGRADE YADAVM09 Drink it Field Commented>>
        addafter("Queue Time Unit of Meas. Code")
        {
            field(Planning;Rec.Planning)
            {
                Description = 'MANXL7.00.001';
            }
        }
         */// BCUPGRADE YADAVM09 Drink it Field Commented>>
        addafter(Warehouse)
        {
            group("COGS Allocation")
            {
                CaptionML = ENU = 'COGS Allocation',
                            FRA = 'Entrepôt';
                field("Estimated Energy"; Rec."Estimated Energy FND")
                {
                    ApplicationArea = All;
                }
                field("Estimated Water Consumption"; Rec."Estimated Water Consmp. FND")
                {
                    ApplicationArea = All;
                }
                field("Other Variable Expenses"; Rec."Other Variable Expenses FND")
                {
                    ApplicationArea = All;
                }
                field("Production Fix Expenses"; Rec."Production Fix Expenses FND")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        modify("Wor&k Ctr.")
        {
            CaptionML = ENU = 'Wor&k Ctr.', FRA = '&Centre ch.';
        }
        modify("Capacity Ledger E&ntries")
        {
            CaptionML = ENU = 'Capacity Ledger E&ntries', FRA = 'Écritures comptables c&apacité';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify("Lo&ad")
        {
            CaptionML = ENU = 'Lo&ad', FRA = 'C&harge';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        }
        modify("Pla&nning")
        {
            CaptionML = ENU = 'Pla&nning', FRA = 'Pla&nning';
        }
        modify("&Calendar")
        {
            CaptionML = ENU = '&Calendar', FRA = '&Calendrier';
        }
        modify("A&bsence")
        {
            CaptionML = ENU = 'A&bsence', FRA = '&Indisponibilité';
        }
        modify("Ta&sk List")
        {
            CaptionML = ENU = 'Ta&sk List', FRA = '&Liste des tâches';
        }
        modify("Subcontractor - Dispatch List")
        {
            CaptionML = ENU = 'Subcontractor - Dispatch List', FRA = 'S/traitant - Liste expédition';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

