tableextension 50115 ItemAttributeExt extends "Item Attribute"
{
    // version NAVW110.0,HEI.01
    // HEI.01 FDD–GAPID043 IBM LAZARE02 06.09.2017 # New field Value Format
    fields
    {
        modify(ID)
        {
            CaptionML = ENU = 'ID', FRA = 'ID';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify(Blocked)
        {
            CaptionML = ENU = 'Blocked', FRA = 'Bloqué';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            OptionCaptionML = ENU = 'Option,Text,Integer,Decimal', FRA = 'Option,Texte,Entier,Décimal';
        }
        modify("Unit of Measure")
        {
            CaptionML = ENU = 'Unit of Measure', FRA = 'Unité';
        }

        //Unsupported feature: CodeModification on "Name(Field 2).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec.Name = Name THEN
          EXIT;

        TESTFIELD(Name);
        IF HasBeenUsed THEN
          IF NOT CONFIRM(RenameUsedAttributeQst) THEN
            ERROR('');
        CheckNameUniqueness(Rec,Name);
        DeleteValuesAndTranslationsConditionally(xRec,Name);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if xRec.Name = Name then
          exit;

        TESTFIELD(Name);
        if HasBeenUsed then
          if not CONFIRM(RenameUsedAttributeQst) then
        #7..9
        */
        //end;


        //Unsupported feature: CodeModification on "Type(Field 7).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec.Type <> Type THEN BEGIN
          ItemAttributeValue.SETRANGE("Attribute ID",ID);
          IF NOT ItemAttributeValue.ISEMPTY THEN
            ERROR(ChangingAttributeTypeErr,Name);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if xRec.Type <> Type then begin
          ItemAttributeValue.SETRANGE("Attribute ID",ID);
          if not ItemAttributeValue.ISEMPTY then
            ERROR(ChangingAttributeTypeErr,Name);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit of Measure"(Field 8).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (xRec."Unit of Measure" <> '') AND (xRec."Unit of Measure" <> "Unit of Measure") THEN
          IF HasBeenUsed THEN
            IF NOT CONFIRM(ChangeUsedAttributeUoMQst) THEN
              ERROR('');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if (xRec."Unit of Measure" <> '') and (xRec."Unit of Measure" <> "Unit of Measure") then
          if HasBeenUsed then
            if not CONFIRM(ChangeUsedAttributeUoMQst) then
              ERROR('');
        */
        //end;
        field(50000; "Value Format FND"; Text[100])
        {
            Caption = 'Value Format';
            Description = 'HEI.01';
        }
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF HasBeenUsed THEN
      IF NOT CONFIRM(DeleteUsedAttributeQst) THEN
        ERROR('');
    DeleteValuesAndTranslations;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if HasBeenUsed then
      if not CONFIRM(DeleteUsedAttributeQst) then
        ERROR('');
    DeleteValuesAndTranslations;
    */
    //end;


    //Unsupported feature: CodeModification on "OnRename". Please convert manually.

    //trigger OnRename();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ItemAttributeValue.SETRANGE("Attribute ID",xRec.ID);
    IF ItemAttributeValue.findset THEN
      REPEAT
        ItemAttributeValue.RENAME(ID,ItemAttributeValue.ID);
      UNTIL ItemAttributeValue.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ItemAttributeValue.SETRANGE("Attribute ID",xRec.ID);
    if ItemAttributeValue.findset then
      repeat
        ItemAttributeValue.RENAME(ID,ItemAttributeValue.ID);
      until ItemAttributeValue.NEXT = 0;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "NameAlreadyExistsErr(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //NameAlreadyExistsErr : @@@=%1 - arbitrary name;ENU=The item attribute with name '%1' already exists.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NameAlreadyExistsErr : @@@=%1 - arbitrary name;ENU=The item attribute with name '%1' already exists.;FRA=L'attribut article « %1 » existe déjà.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ReuseValueTranslationsQst(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ReuseValueTranslationsQst : @@@=%1 - arbitrary name,%2 - arbitrary name;ENU=There are values and translations for item attribute '%1'.\\Do you want to reuse them after changing the item attribute name to '%2'?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ReuseValueTranslationsQst : @@@=%1 - arbitrary name,%2 - arbitrary name;ENU=There are values and translations for item attribute '%1'.\\Do you want to reuse them after changing the item attribute name to '%2'?;FRA=Il existe des valeurs et des traductions pour l'attribut d'article « %1 ».\\Souhaitez-vous les réutiliser après avoir remplacé le nom de l'attribut d'article par « %2 » ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ChangingAttributeTypeErr(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ChangingAttributeTypeErr : @@@=%1 - arbirtrary text;ENU=You cannot change the type of item attribute '%1', because it is either in use or it has predefined values.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ChangingAttributeTypeErr : @@@=%1 - arbirtrary text;ENU=You cannot change the type of item attribute '%1', because it is either in use or it has predefined values.;FRA=Vous ne pouvez pas modifier le type de l'attribut d'article « %1 », car il est utilisé ou présente des valeurs prédéfinies.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "DeleteUsedAttributeQst(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DeleteUsedAttributeQst : ENU=This item attribute has been assigned to at least one item.\\Are you sure you want to delete it?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DeleteUsedAttributeQst : ENU=This item attribute has been assigned to at least one item.\\Are you sure you want to delete it?;FRA=Cet attribut d'article a été affecté à au moins un article.\\Souhaitez-vous le supprimer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "RenameUsedAttributeQst(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //RenameUsedAttributeQst : ENU=This item attribute has been assigned to at least one item.\\Are you sure you want to rename it?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //RenameUsedAttributeQst : ENU=This item attribute has been assigned to at least one item.\\Are you sure you want to rename it?;FRA=Cet attribut d'article a été affecté à au moins un article.\\Souhaitez-vous le renommer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ChangeUsedAttributeUoMQst(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ChangeUsedAttributeUoMQst : ENU=This item attribute has been assigned to at least one item.\\Are you sure you want to change its unit of measure?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ChangeUsedAttributeUoMQst : ENU=This item attribute has been assigned to at least one item.\\Are you sure you want to change its unit of measure?;FRA=Cet attribut d'article a été affecté à au moins un article.\\Souhaitez-vous en modifier l'unité de mesure ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ChangeToOptionQst(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ChangeToOptionQst : ENU=Predefined values can be defined only for item attributes of type Option.\\Do you want to change the type of this item attribute to Option?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ChangeToOptionQst : ENU=Predefined values can be defined only for item attributes of type Option.\\Do you want to change the type of this item attribute to Option?;FRA=Des valeurs prédéfinies ne peuvent être définies que pour les attributs d'article de type Option.\\Voulez-vous modifier le type de cet attribut d'article sur Option ?;
    //Variable type has not been exported.
}

