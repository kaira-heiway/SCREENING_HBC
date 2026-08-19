pageextension 54001 WorkCenterListExt extends "Work Center List"
{
    // version NAVW110.0.00.16177,HEI.01

    //     HEI.01 FDD- GAPID-001 IBM.NAIKH01 :
    //   # Added a new Fiels "Partial Output"



    layout
    {
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the work center.', FRA = 'Indique le numéro du poste de charge.';
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the name of the work center.', FRA = 'Indique le nom du centre de charge.';
        }
        modify("Alternate Work Center")
        {
            ToolTipML = ENU = 'Specifies an alternate work center.', FRA = 'Spécifie un autre centre de charge.';
        }
        modify("Work Center Group Code")
        {
            ToolTipML = ENU = 'Specifies the work center group, if the work center or underlying machine center is assigned to a work center group.', FRA = 'Spécifie le groupe de centres de charge auquel le centre de charge ou le poste de charge sous-jacent a éventuellement été affecté.';
        }
        modify("Global Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code linked to the work center.', FRA = 'Spécifie le code section analytique lié au centre de charge.';
        }
        modify("Global Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code that the work center is linked to.', FRA = 'Spécifie le code raccourci section analytique auquel le centre de charge est lié.';
        }
        modify("Direct Unit Cost")
        {
            ToolTipML = ENU = 'Specifies the direct unit cost of the work center at one unit of measure.', FRA = 'Spécifie le coût unitaire d''achat du centre de charge pour une unité de mesure.';
        }
        modify("Indirect Cost %")
        {
            ToolTipML = ENU = 'Specifies the indirect costs of the work center, in percent.', FRA = 'Spécifie les coûts indirects du centre de charge, exprimés en pourcentage.';
        }
        modify("Unit Cost")
        {
            ToolTipML = ENU = 'Specifies the unit cost at one unit of measure for the machine center.', FRA = 'Spécifie le coût unitaire à une unité de mesure pour le poste de charge.';
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
        modify("Maximum Efficiency")
        {
            ToolTipML = ENU = 'Specifies the maximum efficiency factor of the work center.', FRA = 'Indique le facteur de rendement maximum du centre de charge.';
        }
        modify("Minimum Efficiency")
        {
            ToolTipML = ENU = 'Specifies the minimum efficiency factor of the work center.', FRA = 'Indique le facteur de rendement minimum du centre de charge.';
        }
        modify("Simulation Type")
        {
            ToolTipML = ENU = 'Specifies the simulation type for the work center.', FRA = 'Spécifie le mode de replanification du centre de charge.';
        }
        modify("Shop Calendar Code")
        {
            ToolTipML = ENU = 'Specifies the shop calendar code that the planning of this work center refers to.', FRA = 'Spécifie le code calendrier usine auquel le planning du centre de charge fait référence.';
        }
        modify("Search Name")
        {
            ToolTipML = ENU = 'Specifies the search name for the work center.', FRA = 'Spécifie le nom de recherche du centre de charge.';
        }
        modify("Overhead Rate")
        {
            ToolTipML = ENU = 'Specifies the overhead rate of this work center.', FRA = 'Spécifie les frais généraux du centre de charge.';
        }
        modify("Last Date Modified")
        {
            ToolTipML = ENU = 'Specifies when the work center card was last modified.', FRA = 'Indique la date à laquelle la fiche centre de charge a été modifiée pour la dernière fois.';
        }
        modify("Flushing Method")
        {
            ToolTipML = ENU = 'Specifies the method to use to calculate the output quantity at this work center.', FRA = 'Spécifie la méthode pour calculer la quantité produite de ce centre de charge.';
        }
        modify("Subcontractor No.")
        {
            ToolTipML = ENU = 'Specifies the number of a subcontractor who supplies this work center.', FRA = 'Spécifie le numéro d''un sous-traitant qui approvisionne ce centre de charge.';
        }
        addafter("Subcontractor No.")
        {
            field("Partial Output"; Rec."Partial Output FND")
            {
                ApplicationArea = All;
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
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
        }
        modify("Dimensions-Single")
        {
            CaptionML = ENU = 'Dimensions-Single', FRA = 'Affectations - Simples';
            ToolTipML = ENU = 'View or edit the single set of dimensions that are set up for the selected record.', FRA = 'Affichez ou modifiez l''ensemble unique de dimensions paramétrées pour l''enregistrement sélectionné.';
        }
        modify("Dimensions-&Multiple")
        {
            CaptionML = ENU = 'Dimensions-&Multiple', FRA = 'Affectations - &Multiples';
            ToolTipML = ENU = 'View or edit dimensions for a group of records. You can assign dimension codes to transactions to distribute costs and analyze historical information.', FRA = 'Affichez ou modifiez les axes analytiques pour un groupe d''enregistrements. Vous pouvez affecter des codes axe aux transactions dans le but de répartir les coûts et d''analyser les informations d''historique.';
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
        modify("Calculate Work Center Calendar")
        {
            CaptionML = ENU = 'Calculate Work Center Calendar', FRA = 'Calculer calendrier centre ch.';
        }
        /*         modify("Work Center List")
                {
                    CaptionML = ENU = 'Work Center List', FRA = 'Liste des centres de charge';
                }
                modify("Work Center Load")
                {
                    CaptionML = ENU = 'Work Center Load', FRA = 'Charge centre de charge';
                }
                modify("Work Center Load/Bar")
                {
                    CaptionML = ENU = 'Work Center Load/Bar', FRA = 'Charge centre de charge/Barre';
                } */ //BCUPG
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

