tableextension 50249 DataExchColumnDefExtFND extends "Data Exch. Column Def"
{
    // version NAVW110.0,HEI.01
    // HEI.01 CC CHG2236214 IBM BHANDS01 22.01.2024 Outbound interfaces are impacted by date format changes when Job Queues are restarted
    //   # Issue with LSR Interfaces in Bahamas
    //   # Created a new field "Ignore User Format Culture"

    // BC Upgrade MISHRS14 >>
    // Changed table extension name to "DataExchColumnDefExtFND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<
    
    fields
    {
        modify("Data Exch. Def Code")
        {
            CaptionML = ENU = 'Data Exch. Def Code', FRA = 'Code déf. échange données';
        }
        modify("Column No.")
        {
            CaptionML = ENU = 'Column No.', FRA = 'N° colonne';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify(Show)
        {
            CaptionML = ENU = 'Show', FRA = 'Afficher';
        }
        modify("Data Type")
        {
            CaptionML = ENU = 'Data Type', FRA = 'Type de données';
            OptionCaptionML = ENU = 'Text,Date,Decimal,DateTime', FRA = 'Texte,Date,Décimale,DateHeure';
        }
        modify("Data Format")
        {
            CaptionML = ENU = 'Data Format', FRA = 'Format données';
        }
        modify("Data Formatting Culture")
        {
            CaptionML = ENU = 'Data Formatting Culture', FRA = 'Culture mise en forme données';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Description';
        }
        modify("Data Exch. Line Def Code")
        {

            //Unsupported feature: Change TableRelation on ""Data Exch. Line Def Code"(Field 10)". Please convert manually.

            CaptionML = ENU = 'Data Exch. Line Def Code', FRA = 'Code déf. ligne échange données';
        }
        modify(Length)
        {
            CaptionML = ENU = 'Length', FRA = 'Longueur';
        }
        modify(Constant)
        {
            CaptionML = ENU = 'Constant', FRA = 'Fixe';
        }
        modify(Path)
        {
            CaptionML = ENU = 'Path', FRA = 'Chemin';
        }
        modify("Negative-Sign Identifier")
        {
            CaptionML = ENU = 'Negative-Sign Identifier', FRA = 'Identifiant signe négatif';
        }
        modify("Text Padding Required")
        {
            CaptionML = ENU = 'Text Padding Required', FRA = 'Remplissage du texte obligatoire';
        }
        modify("Pad Character")
        {
            CaptionML = ENU = 'Pad Character', FRA = 'Caractère de remplissage';
        }
        //field(17;"Ignore User Format Culture";Boolean)  // BC Upgrade NANDIS03 - standard id is used which is wrong
        field(50000; "Ignore User Format Culture FND"; Boolean)  // BC Upgrade NANDIS03 - standard id is used which is wrong
        {
            Caption = 'Ignore User Format Culture';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DataExchFieldMapping.SETRANGE("Data Exch. Def Code","Data Exch. Def Code");
    DataExchFieldMapping.SETRANGE("Data Exch. Line Def Code","Data Exch. Line Def Code");
    DataExchFieldMapping.SETRANGE("Column No.","Column No.");
    IF NOT DataExchFieldMapping.ISEMPTY THEN
      IF CONFIRM(STRSUBSTNO(DeleteFieldMappingQst,DataExchColumnDef.TABLECAPTION,DataExchFieldMapping.TABLECAPTION)) THEN
        DataExchFieldMapping.DELETEALL
      ELSE
        ERROR('')
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    if not DataExchFieldMapping.ISEMPTY then
      if CONFIRM(STRSUBSTNO(DeleteFieldMappingQst,DataExchColumnDef.TABLECAPTION,DataExchFieldMapping.TABLECAPTION)) then
        DataExchFieldMapping.DELETEALL
      else
        ERROR('')
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "DeleteFieldMappingQst(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DeleteFieldMappingQst : ENU=The %1 that you are about to delete is used for one or more %2, which will also be deleted. \\Do you want to continue?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DeleteFieldMappingQst : ENU=The %1 that you are about to delete is used for one or more %2, which will also be deleted. \\Do you want to continue?;FRA=Le %1 que vous êtes sur le point de supprimer est utilisé pour un ou plusieurs %2, qui seront également supprimés. \\Voulez-vous continuer ?;
    //Variable type has not been exported.
}

