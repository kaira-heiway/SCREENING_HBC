tableextension 50007 DataExchDefExtFND extends "Data Exch. Def"
{
    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017
    // # New field Interfaces - default Yes on interfaces data exchange definitions
    //# Add new options to Type field: Interface Import, Interface Export
    
    // BC Upgrade MISHRS14 >>
    // Blocked property 'OptionCaptionML' due to warning in field - modify(type).
    // BC Upgrade MISHRS14 <<

    fields
    {
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';

            // BC Upgrade MISHRS14 >>
            // Blocked below property 'OptionCaptionML' because it can only be set on elements of type Option and this will become error in future.
            //OptionCaptionML = ENU = 'Bank Statement Import,Payment Export,Payroll Import,Generic Import,Positive Pay Export,,,,,,Interface Import,Interface Export', FRA = 'Importation relevé bancaire,Exportation paiement,Importation paie,Importation générique,Exportation Positive Pay,,,,,,Interface Import,Interface Export';
            // BC Upgrade MISHRS14 <<

            //Unsupported feature: Change OptionString on "Type(Field 3)". Please convert manually.

        }
        modify("Reading/Writing XMLport")
        {

            //Unsupported feature: Change TableRelation on ""Reading/Writing XMLport"(Field 4)". Please convert manually.

            CaptionML = ENU = 'Reading/Writing XMLport', FRA = 'XMLport lecture/écriture';
        }
        modify("Header Lines")
        {
            CaptionML = ENU = 'Header Lines', FRA = 'Lignes en-tête';
        }
        modify("Header Tag")
        {
            CaptionML = ENU = 'Header Tag', FRA = 'Étiquette en-tête';
        }
        modify("Footer Tag")
        {
            CaptionML = ENU = 'Footer Tag', FRA = 'Étiquette pied de page';
        }
        modify("Column Separator")
        {
            CaptionML = ENU = 'Column Separator', FRA = 'Séparateur de colonnes';
            OptionCaptionML = ENU = ',Tab,Semicolon,Comma,Space', FRA = ',Tabulation,Point-virgule,Virgule,Espace';
        }
        modify("File Encoding")
        {
            CaptionML = ENU = 'File Encoding', FRA = 'Encodage du fichier';
            OptionCaptionML = ENU = 'MS-DOS,UTF-8,UTF-16,WINDOWS', FRA = 'MS-DOS,UTF-8,UTF-16,WINDOWS';
        }
        modify("File Type")
        {
            CaptionML = ENU = 'File Type', FRA = 'Type de fichier';
            OptionCaptionML = ENU = 'Xml,Variable Text,Fixed Text,Json', FRA = 'XML,Texte variable,Texte fixe,Json';
        }
        modify("Ext. Data Handling Codeunit")
        {

            //Unsupported feature: Change TableRelation on ""Ext. Data Handling Codeunit"(Field 14)". Please convert manually.

            CaptionML = ENU = 'Ext. Data Handling Codeunit', FRA = 'Codeunit gestion données ext.';
        }
        modify("Reading/Writing Codeunit")
        {

            //Unsupported feature: Change TableRelation on ""Reading/Writing Codeunit"(Field 15)". Please convert manually.

            CaptionML = ENU = 'Reading/Writing Codeunit', FRA = 'Codeunit lecture/écriture';
        }
        modify("Validation Codeunit")
        {

            //Unsupported feature: Change TableRelation on ""Validation Codeunit"(Field 16)". Please convert manually.

            CaptionML = ENU = 'Validation Codeunit', FRA = 'Codeunit validation';
        }
        modify("Data Handling Codeunit")
        {

            //Unsupported feature: Change TableRelation on ""Data Handling Codeunit"(Field 17)". Please convert manually.

            CaptionML = ENU = 'Data Handling Codeunit', FRA = 'Codeunit gestion données';
        }
        modify("User Feedback Codeunit")
        {

            //Unsupported feature: Change TableRelation on ""User Feedback Codeunit"(Field 18)". Please convert manually.

            CaptionML = ENU = 'User Feedback Codeunit', FRA = 'Codeunit retour utilisateur';
        }
        field(50000; "Interfaces FND"; Boolean)
        {
            Caption = 'Interfaces';
            Description = 'HEI.01';
        }
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DataExchLineDef.SETRANGE("Data Exch. Def Code",Code);
    DataExchLineDef.DELETEALL(TRUE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DataExchLineDef.SETRANGE("Data Exch. Def Code",Code);
    DataExchLineDef.DELETEALL(true);
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Name = '' THEN
      Name := Code;

    CheckPositivePayExportFileType;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if Name = '' then
    #2..4
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "ColumnSeparatorMissingErr(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ColumnSeparatorMissingErr : ENU=Column separator is missing in the definition.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ColumnSeparatorMissingErr : ENU=Column separator is missing in the definition.;FRA=Il manque un séparateur de colonnes dans la définition.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "PositivePayFileTypeErr(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //PositivePayFileTypeErr : ENU=The positive pay file that you are exporting must be of type Fixed Text or Variable Text.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PositivePayFileTypeErr : ENU=The positive pay file that you are exporting must be of type Fixed Text or Variable Text.;FRA=Le fichier Positive Pay que vous exportez doit être de type Texte fixe ou Texte variable.;
    //Variable type has not been exported.
}

