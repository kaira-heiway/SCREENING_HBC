tableextension 58006 XMLBufferExtINT extends "XML Buffer"
{
    // version NAVW110.0,HEI.01
    // HEI.01 CHG2095189 IBM SAXENA03 27.01.2021
    //   # Code written for Sales Order optimizaiton
    //   # Executed Query object 50007 from Function CountChildElements() & CountAttributes()
    fields
    {
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            OptionCaptionML = ENU = ' ,Element,Attribute', FRA = ' ,Élément,Attribut';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify(Path)
        {
            CaptionML = ENU = 'Path', FRA = 'Chemin';
        }
        modify(Value)
        {
            CaptionML = ENU = 'Value', FRA = 'Valeur';
        }
        modify(Depth)
        {
            CaptionML = ENU = 'Depth', FRA = 'Profondeur';
        }
        modify("Parent Entry No.")
        {
            CaptionML = ENU = 'Parent Entry No.', FRA = 'N° séquence parent';
        }
        modify("Data Type")
        {
            CaptionML = ENU = 'Data Type', FRA = 'Type de données';
            OptionCaptionML = ENU = 'Text,Date,Decimal,DateTime', FRA = 'Texte,Date,Décimale,DateHeure';
        }
        modify("Node Number")
        {
            CaptionML = ENU = 'Node Number', FRA = 'Numéro noud';
        }
        modify(Namespace)
        {
            CaptionML = ENU = 'Namespace', FRA = 'Espace de noms';
        }
        modify("Import ID")
        {
            CaptionML = ENU = 'Import ID', FRA = 'ID importation';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

    var
        FindXMLBufferCount: Query "Find XML Buffer Count";

}

