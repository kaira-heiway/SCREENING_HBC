pageextension 51054 JobQueueCategoryListExtCBN extends "Job Queue Category List"
{
    // version NAVW110.0

    layout
    {
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies a code for the category of job queue. You can enter a maximum of 10 characters, both numbers and letters.', FRA = 'Spécifie un code pour la catégorie de file d''attente des travaux. Vous pouvez entrer au maximum 10 caractères, des chiffres et des lettres.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the job queue category. You can enter a maximum of 30 characters, both numbers and letters.', FRA = 'Spécifie une description pour la catégorie de file d''attente des travaux. Vous pouvez entrer au maximum 30 caractères, des chiffres et des lettres.';
        }
    }

    //Unsupported feature: PropertyChange. Please convert manually.

}

