tableextension 50094 WarehouseEmployeeExtFND extends "Warehouse Employee"
{
    // version NAVW110.0,DITW110.00.08,HEI.01
    // DITW15.00.00.35 DDR 06/10/2009 issue 516 Added field + Primary Key
    //                                  2014094 Physical Location Group Code
    // DITW15.00.00.37 DDR 10/06/2010 issue 1061 Added TableRelation field "Location Code"
    //                                           Added OnValidate(),OnLookup() field "Physical Location Group Code"
    // DITW15.00.00.39 DDR 12/04/2011 issue 1314 Added test on Physical location & setup
    //                                                   Added function GetWhseSetup()

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 # Added FIELDS zone code,
    //   #changed primary key to include zone code
    // BC Upgrade NANDIS03 - Did not change PK as per Navision
    fields
    {
        modify("User ID")
        {
            CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
        }
        modify("Location Code")
        {

            //Unsupported feature: Change TableRelation on ""Location Code"(Field 2)". Please convert manually.

            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify(Default)
        {
            CaptionML = ENU = 'Default', FRA = 'Par défaut';
        }
        modify("ADCS User")
        {
            CaptionML = ENU = 'ADCS User', FRA = 'Utilisateurs ADCS';
        }

        //Unsupported feature: CodeModification on ""ADCS User"(Field 7710).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("ADCS User" <> xRec."ADCS User") AND ("ADCS User" <> '') THEN BEGIN
          WarehouseEmployee.SETRANGE("ADCS User","ADCS User");
          IF NOT WarehouseEmployee.ISEMPTY THEN
            ERROR(Text001);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("ADCS User" <> xRec."ADCS User") and ("ADCS User" <> '') then begin
          WarehouseEmployee.SETRANGE("ADCS User","ADCS User");
          if not WarehouseEmployee.ISEMPTY then
            ERROR(Text001);
        end;
        */
        //end;
        field(50000; "Zone Code FND"; Code[10])
        {
            caption ='Zone Code';
            TableRelation = Zone.Code where("Location Code" = FIELD("Location Code"));
        }
        // field(2014094; "Physical Location Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Physical Location Group Code',
        //                 FRA = 'Code groupe magasin réel';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Physical Location Group";

        //     trigger OnLookup();
        //     var
        //         Location: Record Location;
        //         PhysLocation: Record "Physical Location Group";
        //     begin
        //         // <<DITW15.00.00.37 DDR 10/06/2010
        //         if "Location Code" <> '' then begin
        //             Location.GET("Location Code");
        //             PhysLocation.FILTERGROUP(2);
        //             PhysLocation.SETRANGE(Code, Location."Physical Location Group Code");
        //             PhysLocation.FILTERGROUP(0);
        //         end;
        //         if PAGE.RUNMODAL(0, PhysLocation) = ACTION::LookupOK then
        //             VALIDATE("Physical Location Group Code", PhysLocation.Code);
        //     end;

        //     trigger OnValidate();
        //     var
        //         Location: Record Location;
        //         PhysLocation: Record "Physical Location Group";
        //     begin
        //         // <<DITW15.00.00.39 DDR 12/04/2011 DIT-712 #1314
        //         GetWhseSetup();
        //         if "Physical Location Group Code" <> '' then
        //             WhseSetup.TESTFIELD("Whse. Doc. per Phys. Location", true);
        //         // >>DITW15.00.00.39 DDR DIT-712 #1314
        //         // <<DITW15.00.00.37 DDR 10/06/2010
        //         if ("Location Code" <> '') and ("Physical Location Group Code" <> '') then begin
        //             Location.GET("Location Code");
        //             TESTFIELD("Physical Location Group Code", Location."Physical Location Group Code");
        //         end;
        //     end;
        // }  // BC Upgrade NANDIS03
    }
    keys
    {

        //Unsupported feature: Deletion on ""User ID","Location Code"(Key)". Please convert manually.

        // key(Key1; "User ID", "Location Code", "Physical Location Group Code", "Zone Code")
        // {
        // }
        // key(Key2; "Physical Location Group Code")
        // {
        // }  // BC Upgrade NANDIS03
    }


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Default THEN
      CheckDefault;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if Default then
      CheckDefault;
    */
    //end;


    //Unsupported feature: CodeModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Default THEN
      CheckDefault;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if Default then
      CheckDefault;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You can only have one default location per user ID.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You can only have one default location per user ID.;FRA=Vous pouvez uniquement avoir un magasin par défaut par code utilisateur.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You can only assign an ADCS user name once.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You can only assign an ADCS user name once.;FRA=Vous ne pouvez affecter un nom d'utilisateur ADCS qu'une seule fois.;
    //Variable type has not been exported.

    var
        WhseSetup: Record "Warehouse Setup";
        HasReadWhseSetup: Boolean;
}

