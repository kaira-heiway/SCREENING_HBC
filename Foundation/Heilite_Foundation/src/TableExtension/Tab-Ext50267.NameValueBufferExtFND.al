tableextension 50267 NameValueBufferExtFND extends "Name/Value Buffer"
{
    // version NAVW110.0,HEI.01

    // BC Upgrade PATELP08 >>
    // Changed table ext name from "NameValueBufferExt" to "NameValueBufferExtFND"
    // Changed fields name from "Name 2 FND" to "Name 2 FND"
    // BC Upgrade PATELP08 <<

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
        modify(Value)
        {
            CaptionML = ENU = 'Value', FRA = 'Valeur';
        }
        field(50000; "Name 2 FND"; Text[250])
        {
            Caption = 'Name 2';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "TemporaryErr(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //TemporaryErr : ENU=The record must be temporary.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TemporaryErr : ENU=The record must be temporary.;FRA=L'enregistrement doit être temporaire.;
    //Variable type has not been exported.
}

