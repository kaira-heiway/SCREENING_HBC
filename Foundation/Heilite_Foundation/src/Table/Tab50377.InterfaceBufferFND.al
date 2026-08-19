table 50377 "Interface Buffer FND"
{
    // Heilite Navision Old Id - 50030
    // version HEI.01
    // HNK 100390 MRA-IBM 19/09/16: New table
    
    // BC Upgrade PATELP08>>
    // Moved table from Interface to Foundation Ext.
    // Changes name of table from "Interface Buffer" to "Interface Buffer FND"
    // BC Upgrade PATELP08<<

    fields
    {
        field(1; "Entry No."; Integer)
        {
            CaptionML = ENU = 'Entry No.',
                        ESP = 'Nº mov.',
                        FRA = 'N° écriture';
        }
        field(4; Text; Text[250])
        {
            CaptionML = DEU = 'Text',
                        ENU = 'Text';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

