tableextension 50026 OrderAddressExtFND extends "Order Address"
{
    // version NAVW110.0,IPLXL9.00.001,DITW110.00.08,HEI.01
    // DITW15.00.00.25 DDR 21/10/2008 Added tab "Drink-It"
    //                                Added filed "Vendor DTax Group Code"
    //                                Added button Purchases for Item charge Tax groups
    // DITW15.00.00.28 DDR 24/11/2008 Added fields "Tax Registration No.","Fiscal Representative No." into tab Drink-It
    // DITW15.00.00.37 DDR 02/04/2010 issue 1110 Added field "Transport Time" into Drink-It tab
    // DITW15.00.00.38 DDR 10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added fields
    //                                    (Foreign Trade) "Transaction Type","Transport Method","Transaction Specification",
    //                                      "Exit Point","Area Code"
    //                     13/09/2010     (Drink-it) "Tax Warehouse Reference"
    //                     06/12/2010 issue 1217 (DIT711 97)
    //                                    (Drink-It) "Tax Office Code"
    // DITW15.00.00.39 DDR 06/07/2011 issue 1353 Added field "Journey Time" (Drink-It)
    // DITW18.00.07 VSC 18/05/2016 DIT-770 #1972 Merge FINXL EDI Interface
    // DITW18.00.07 AKH 10/05/2016 DIT-770 #1346 Added new tab Receiving with field "Vendor Delivery Type"
    // DITW18.00.07 VSC 11/05/2016 DIT-770 #1968 New Page Link to Delivery Times where "Source Type" = Vendor
    // DITW18.00.07 VSC 09/05/2016 DIT-770 #1968 - #1977 Default & Mandatory Route setup + Route default values + shipment date calculation

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // IPLXL9.00.001 IMI 10/06/2015: Added field GLN

    // HEI.01 FDD–PURGAP05 IBM LAZARE02 03.07.2017 # New field Supplying Plant Vendor Number
    fields
    {
        modify("Vendor No.")
        {
            CaptionML = ENU = 'Vendor No.', FRA = 'N° fournisseur';
        }
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Name 2")
        {
            CaptionML = ENU = 'Name 2', FRA = 'Nom 2';
        }
        modify(Address)
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
        }
        modify("Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
        }
        modify(City)
        {

            //Unsupported feature: Change Data type on "City(Field 7)". Please convert manually.


            //Unsupported feature: Change TableRelation on "City(Field 7)". Please convert manually.

            CaptionML = ENU = 'City', FRA = 'Ville';

            //Unsupported feature: Change Description on "City(Field 7)". Please convert manually.

        }
        modify(Contact)
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
        }
        modify("Phone No.")
        {
            CaptionML = ENU = 'Phone No.', FRA = 'N° téléphone';
        }
        modify("Telex No.")
        {
            CaptionML = ENU = 'Telex No.', FRA = 'N° télex';
        }
        modify("Country/Region Code")
        {

            //Unsupported feature: Change TableRelation on ""Country/Region Code"(Field 35)". Please convert manually.

            CaptionML = ENU = 'Country/Region Code', FRA = 'Code pays/région';
        }
        modify("Last Date Modified")
        {
            CaptionML = ENU = 'Last Date Modified', FRA = 'Date dern. modification';
        }
        modify("Fax No.")
        {
            CaptionML = ENU = 'Fax No.', FRA = 'N° télécopie';
        }
        modify("Telex Answer Back")
        {
            CaptionML = ENU = 'Telex Answer Back', FRA = 'Télex retour';
        }
        modify("Post Code")
        {

            //Unsupported feature: Change TableRelation on ""Post Code"(Field 91)". Please convert manually.

            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
        }
        modify(County)
        {
            CaptionML = ENU = 'County', FRA = 'Région';
        }
        modify("E-Mail")
        {
            CaptionML = ENU = 'Email', FRA = 'Adresse e-mail';
        }
        modify("Home Page")
        {
            CaptionML = ENU = 'Home Page', FRA = 'Page d''accueil';
        }

        //Unsupported feature: CodeModification on "City(Field 7).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""Post Code"(Field 91).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;
        field(50000; "Supplying Plant Vndor Num. FND"; Code[20])
        {
            Caption = 'Supplying Plant Vendor Number';
            Description = 'HEI.01';
            TableRelation = Vendor;

            trigger OnValidate();
            var
                Vendor: Record Vendor;
            begin
                //HEI.01>>
                if "Supplying Plant Vndor Num. FND" <> xRec."Supplying Plant Vndor Num. FND" then begin
                    if "Supplying Plant Vndor Num. FND" <> '' then
                        Vendor.GET("Supplying Plant Vndor Num. FND");
                    VALIDATE(Name, Vendor.Name);
                    VALIDATE("Name 2", Vendor."Name 2");
                    VALIDATE(Address, Vendor.Address);
                    VALIDATE("Address 2", Vendor."Address 2");
                    VALIDATE("Post Code", Vendor."Post Code");
                    VALIDATE(City, Vendor.City);
                    VALIDATE(County, Vendor.County);
                    VALIDATE("Country/Region Code", Vendor."Country/Region Code");
                    VALIDATE(Contact, Vendor.Contact);
                    VALIDATE("Phone No.", Vendor."Phone No.");
                    VALIDATE("Fax No.", Vendor."Fax No.");
                    VALIDATE("Telex No.", Vendor."Telex No.");
                    VALIDATE("Telex Answer Back", Vendor."Telex Answer Back");
                    VALIDATE("E-Mail", Vendor."E-Mail");
                    VALIDATE("Home Page", Vendor."Home Page");
                end;
                //HEI.01<<
            end;
        }
        //sharmp16 drinkitfields begin>>
        // field(2013667;"Vendor DTax Group Code";Code[10])
        // {
        //     CaptionML = ENU='Vendor Tax Group Code',
        //                 FRA='Code groupe taxe fournisseur';
        //     Description = 'DITW15.00.00.25';
        //     TableRelation = "Drink Tax Group".Code WHERE ("Source Type"=CONST(Vendor));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.33 DDR 08/05/2009
        //         TestMsgTaxRegistration();
        //         // >>DITW15.00.00.33 DDR
        //     end;
        // }
        // field(2013726;"Tax Registration No.";Text[20])
        // {
        //     CaptionML = ENU='Tax Registration No.',
        //                 FRA='N° Registration Taxe';
        //     Description = 'DITW15.00.00.28';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.33 DDR 08/05/2009 - DITW15.00.00.34 DDR 09/07/2009
        //         TestMsgTaxRegistration();
        //         // >>DITW15.00.00.34 DDR
        //     end;
        // }
        // field(2013730;"Fiscal Representative No.";Code[20])
        // {
        //     CaptionML = ENU='Fiscal Representative / Customs Agent No.',
        //                 FRA='N° représentant fiscal / Agent des douanes';
        //     Description = 'DITW15.00.00.28-.38 #1217';
        //     TableRelation = "Fiscal Representative";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.33 DDR 08/05/2009
        //         TestMsgTaxRegistration();
        //         // >>DITW15.00.00.33 DDR
        //     end;
        // }
        // field(2014060;"Vendor Delivery Type";Code[10])
        // {
        //     CaptionML = ENU='Vendor Delivery Type',
        //                 FRA='Type Livraison Fournisseur';
        //     Description = 'DITW18.00.07 DIT-770 #1346';
        //     TableRelation = "Delivery Type".Code WHERE (Type=CONST(Vendor));
        // }
        // field(2014061;"Truck Zone";Option)
        // {
        //     CaptionML = ENU='Truck Zone',
        //                 FRA='Zone de camion';
        //     Description = 'DITW18.00.07 DIT-770 #1968';
        //     OptionCaptionML = ENU=' ,Right,Left',
        //                       FRA=' ,Droite,Gauche';
        //     OptionMembers = " ",Right,Left;
        // }
        // field(2014063;"Require 2 Drivers";Boolean)
        // {
        //     CaptionML = ENU='Require 2 Drivers',
        //                 FRA='Demande 2 chauffeurs';
        //     Description = 'DITW18.00.07 DIT-770 #1968';
        // }
        // field(2014064;"Shipping Agent Code";Code[10])
        // {
        //     AccessByPermission = TableData "Shipping Agent Services"=R;
        //     CaptionML = ENU='Shipping Agent Code',
        //                 FRA='Code transporteur';
        //     Description = 'DITW18.00.07 DIT-770 #1968';
        //     TableRelation = "Shipping Agent";

        //     trigger OnValidate();
        //     begin
        //         if "Shipping Agent Code" <> xRec."Shipping Agent Code" then
        //           VALIDATE("Shipping Agent Service Code",'');
        //     end;
        // }
        // field(2014065;"Shipping Agent Service Code";Code[10])
        // {
        //     CaptionML = ENU='Shipping Agent Service Code',
        //                 FRA='Code prestation transporteur';
        //     Description = 'DITW18.00.07 DIT-770 #1968';
        //     TableRelation = "Shipping Agent Services".Code WHERE ("Shipping Agent Code"=FIELD("Shipping Agent Code"));
        // }
        // field(2014087;Distance;Decimal)
        // {
        //     CaptionML = ENU='Distance',
        //                 FRA='Distance';
        //     DecimalPlaces = 0:5;
        //     Description = 'DITW18.00.07 DIT-770 #1968';
        //     MinValue = 0;
        // }
        // field(2014101;"Transport time";Text[50])
        // {
        //     CaptionML = ENU='Transport time (AAD)',
        //                 FRA='Temps de transport (DAA)';
        //     Description = 'DITW15.00.00.37';
        // }
        // field(2014107;Route;Code[20])
        // {
        //     CaptionML = ENU='Route',
        //                 FRA='Itinéraire';
        //     Description = 'DITW18.00.07 DIT-770 #1968';
        //     TableRelation = Route;

        //     trigger OnValidate();
        //     var
        //         SalesHeader : Record "Sales Header";
        //         lrRouteCombination : Record "Route Combination";
        //         lrRoute : Record Route;
        //     begin
        //         //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1968 -> DIT-770 #154
        //         if lrRoute.GET(Route) then begin
        //           if lrRoute."Shipping Agent Code" <> '' then
        //             "Shipping Agent Code" := lrRoute."Shipping Agent Code";
        //           if lrRoute."Shipping Agent Service Code" <> '' then
        //             "Shipping Agent Service Code" := lrRoute."Shipping Agent Service Code";
        //         end;

        //         lrRouteCombination.RESET;
        //         //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1968
        //         lrRouteCombination.SETRANGE("Source Type",lrRouteCombination."Source Type"::Vendor);
        //         //>> DITW18.00.07 VSC DIT-770 #1968
        //         lrRouteCombination.SETRANGE("No.","Vendor No.");
        //         lrRouteCombination.SETRANGE("Address Code",Code);
        //         lrRouteCombination.SETRANGE(Code,Route);
        //         if not lrRouteCombination.FINDFIRST then begin
        //           lrRouteCombination.INIT;
        //           //<< DITW18.00.07 VSC 29/04/2016 DIT-770 #1968
        //           lrRouteCombination."Source Type" := lrRouteCombination."Source Type"::Vendor;
        //           //>> DITW18.00.07 VSC DIT-770 #1968
        //           lrRouteCombination."No." := "Vendor No.";
        //           lrRouteCombination."Address Code" := Code;
        //           lrRouteCombination.Code := Route;
        //           lrRouteCombination.INSERT;
        //         end;
        //         //>> DITW18.00.07 VSC 29/04/2016 DIT-770 #1968 -> DIT-770 #154
        //     end;
        // }
        // field(2014271;"Tax Warehouse Reference";Text[20])
        // {
        //     CaptionML = ENU='Tax Warehouse Reference',
        //                 FRA='Entrepôt fiscal de référence';
        //     Description = 'DITW15.00.00.38 #1217';
        // }
        // field(2014290;"Journey Time";DateFormula)
        // {
        //     CaptionML = ENU='Journey Time (EMCS)',
        //                 FRA='Temps de trajet (EMCS)';
        //     Description = 'DITW15.00.00.39 #1353';
        // }
        // field(2014460;"Tax Office Code";Code[10])
        // {
        //     CaptionML = ENU='Tax Office Code',
        //                 FRA='Code Bureau de taxe';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Tax Office";
        // }
        // field(2014464;"Transaction Type";Code[10])
        // {
        //     CaptionML = ENU='Transaction Type',
        //                 FRA='Type de transaction';
        //     Description = 'DITW15.00.00.38';
        //     TableRelation = "Transaction Type";
        // }
        // field(2014465;"Transport Method";Code[10])
        // {
        //     CaptionML = ENU='Transport Method',
        //                 FRA='Mode de transport';
        //     Description = 'DITW15.00.00.38';
        //     TableRelation = "Transport Method";
        // }
        // field(2014466;"Transaction Specification";Code[10])
        // {
        //     CaptionML = ENU='Transaction Specification',
        //                 FRA='Régime';
        //     Description = 'DITW15.00.00.38';
        //     TableRelation = "Transaction Specification";
        // }
        // field(2014467;"Entry Point";Code[10])
        // {
        //     CaptionML = ENU='Entry Point',
        //                 FRA='Pays provenance';
        //     Description = 'DITW15.00.00.38';
        //     TableRelation = "Entry/Exit Point";
        // }
        // field(2014470;"Area";Code[10])
        // {
        //     CaptionML = ENU='Area',
        //                 FRA='Dépt destination/provenance';
        //     Description = 'DITW15.00.00.38';
        //     TableRelation = Area;
        // }
        // field(2014495;"Delivery Sequence";Integer)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU='Delivery Sequence',
        //                 FRA='Séquence de livraison';
        //     Description = 'DITW18.00.07 DIT-770 #1968';
        // }
        // field(2030010;GLN;Code[50])
        // {
        //     CaptionML = ENU='GLN',
        //                 FRA='GLN';
        //     Description = 'IPLXL9.00.001';
        // }
        //sharmp16 drinkitfields end<<
    }
    keys
    {
        //sharmp15 drinkit
        // key(Key1; GLN)
        // {
        // }
    }


    //Unsupported feature: CodeModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Last Date Modified" := TODAY;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Last Date Modified" := TODAY;
    // <<DITW15.00.00.33 DDR 08/05/2009
    TestMsgTaxRegistration();
    // >>DITW15.00.00.33 DDR
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=untitled;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=untitled;FRA=sans-titre;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.;FRA=Avant de pouvoir utiliser Online Map, vous devez compléter la fenêtre Configuration Online Map.\Consultez la section Configuration d'Online Map dans l'Aide.;
    //Variable type has not been exported.

    var
        Text2013660: TextConst ENU = 'You must specify %1 in %2 or %3 or %4 when %5 %6.', FRA = 'Vous devez spécifier %1 dans %2 ou %3 ou %4 quand %5 %6.';
}

