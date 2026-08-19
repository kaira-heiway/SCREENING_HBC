tableextension 50250 DataExchLineDefExtFND extends "Data Exch. Line Def"
{
    // version NAVW110.0.00.14199,HEI.01
    // HEI.01 FDD-GAPID001 IBM LAZARE02 04.08.2017 # New fields Min. Occurs, Max. Occurs

    // BC Upgrade MISHRS14 >>
    // Changed table extension name to "DataExchLineDefExtFND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    fields
    {
        modify("Data Exch. Def Code")
        {
            CaptionML = ENU = 'Data Exch. Def Code', FRA = 'Code déf. échange données';
        }
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Column Count")
        {
            CaptionML = ENU = 'Column Count', FRA = 'Nombre colonnes';
        }
        modify("Data Line Tag")
        {
            CaptionML = ENU = 'Data Line Tag', FRA = 'Étiquette ligne données';
        }
        modify(Namespace)
        {
            CaptionML = ENU = 'Namespace', FRA = 'Espace de noms';
        }
        modify("Parent Code")
        {

            //Unsupported feature: Change TableRelation on ""Parent Code"(Field 10)". Please convert manually.

            CaptionML = ENU = 'Parent Code', FRA = 'Code parent';
        }
        modify("Line Type")
        {
            CaptionML = ENU = 'Line Type', FRA = 'Type ligne';
            OptionCaptionML = ENU = 'Detail,Header,Footer', FRA = 'Détail,En-tête,Pied de page';
        }

        //Unsupported feature: CodeModification on ""Parent Code"(Field 10).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Parent Code" = '' THEN
          EXIT;
        IF "Parent Code" = Code THEN
          ERROR(STRSUBSTNO(DontPointToTheSameLineErr,FIELDCAPTION("Parent Code"),FIELDCAPTION(Code)));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Parent Code" = '' then
          exit;
        if "Parent Code" = Code then
          ERROR(STRSUBSTNO(DontPointToTheSameLineErr,FIELDCAPTION("Parent Code"),FIELDCAPTION(Code)));
        */
        //end;
        field(50000; "Min. Occurs FND"; Option)
        {
            Caption = 'Min. Occurs';
            Description = 'HEI.01';
            OptionCaption = 'Zero,Once';
            OptionMembers = Zero,Once;
        }
        field(50001; "Max. Occurs FND"; Option)
        {
            Caption = 'Max. Occurs';
            Description = 'HEI.01';
            OptionCaption = 'Once,Unbounded';
            OptionMembers = Once,Unbounded;
        }
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DataExchMapping.SETRANGE("Data Exch. Def Code","Data Exch. Def Code");
    DataExchMapping.SETRANGE("Data Exch. Line Def Code",Code);
    DataExchMapping.DELETEALL(TRUE);

    DataExchColumnDef.SETRANGE("Data Exch. Def Code","Data Exch. Def Code");
    DataExchColumnDef.SETRANGE("Data Exch. Line Def Code",Code);
    DataExchColumnDef.DELETEALL(TRUE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DataExchMapping.SETRANGE("Data Exch. Def Code","Data Exch. Def Code");
    DataExchMapping.SETRANGE("Data Exch. Line Def Code",Code);
    DataExchMapping.DELETEALL(true);
    #4..6
    DataExchColumnDef.DELETEALL(true);
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "IncorrectNamespaceErr(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //IncorrectNamespaceErr : @@@="%1=file namespace,%2=supported namespace";ENU=The imported file contains unsupported namespace "%1". The supported namespace is '%2'.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //IncorrectNamespaceErr : @@@="%1=file namespace,%2=supported namespace";ENU=The imported file contains unsupported namespace "%1". The supported namespace is '%2'.;FRA=Le fichier importé contient l'espace de noms non pris en charge « %1 ». L'espace de noms pris en charge est « %2 ».;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "DontPointToTheSameLineErr(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DontPointToTheSameLineErr : @@@="%1 =Parent Code and %2 = Code";ENU=%1 cannot be the same as %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DontPointToTheSameLineErr : @@@="%1 =Parent Code and %2 = Code";ENU=%1 cannot be the same as %2.;FRA=%1 ne peut pas être identique à %2.;
    //Variable type has not been exported.
}

