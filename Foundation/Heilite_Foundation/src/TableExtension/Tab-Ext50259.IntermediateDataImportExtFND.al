tableextension 50259 IntermediateDataImportExtFND extends "Intermediate Data Import"
{
    // version NAVW110.0,HEI.01

    fields
    {
        modify(ID)
        {
            CaptionML = ENU = 'ID', FRA = 'ID';
        }
        modify("Data Exch. No.")
        {
            CaptionML = ENU = 'Data Exch. No.', FRA = 'N° échange données';
        }
        modify("Table ID")
        {
            CaptionML = ENU = 'Table ID', FRA = 'ID table';
        }
        modify("Record No.")
        {
            CaptionML = ENU = 'Record No.', FRA = 'Nombre enregistrements';
        }
        modify("Field ID")
        {
            CaptionML = ENU = 'Field ID', FRA = 'ID champ';
        }
        modify(Value)
        {
            CaptionML = ENU = 'Value', FRA = 'Valeur';
        }
        modify("Validate Only")
        {
            CaptionML = ENU = 'Validate Only', FRA = 'Valider uniquement';
        }
        modify("Parent Record No.")
        {
            CaptionML = ENU = 'Parent Record No.', FRA = 'N° enregistrement parent';
        }
        field(50000; "Big Value FND"; BLOB)
        {
            Caption = 'Big Value';
            Description = 'HEI.01';
        }
    }
    keys
    {
        key(Key50000; "Data Exch. No.", "Record No.", "Table ID", "Field ID")  // BC Upgrade NANDIS03 - Key id changed to 50000 from 1
        {
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

