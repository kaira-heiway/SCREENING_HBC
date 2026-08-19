tableextension 50266 DataExchMappingExtFND extends "Data Exch. Mapping"
{
    // version NAVW110.0,HEI.01
    // HEI.01 FDD-GAPID001 IBM LAZARE02 30.08.2017 # Fix bug to delete only field mappings for current line def., not for all def.
    // BC Upgrade NANDIS03 - HEI.01 code is added in standard BC, so not adding the filter
    // BC Upgrade PATELP08 >>
    // Changed table ext name from "DataExchMappingExt" to "DataExchMappingExtFND"
    // BC Upgrade PATELP08 <<
    fields
    {
        modify("Data Exch. Def Code")
        {
            CaptionML = ENU = 'Data Exch. Def Code', FRA = 'Code déf. échange données';
        }
        modify("Table ID")
        {

            //Unsupported feature: Change TableRelation on ""Table ID"(Field 2)". Please convert manually.

            CaptionML = ENU = 'Table ID', FRA = 'ID table';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Mapping Codeunit")
        {

            //Unsupported feature: Change TableRelation on ""Mapping Codeunit"(Field 4)". Please convert manually.

            CaptionML = ENU = 'Mapping Codeunit', FRA = 'Correspondance Codeunit';
        }
        modify("Data Exch. No. Field ID")
        {

            //Unsupported feature: Change TableRelation on ""Data Exch. No. Field ID"(Field 6)". Please convert manually.

            CaptionML = ENU = 'Data Exch. No. Field ID', FRA = 'ID champ n° échange données';
        }
        modify("Data Exch. Line Field ID")
        {

            //Unsupported feature: Change TableRelation on ""Data Exch. Line Field ID"(Field 7)". Please convert manually.

            CaptionML = ENU = 'Data Exch. Line Field ID', FRA = 'ID champ Ligne échange données';
        }
        modify("Data Exch. Line Def Code")
        {

            //Unsupported feature: Change TableRelation on ""Data Exch. Line Def Code"(Field 8)". Please convert manually.

            CaptionML = ENU = 'Data Exch. Line Def Code', FRA = 'Code déf. ligne échange données';
        }
        modify("Pre-Mapping Codeunit")
        {

            //Unsupported feature: Change TableRelation on ""Pre-Mapping Codeunit"(Field 9)". Please convert manually.

            CaptionML = ENU = 'Pre-Mapping Codeunit', FRA = 'Codeunit pré-mappage';
        }
        modify("Post-Mapping Codeunit")
        {

            //Unsupported feature: Change TableRelation on ""Post-Mapping Codeunit"(Field 10)". Please convert manually.

            CaptionML = ENU = 'Post-Mapping Codeunit', FRA = 'Codeunit post-mappage';
        }
        modify("Use as Intermediate Table")
        {
            CaptionML = ENU = 'Use as Intermediate Table', FRA = 'Utiliser comme table intermédiaire';
        }
    }

    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DataExchFieldMapping.SETRANGE("Data Exch. Def Code","Data Exch. Def Code");
    DataExchFieldMapping.SETRANGE("Table ID","Table ID");
    DataExchFieldMapping.DELETEALL;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DataExchFieldMapping.SETRANGE("Data Exch. Def Code","Data Exch. Def Code");
    //HEI.01>>
    DataExchFieldMapping.SETRANGE("Data Exch. Line Def Code","Data Exch. Line Def Code");
    //HEI.01<<
    DataExchFieldMapping.SETRANGE("Table ID","Table ID");
    DataExchFieldMapping.DELETEALL;
    */
    //end;


    //Unsupported feature: CodeModification on "OnRename". Please convert manually.

    //trigger OnRename();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF HasFieldMappings THEN
      ERROR(RenameErr);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if HasFieldMappings then
      ERROR(RenameErr);
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "RecordNameFormatTok(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //RecordNameFormatTok : ENU=%1 to %2;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //RecordNameFormatTok : ENU=%1 to %2;FRA=%1 au %2;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "RenameErr(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //RenameErr : ENU=You cannot rename the record if one or more field mapping lines exist.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //RenameErr : ENU=You cannot rename the record if one or more field mapping lines exist.;FRA=Vous ne pouvez pas renommer l'enregistrement s'il existe une ou plusieurs lignes de correspondance de champ.;
    //Variable type has not been exported.
}

