tableextension 50081 FApostingTypeExtFND extends "FA Posting Type"
{
    // HEI.01 FDD-HT584 IBM NASTAA02 02.09.2019 # La Reunion FA Derogatory Depreciation
    //   # Code added in function "CreateTypes"
    // version NAVW17.00

    fields
    {
        modify("FA Posting Type No.")
        {
            CaptionML = ENU = 'FA Posting Type No.', FRA = 'N° type compta. immo.';
        }
        modify("FA Posting Type Name")
        {
            CaptionML = ENU = 'FA Posting Type Name', FRA = 'Nom type compta. immo.';
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

}

