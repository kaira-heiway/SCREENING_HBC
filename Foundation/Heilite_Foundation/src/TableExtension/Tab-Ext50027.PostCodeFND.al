tableextension 50027 PostCodeExtFND extends "Post Code"
{
    // version NAVW110.0.00.16585,HEI.01
    // HEI.01 PURGAP05 IBM LAZARE02 31.07.2017
    //   # Extend City and Search City fields to 35
    //   # Changed City parameter length to 35 in functions ValidateCity, ValidatePostCode and ValidateCountryCode

    fields
    {
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify(City)
        {

            //Unsupported feature: Change Data type on "City(Field 2)". Please convert manually.

            CaptionML = ENU = 'City', FRA = 'Ville';


            //Unsupported feature: Change Description on "City(Field 2)". Please convert manually.

        }
        modify("Search City")
        {

            //Unsupported feature: Change Data type on ""Search City"(Field 3)". Please convert manually.

            CaptionML = ENU = 'Search City', FRA = 'Ville de recherche';
        }
        modify("Country/Region Code")
        {

            //Unsupported feature: Change TableRelation on ""Country/Region Code"(Field 4)". Please convert manually.

            CaptionML = ENU = 'Country/Region Code', FRA = 'Code pays/région';
        }
        modify(County)
        {
            CaptionML = ENU = 'County', FRA = 'Région';
        }

        //Unsupported feature: CodeModification on "Code(Field 1).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.SETRANGE("Search City","Search City");
        PostCode.SETRANGE(Code,Code);
        IF NOT PostCode.ISEMPTY THEN
          ERROR(Text000,FIELDCAPTION(Code),Code);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.SETRANGE("Search City","Search City");
        PostCode.SETRANGE(Code,Code);
        if not PostCode.ISEMPTY then
          ERROR(Text000,FIELDCAPTION(Code),Code);
        */
        //end;


        //Unsupported feature: CodeModification on "City(Field 2).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Code);
        "Search City" := City;
        IF xRec."Search City" <> "Search City" THEN BEGIN
          PostCode.SETRANGE("Search City","Search City");
          PostCode.SETRANGE(Code,Code);
          IF NOT PostCode.ISEMPTY THEN
            ERROR(Text000,FIELDCAPTION(City),City);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Code);
        "Search City" := City;
        if xRec."Search City" <> "Search City" then begin
          PostCode.SETRANGE("Search City","Search City");
          PostCode.SETRANGE(Code,Code);
          if not PostCode.ISEMPTY then
            ERROR(Text000,FIELDCAPTION(City),City);
        end;
        */
        //end;
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "ValidateCity(PROCEDURE 5).SearchCity(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ValidateCity : 30;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ValidateCity : 35;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=%1 %2 already exists.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=%1 %2 already exists.;FRA=L'enregistrement %1 %2 existe déjà.;
    //Variable type has not been exported.
}

