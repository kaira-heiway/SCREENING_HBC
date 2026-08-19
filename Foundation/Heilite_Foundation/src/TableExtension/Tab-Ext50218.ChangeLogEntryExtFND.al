tableextension 50218 ChangeLogEntryExtFND extends "Change Log Entry"
{
    //   HEI.01 CHG2229002 IBM SAMANR01 28.11.2023 - Remove dynamic and FlowFields from the Change Log Entry Page/Table
    //     # Disabled  below flow field
    //       "Table Caption"
    //       "Field Caption"
    //       "Primary Key Field 1 Caption"
    //       "Primary Key Field 2 Caption"
    //       "Primary Key Field 3 Caption"

    // BC Upgrade KUMARS145 Table Ectension 

    fields
    {
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify("Date and Time")
        {
            CaptionML = ENU = 'Date and Time', FRA = 'Date et heure';
        }
        modify(Time)
        {
            CaptionML = ENU = 'Time', FRA = 'Heure';
        }
        modify("User ID")
        {
            CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
        }
        modify("Table No.")
        {
            CaptionML = ENU = 'Table No.', FRA = 'N° table';
        }
        modify("Table Caption")
        {
            CaptionML = ENU = 'Table Caption', FRA = 'Légende table';
            //Unsupported feature: Change Enabled on ""Table Caption"(Field 6)". Please convert manually.
        }
        modify("Field No.")
        {
            CaptionML = ENU = 'Field No.', FRA = 'N° champ';
        }
        modify("Field Caption")
        {
            CaptionML = ENU = 'Field Caption', FRA = 'Légende champ';
            //Unsupported feature: Change Enabled on ""Field Caption"(Field 8)". Please convert manually.
        }
        modify("Type of Change")
        {
            CaptionML = ENU = 'Type of Change', FRA = 'Type modification';
            //OptionCaptionML = ENU = 'Insertion,Modification,Deletion', FRA = 'Insertion,Modification,Suppression';
        }
        modify("Old Value")
        {
            CaptionML = ENU = 'Old Value', FRA = 'Ancienne valeur';
        }
        modify("New Value")
        {
            CaptionML = ENU = 'New Value', FRA = 'Nouvelle valeur';
        }
        modify("Primary Key")
        {
            CaptionML = ENU = 'Primary Key', FRA = 'Clé primaire';
        }
        modify("Primary Key Field 1 No.")
        {
            CaptionML = ENU = 'Primary Key Field 1 No.', FRA = 'N° champ clé primaire 1';
        }
        modify("Primary Key Field 1 Caption")
        {
            CaptionML = ENU = 'Primary Key Field 1 Caption', FRA = 'Légende du champ clé primaire 1';
            //Unsupported feature: Change Enabled on ""Primary Key Field 1 Caption"(Field 14)". Please convert manually.
        }
        modify("Primary Key Field 1 Value")
        {
            CaptionML = ENU = 'Primary Key Field 1 Value', FRA = 'Valeur champ clé primaire 1';
        }
        modify("Primary Key Field 2 No.")
        {
            CaptionML = ENU = 'Primary Key Field 2 No.', FRA = 'N° champ clé primaire 2';
        }
        modify("Primary Key Field 2 Caption")
        {
            CaptionML = ENU = 'Primary Key Field 2 Caption', FRA = 'Légende du champ clé primaire 2';
            //Unsupported feature: Change Enabled on ""Primary Key Field 2 Caption"(Field 17)". Please convert manually.
        }
        modify("Primary Key Field 2 Value")
        {
            CaptionML = ENU = 'Primary Key Field 2 Value', FRA = 'Valeur champ clé primaire 2';
        }
        modify("Primary Key Field 3 No.")
        {
            CaptionML = ENU = 'Primary Key Field 3 No.', FRA = 'N° champ clé primaire 3';
        }
        modify("Primary Key Field 3 Caption")
        {
            CaptionML = ENU = 'Primary Key Field 3 Caption', FRA = 'Légende du champ clé primaire 3';
            //Unsupported feature: Change Enabled on ""Primary Key Field 3 Caption"(Field 20)". Please convert manually.
        }
        modify("Primary Key Field 3 Value")
        {
            CaptionML = ENU = 'Primary Key Field 3 Value', FRA = 'Valeur champ clé primaire 3';
        }
        modify("Record ID")
        {
            CaptionML = ENU = 'Record ID', FRA = 'ID d''enregistrement';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.
    //Unsupported feature: PropertyChange. Please convert manually.
    //Unsupported feature: PropertyChange. Please convert manually.

}

