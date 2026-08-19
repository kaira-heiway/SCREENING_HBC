tableextension 50083 FADateTypeFND extends "FA Date Type"
{
    // HEI.01 FDD-HT584 IBM NASTAA02 02.09.2019 # La Reunion FA Derogatory Depreciation
    //   # Code added in function "CreateTypes"
    // HEI.02 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # Code added in function "CreateTypes"
    // version NAVW17.00

    fields
    {
        modify("FA Date Type No.")
        {
            CaptionML = ENU = 'FA Date Type No.', FRA = 'N° type date immo.';
        }
        modify("FA Date Type Name")
        {
            CaptionML = ENU = 'FA Date Type Name', FRA = 'Nom type date immo.';
        }
        modify("FA Entry")
        {
            CaptionML = ENU = 'FA Entry', FRA = 'Ecriture immo.';
        }
        modify("G/L Entry")
        {
            CaptionML = ENU = 'G/L Entry', FRA = 'Ecriture comptable';
        }
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

    var
        CompanyInfo: Record "Company Information";
}

