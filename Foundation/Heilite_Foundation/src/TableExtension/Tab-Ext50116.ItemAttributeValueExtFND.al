tableextension 50116 ItemAttributeValueExtFND extends "Item Attribute Value"
{
    // version NAVW110.0,HEI.02
    // HEI.01 FDD–GAPID043 IBM LAZARE02 27.07.2017 # New field Description
    // HEI.02 FDD–GAPID043 IBM LAZARE02 06.09.2017 # Apply format for decimal values
    fields
    {
        modify("Attribute ID")
        {

            //Unsupported feature: Change TableRelation on ""Attribute ID"(Field 1)". Please convert manually.

            CaptionML = ENU = 'Attribute ID', FRA = 'ID attribut';
        }
        modify(ID)
        {
            CaptionML = ENU = 'ID', FRA = 'ID';
        }
        modify(Value)
        {
            CaptionML = ENU = 'Value', FRA = 'Valeur';
        }
        modify("Numeric Value")
        {
            CaptionML = ENU = 'Numeric Value', FRA = 'Valeur numérique';
        }
        modify(Blocked)
        {
            CaptionML = ENU = 'Blocked', FRA = 'Bloqué';
        }
        modify("Attribute Name")
        {

            //Unsupported feature: Change CalcFormula on ""Attribute Name"(Field 10)". Please convert manually.

            CaptionML = ENU = 'Attribute Name', FRA = 'Nom attribut';
        }

        //Unsupported feature: CodeModification on "Value(Field 3).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec.Value = Value THEN
          EXIT;

        TESTFIELD(Value);
        IF HasBeenUsed THEN
          IF NOT CONFIRM(RenameUsedAttributeValueQst) THEN
            ERROR('');

        CheckValueUniqueness(Rec,Value);
        DeleteTranslationsConditionally(xRec,Value);

        ItemAttribute.GET("Attribute ID");
        IF IsNumeric(ItemAttribute) THEN
          EVALUATE("Numeric Value",Value,9);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if xRec.Value = Value then
          exit;

        TESTFIELD(Value);
        if HasBeenUsed then
          if not CONFIRM(RenameUsedAttributeValueQst) then
        #7..12
        if IsNumeric(ItemAttribute) then
          EVALUATE("Numeric Value",Value,9);
        */
        //end;


        //Unsupported feature: CodeModification on ""Numeric Value"(Field 4).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec."Numeric Value" = "Numeric Value" THEN
          EXIT;

        ItemAttribute.GET("Attribute ID");
        IF IsNumeric(ItemAttribute) THEN
          VALIDATE(Value,FORMAT("Numeric Value",0,9));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if xRec."Numeric Value" = "Numeric Value" then
          exit;

        ItemAttribute.GET("Attribute ID");
        if IsNumeric(ItemAttribute) then
          //HEI.02>>
          //VALIDATE(Value,FORMAT("Numeric Value",0,9));
          if ItemAttribute."Value Format" = '' then
            VALIDATE(Value,FORMAT("Numeric Value",0,9))
          else
            VALIDATE(Value,FORMAT("Numeric Value",0,ItemAttribute."Value Format"));
          //HEI.02<<
        */
        //end;
        field(50000; "Description FND"; Text[250])
        {
            Caption = 'Description';
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
      IF NOT CONFIRM(DeleteUsedAttributeValueQst) THEN
        ERROR('');
    ItemAttributeValueMapping.SETRANGE("Item Attribute ID","Attribute ID");
    ItemAttributeValueMapping.SETRANGE("Item Attribute Value ID",ID);
    ItemAttributeValueMapping.DELETEALL;

    ItemAttrValueTranslation.SETRANGE("Attribute ID","Attribute ID");
    ItemAttrValueTranslation.SETRANGE(ID,ID);
    ItemAttrValueTranslation.DELETEALL;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if HasBeenUsed then
      if not CONFIRM(DeleteUsedAttributeValueQst) then
    #3..10
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "NameAlreadyExistsErr(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //NameAlreadyExistsErr : @@@=%1 - arbitrary name;ENU=The item attribute value with value '%1' already exists.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //NameAlreadyExistsErr : @@@=%1 - arbitrary name;ENU=The item attribute value with value '%1' already exists.;FRA=La valeur d'attribut article « %1 » existe déjà.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ReuseValueTranslationsQst(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ReuseValueTranslationsQst : @@@=%1 - arbitrary name,%2 - arbitrary name;ENU=There are translations for item attribute value '%1'.\\Do you want to reuse these translations for the new value '%2'?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ReuseValueTranslationsQst : @@@=%1 - arbitrary name,%2 - arbitrary name;ENU=There are translations for item attribute value '%1'.\\Do you want to reuse these translations for the new value '%2'?;FRA=Il existe des traductions pour la valeur « %1 » de l'attribut d'article\\Souhaitez-vous réutiliser ces traductions pour la nouvelle valeur « %2 » ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "DeleteUsedAttributeValueQst(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DeleteUsedAttributeValueQst : ENU=This item attribute value has been assigned to at least one item.\\Are you sure you want to delete it?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DeleteUsedAttributeValueQst : ENU=This item attribute value has been assigned to at least one item.\\Are you sure you want to delete it?;FRA=Cette valeur d'attribut d'article a été affectée à au moins un article.\\Souhaitez-vous la supprimer ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "RenameUsedAttributeValueQst(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //RenameUsedAttributeValueQst : ENU=This item attribute value has been assigned to at least one item.\\Are you sure you want to rename it?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //RenameUsedAttributeValueQst : ENU=This item attribute value has been assigned to at least one item.\\Are you sure you want to rename it?;FRA=Cette valeur attribut d'article a été affectée à au moins un article.\\Souhaitez-vous la renommer ?;
    //Variable type has not been exported.
}

