pageextension 51170 SalespersonsPurchasersExtCBN extends "Salespersons/Purchasers"
{
    // version NAVW110.0,DITW110.00.08
    //     DITW15.00.00.39 DDR 09/05/2011 issue 1328 Shop (iPos) Functionnalities
    //                                  Added fields "Pos System","POS System Timestamp","Pos Shop Code","Language Code"
    //                                  Added menu "Pos Relations","SOM Synchronize"

    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1

    // HEI.01 FDD-SR_HT543a IBM HORTOC01 01.07.2019 # new action "Sales Rep Budgets/Targets"

    // BC Upgrade SHUKLPO3 >>
    // DrinkIT code is blocked.

    // BC Upgrade SHUKLPO3 <<



    layout
    {
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies the code of the record.', FRA = 'Spécifie le code de l''enregistrement.';
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the name of the record.', FRA = 'Spécifie le nom de l''enregistrement.';
        }
        modify("Commission %")
        {
            ToolTipML = ENU = 'Specifies the percentage to use to calculate the salesperson''s commission.', FRA = 'Spécifie le pourcentage à utiliser pour calculer la commission du vendeur.';
        }
        modify("Phone No.")
        {
            ToolTipML = ENU = 'Specifies the salesperson''s or purchaser''s telephone number.', FRA = 'Spécifie le numéro de téléphone du vendeur ou de l''acheteur.';
        }

        // BC Upgrade SHUKLP03 << DrinkIT fields are blocked.
        // addafter("Phone No.")
        // {
        //     field("Language Code";"Language Code")
        //     {
        //         Visible = false;
        //     }
        //     field("Pos System";"Pos System")
        //     {
        //         Lookup = false;
        //         Visible = false;
        //     }
        //     field("Pos System Timestamp";"Pos System Timestamp")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Pos Shop Code";"Pos Shop Code")
        //     {
        //         Visible = false;

        //         trigger OnDrillDown();
        //         begin
        //             DrillDownPosCodes();
        //         end;
        //     }
        // }
        // BC Upgrade SHUKLP03 << DrinkIT fields are blocked.
    }
    actions
    {
        modify("&Salesperson")
        {
            CaptionML = ENU = '&Salesperson', FRA = '&Vendeur';
        }
        modify("Tea&ms")
        {
            CaptionML = ENU = 'Tea&ms', FRA = '&Equipes';
        }
        modify("Con&tacts")
        {
            CaptionML = ENU = 'Con&tacts', FRA = 'C&ontacts';
            ToolTipML = ENU = 'View a list of contacts that are associated with the salesperson/purchaser.', FRA = 'Affichez une liste des contacts associés au vendeur/acheteur.';
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
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
            ToolTipML = ENU = 'View statistical information, such as the value of posted entries, for the record.', FRA = 'Affichez les informations statistiques telles que la valeur des écritures validées pour l''enregistrement.';
        }
        modify("C&ampaigns")
        {
            CaptionML = ENU = 'C&ampaigns', FRA = 'C&ampagnes';
        }
        modify("S&egments")
        {
            CaptionML = ENU = 'S&egments', FRA = 'Se&gments';
            ToolTipML = ENU = 'View a list of all segments.', FRA = 'Affichez la liste de tous les segments.';
        }
        modify("Interaction Log E&ntries")
        {
            CaptionML = ENU = 'Interaction Log E&ntries', FRA = 'Écritures jour&nal interaction';
            ToolTipML = ENU = 'View a list of the interactions that you have logged, for example, when you create an interaction, print a cover sheet, a sales order, and so on.', FRA = 'Visualisez la liste des interactions que vous enregistrez lorsque, par exemple, vous créez une interaction, imprimez un bordereau d''envoi, une commande vente, etc.';
        }
        modify("Postponed &Interactions")
        {
            CaptionML = ENU = 'Postponed &Interactions', FRA = '&Interactions reportées';
            ToolTipML = ENU = 'View postponed interactions for the salesperson/purchaser.', FRA = 'Affichez les interactions reportées du vendeur/de l''acheteur.';
        }
        modify("Oppo&rtunities")
        {
            CaptionML = ENU = 'Oppo&rtunities', FRA = 'Oppo&rtunités';
        }
        modify(ActionGroupCRM)
        {
            CaptionML = ENU = 'Dynamics CRM', FRA = 'Dynamics CRM';
        }
        modify(CRMGotoSystemUser)
        {
            CaptionML = ENU = 'User', FRA = 'Utilisateur';
            ToolTipML = ENU = 'Open the coupled Microsoft Dynamics CRM system user.', FRA = 'Ouvrez l''utilisateur système Microsoft Dynamics CRM couplé.';
        }
        modify(CRMSynchronizeNow)
        {
            CaptionML = ENU = 'Synchronize Now', FRA = 'Synchroniser maintenant';
            ToolTipML = ENU = 'Send or get updated data to or from Microsoft Dynamics CRM.', FRA = 'Envoyez/recevez des données mises à jour à/de Microsoft Dynamics CRM.';
        }
        modify(ManageCRMCoupling)
        {
            CaptionML = ENU = 'Set Up Coupling', FRA = 'Configurer le couplage';
            ToolTipML = ENU = 'Create or modify the coupling to a Microsoft Dynamics CRM user.', FRA = 'Créez ou modifiez le couplage avec un utilisateur Microsoft Dynamics CRM.';
        }
        modify(DeleteCRMCoupling)
        {
            CaptionML = ENU = 'Delete Coupling', FRA = 'Supprimer le couplage';
            ToolTipML = ENU = 'Delete the coupling to a Microsoft Dynamics CRM user.', FRA = 'Supprimez le couplage avec un utilisateur Microsoft Dynamics CRM.';
        }
        modify(CreateInteraction)
        {
            CaptionML = ENU = 'Create &Interaction', FRA = 'Créer &Interaction';
            ToolTipML = ENU = 'Use a batch job to help you create interactions for the involved salespeople or purchasers.', FRA = 'Utilisez un traitement par lots pour créer des interactions pour les vendeurs et acheteurs concernés.';
        }
        addafter("Con&tacts")
        {
            action("Sales Rep Budgets/Targets")
            {
                Caption = 'Sales Rep Budgets/Targets';
                Description = 'HEI.01';
                Image = Allocate;
                RunObject = Page "SalesRepTarget/BudgetCBN";
                RunPageLink = "Sales Person Code" = FIELD(Code);
                ApplicationArea = All;
                ToolTip = 'Executes the Sales Rep Budgets/Targets action.';
            }
        }

        // BC Upgrade SHUKLP03 >> Blocked because DrinkIT object Page "Pos Salesperson Relations" is used.
        // addafter("Oppo&rtunities")
        // {
        //     separator(Separator1100576006)
        //     {
        //     }

        // action("Pos Relations")
        // {
        //     CaptionML = ENU = 'Pos Relations',
        //                 FRA = 'Relations Pos';
        //     Image = Relationship;
        //     RunObject = Page "Pos Salesperson Relations";
        //     RunPageLink = "Salesperson Code" = FIELD(Code);
        // }
        // BC Upgrade SHUKLP03 >> Blocked because DrinkIT object Page "Pos Salesperson Relations" is used.

        // BC Upgrade SHUKLP03 >> Blocked because DrinkIT proceduer Salesperson.SomSynchronize() is used.
        // action("SOM Synchronize")
        // {
        //     CaptionML = ENU = 'SOM Synchronize',
        //                 FRA = 'Synchronisation SOM';
        //     Image = Reconcile;

        //     trigger OnAction();
        //     var
        //         Salesperson: Record "Salesperson/Purchaser";
        //     begin
        //         CurrPage.SETSELECTIONFILTER(Salesperson);
        //         Salesperson.SomSynchronize();
        //     end;
        // }
        // BC Upgrade SHUKLP03 >> Blocked because DrinkIT proceduer Salesperson.SomSynchronize() is used.
        //}
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

