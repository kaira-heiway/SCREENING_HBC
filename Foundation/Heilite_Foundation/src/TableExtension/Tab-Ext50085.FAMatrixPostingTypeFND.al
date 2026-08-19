tableextension 50085 FAMatrixPostingTypeExtFND extends "FA Matrix Posting Type"
{
    // HEI.01 FDD-HT584 IBM NASTAA02 02.09.2019 # La Reunion FA Derogatory Depreciation
    //   # Code added in function "CreateTypes"
    // version NAVW17.00

    fields
    {
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify("FA Posting Type Name")
        {
            CaptionML = ENU = 'FA Posting Type Name', FRA = 'Nom type compta. immo.';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

