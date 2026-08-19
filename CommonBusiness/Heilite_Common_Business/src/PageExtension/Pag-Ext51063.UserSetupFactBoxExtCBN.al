pageextension 51063 UserSetupFactBoxExtCBN extends "User Setup FactBox"
{
    // version NAVW110.0

    layout
    {
        modify("Allow Posting From")
        {
            ToolTipML = ENU = 'Specifies the earliest date on which the user is allowed to post to the company.', FRA = 'Spécifie la première date à laquelle l''utilisateur est autorisé à valider dans la société.';
        }
        modify("Allow Posting To")
        {
            ToolTipML = ENU = 'Specifies the last date on which the user is allowed to post to the company.', FRA = 'Spécifie la dernière date à laquelle l''utilisateur est autorisé à valider dans la société.';
        }
        modify("Register Time")
        {
            ToolTipML = ENU = 'Specifies whether to register the user''s time usage defined as the time spent from when the user logs in to when the user logs out.', FRA = 'Spécifie s''il faut enregistrer le temps d''utilisation de l''utilisateur défini comme le temps passé entre la connexion de l''utilisateur et sa déconnexion.';
        }
        modify("Time Sheet Admin.")
        {
            ToolTipML = ENU = 'Specifies if a user is a time sheet administrator. A time sheet administrator can access any time sheet and then edit, change, or delete it.', FRA = 'Indique si un utilisateur est un administrateur de feuille de temps. Un tel administrateur a accès à toute feuille de temps et peut la modifier, la remplacer ou la supprimer.';
        }
    }

    //Unsupported feature: PropertyChange. Please convert manually.

}

