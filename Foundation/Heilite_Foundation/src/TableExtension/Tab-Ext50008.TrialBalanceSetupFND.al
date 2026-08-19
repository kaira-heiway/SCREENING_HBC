tableextension 50008 TrialBalanceSetupExtFND extends "Trial Balance Setup"
{
    // version NAVW110.0

    fields
    {
        modify("Primary Key")
        {
            CaptionML = ENU = 'Primary Key', FRA = 'Clé primaire';
        }
        modify("Account Schedule Name")
        {
            CaptionML = ENU = 'Account Schedule Name', FRA = 'Nom tableau d''analyse';
        }
        modify("Column Layout Name")
        {
            CaptionML = ENU = 'Column Layout Name', FRA = 'Nom présentation colonne';
        }
    }

    //Unsupported feature: PropertyChange. Please convert manually.

}

