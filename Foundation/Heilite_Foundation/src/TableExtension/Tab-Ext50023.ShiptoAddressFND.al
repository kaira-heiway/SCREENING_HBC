tableextension 50023 ShiptoAddressExtFND extends "Ship-to Address"
{
    // version NAVW110.0,FINXL8.00.001,IPLXL9.00.001,DITW110.00.08,HEI.01
    // DITW15.00.00.24 DDR 14/08/2008 Added fields
    //                                  2014087 Distance
    // DITW15.00.00.25 DDR 21/10/2008 added fields
    //                                  2013667 Customer DTax Group Code
    // DITW15.00.00.28 DDR 24/11/2008 Added fields
    //                                  2013726 Tax Registration No.
    //                                  2013730 Fiscal Representative No.
    // DITW15.00.00.33 DDR 08/05/2009 Added text contant Text2013660
    //                                Added functions
    //                                  IsNeedTaxReg(),TestMsgTaxRegistration()
    //                     12/05/2009 Correct function TestMsgTaxRegistration()
    // DITW15.00.00.34 DDR 09/07/2009 Changed Text constant Text2013660
    // DITW15.00.00.37 DDR 02/04/2010 issue 1110 Added fields
    //                                  2014101 Transport Time
    // DITW15.00.00.38 DDR 10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added fields
    //                                    2014271 Tax Warehouse Reference
    //                                    2014464 Transaction Type
    //                                    2014465 Transport Method
    //                                    2014466 Transaction Specification
    //                                    2014467 Exit Point
    //                                    2014468 Area Code
    //                     06/12/2010 issue 1217 (DIT711 97)
    //                                  Added fields
    //                                    2014460 Tax Office Code
    //                     04/01/2011 issue 1217 (DIT711 105) Modified to check the Tax Registration no.
    //                     27/01/2011 issue 1217 (DIT711 137) Modified Caption field2013730 "Fiscal Representative No."
    // DITW15.00.00.39 RBE 20/04/2011 issue 1230 Telesales functionnalities
    //                                  Added fields
    //                                    2013910 Caller-ID
    //                                    2013911 Sell-to Contact No.
    //                                    2013912 Base Calendar Code
    //                                  Added text constant Text2013910
    //                                  Added functions fctUpdateSellToCont()
    //                     21/04/2011   Added fields
    //                                   2014103 Delivery Sequence
    //                 DDR 06/07/2011 issue 1353 Added fields
    //                                   2014290 Journey Time
    //                     15/07/2011 issue 1230 Added fields
    //                                   2013913 Customer Filter
    //                                   2013916 Date Filter
    //                                   2013920 Nos of Calls
    //                                   2013940 Call Closed Filter
    //                                   2013941 Call Status Filter
    //                     04/08/2011 issue 1353 Modified caption field2014290 "Journey Time"
    // DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added fields
    //                                   2014065 Base Calendar Code
    //                                   2014066 Salesperson Code
    //                     16/04/2012 DIT-715 #247 Sponsoring & Events functionnality
    //                                 Added fields
    //                                   2014360 Customer Price Group
    // DITW16.00.00.43 DDR 13/05/2013 DIT-715 #604 Added fields
    //                                               2014509 Default Ship-to Code
    //                 DDR 18/12/2013 DIT-715 #836 Disabled modification all sales orders when change "Route"
    //                                               Tag? //KK-IN
    // DITW17.00.02 DDR 13/05/2013 DIT-715 #604
    // DITW17.00.02 AT  06/09/2013 DIT-770 #141 merge WHN-001 HIT0089.5
    //                             Add fields 2013610 "Customer DDeposit Group Code" (Code 10), 2014513 "Invoice Posting" (Option) and
    //                             2014514 "Invoice Period" (Option)
    // DITW17.00.02 AT  09/09/2013 DIT-770 #146 merge WHN-001 HIT0005
    //                             Created field 2014062 "Shipment Date Formula"
    // DITW17.00.02 AT  12/09/2013 DIT-770 #154
    //                             Added code to Update Shipping Agen, Shipping Agent Service Code on Shipment Method OnValidate
    //                             Added field 2014060 Picking Type
    //                             2014061 Truck Zone
    //                             2014063 Require 2 Driver
    //                             Added code to create Route combination and update Shipping Agent & Shipping Agent Service Code
    // DITW17.00.02 AT  10/10/2013 DIT-770 #154
    //                             Added fields
    //                             2014064 Ship-to Address Key No.
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 DDR 18/12/2013 DIT-715 #836
    // DITW17.00.02 VSC 30/04/2014 DIT-770 #338
    // DITW17.10.05 YHE 02/09/2014 DIT-770 #754 : Add fields 2014410-"Shipment Date Alert Filter", 2014411-"Shipment Status Alert Filter"

    // FINXL8.00.001 BSA 08/06/2015 #151 : Added Field : "Vat Bus posting group"
    // FINXL8.00.001 BSA 29/06/2015 #177 : Added Fields : "Ship-to","Bill-to"
    // DITW18.00.07 VSC 18/05/2016 DIT-770 #1972 Merge FINXL EDI Interface
    // DITW18.00.07 AKH 10/05/2016 DIT-770 #1346 Added field 2014066 "Customer Delivery Type"
    // DITW19.00.08 AKH 20/09/2016 BL#10756 (DIT-770 #1215) Added new field 2014412 "Return Location Code"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // IPLXL9.00.001 IMI 10/06/2015: Added field GLN + key
    // HEI.01 FDD-SLSGAP001 IBM NASTAA02 08.09.2017 # MDM Customer Card
    //   # Increased "Customer DTax Group Code" field length from 10 to 20 characters
    //   # Increased "City" field length from 30 to 35 characters
    fields
    {
        modify("Customer No.")
        {
            CaptionML = ENU = 'Customer No.', FRA = 'N° client';
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
        modify("Shipment Method Code")
        {
            CaptionML = ENU = 'Shipment Method Code', FRA = 'Code condition livraison';
        }
        modify("Shipping Agent Code")
        {
            CaptionML = ENU = 'Shipping Agent Code', FRA = 'Code transporteur';
        }
        modify("Place of Export")
        {
            CaptionML = ENU = 'Place of Export', FRA = 'Lieu d''exportation';
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
        modify("Location Code")
        {

            //Unsupported feature: Change TableRelation on ""Location Code"(Field 83)". Please convert manually.

            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
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
        modify("Tax Area Code")
        {
            CaptionML = ENU = 'Tax Area Code', FRA = 'Code zone recouvrement';
        }
        modify("Tax Liable")
        {
            CaptionML = ENU = 'Tax Liable', FRA = 'Soumis à recouvrement';
        }
        modify("Shipping Agent Service Code")
        {

            //Unsupported feature: Change TableRelation on ""Shipping Agent Service Code"(Field 5792)". Please convert manually.

            CaptionML = ENU = 'Shipping Agent Service Code', FRA = 'Code prestation transporteur';
        }
        modify("Service Zone Code")
        {
            CaptionML = ENU = 'Service Zone Code', FRA = 'Code zone service';
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


        //Unsupported feature: CodeInsertion on ""Shipment Method Code"(Field 30)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<<DITW17.00.02 TEC1 12/09/2013 DIT-770 #154
        if (xRec."Shipment Method Code" <> "Shipment Method Code") then begin
          if rShipmentMethod.GET("Shipment Method Code") then
          begin
            "Shipping Agent Code" := rShipmentMethod."Shipping Agent";
            "Shipping Agent Service Code" := rShipmentMethod."Shipping Agent Service Code";
          end;
        end;
        //>>DITW17.00.02 TEC1 DIT-770 #154
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipping Agent Code"(Field 31).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Shipping Agent Code" <> xRec."Shipping Agent Code" THEN
          VALIDATE("Shipping Agent Service Code",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Shipping Agent Code" <> xRec."Shipping Agent Code" then
          VALIDATE("Shipping Agent Service Code",'');
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
        // field(2013610; "Customer DDeposit Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Customer Deposit Group Code',
        //                 FRA = 'Code groupe consigne client';
        //     Description = 'DITW17.00.02 DIT-770 #141';
        //     TableRelation = "Drink Deposit Group".Code where("Source Type" = CONST(Customer));
        // }
        // field(2013667; "Customer DTax Group Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Customer Tax Group Code',
        //                 FRA = 'Code groupe taxe client';
        //     Description = 'DITW15.00.00.25,HEI.01';
        //     TableRelation = "Drink Tax Group".Code where("Source Type" = CONST(Customer));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.33 DDR 08/05/2009
        //         TestMsgTaxRegistration();
        //         // >>DITW15.00.00.33 DDR
        //     end;
        // }
        // field(2013726; "Tax Registration No."; Text[20])
        // {
        //     CaptionML = ENU = 'Tax Registration No.',
        //                 FRA = 'N° Registration Taxe';
        //     Description = 'DITW15.00.00.28';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.33 DDR 08/05/2009 - DITW15.00.00.34 DDR 09/07/2009
        //         TestMsgTaxRegistration();
        //         // >>DITW15.00.00.34 DDR
        //     end;
        // }
        // field(2013730; "Fiscal Representative No."; Code[20])
        // {
        //     CaptionML = ENU = 'Fiscal Representative / Customs Agent No.',
        //                 FRA = 'N° représentant fiscal / Agent des douanes';
        //     Description = 'DITW15.00.00.28-.38 #1217';
        //     TableRelation = "Fiscal Representative";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.33 DDR 08/05/2009
        //         TestMsgTaxRegistration();
        //         // >>DITW15.00.00.33 DDR
        //     end;
        // }
        // field(2013910; "Caller-ID"; Code[50])
        // {
        //     CaptionML = ENU = 'Caller-ID',
        //                 FRA = 'ID Appelant';
        //     Description = 'DITW15.00.00.39 RBE 20/04/2011 #1230';
        //     TableRelation = User."User Name";
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnLookup();
        //     var
        //         UserMgt: Codeunit "User Management";
        //     begin
        //         UserMgt.LookupUserID("Caller-ID");
        //     end;
        // }
        // field(2013911; "Sell-to Contact No."; Code[20])
        // {
        //     CaptionML = ENU = 'Sell-to Contact No.',
        //                 FRA = 'N° contact donneur d''ordre';
        //     Description = 'DITW15.00.00.39 RBE 20/04/2011 #1230';
        //     TableRelation = Contact;

        //     trigger OnLookup();
        //     var
        //         Cont: Record Contact;
        //         ContBusinessRelation: Record "Contact Business Relation";
        //     begin
        //         //  <<DITW15.00.00.39 RBE 20/04/2011 #1230
        //         if Cont.GET("Sell-to Contact No.") then
        //             Cont.SETRANGE("Company No.", Cont."Company No.")
        //         else begin
        //             ContBusinessRelation.RESET;
        //             ContBusinessRelation.SETCURRENTKEY("Link to Table", "No.");
        //             ContBusinessRelation.SETRANGE("Link to Table", ContBusinessRelation."Link to Table"::Customer);
        //             ContBusinessRelation.SETRANGE("No.", "Customer No.");
        //             if ContBusinessRelation.FINDFIRST then
        //                 Cont.SETRANGE("Company No.", ContBusinessRelation."Contact No.")
        //             else
        //                 Cont.SETRANGE("No.", '');
        //         end;

        //         if "Sell-to Contact No." <> '' then
        //             if Cont.GET("Sell-to Contact No.") then;
        //         if PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK then begin
        //             xRec := Rec;
        //             VALIDATE("Sell-to Contact No.", Cont."No.");
        //         end;
        //         //  >>DITW15.00.00.39 RBE #1230
        //     end;

        //     trigger OnValidate();
        //     var
        //         ContBusinessRelation: Record "Contact Business Relation";
        //         Cont: Record Contact;
        //         Opportunity: Record Opportunity;
        //         ChangeLogMgt: Codeunit "Change Log Management";
        //         RecRef: RecordRef;
        //         xRecRef: RecordRef;
        //     begin
        //         //  <<DITW15.00.00.39 RBE 20/04/2011 #1230
        //         if "Sell-to Contact No." <> '' then begin
        //             Cont.GET("Sell-to Contact No.");
        //             ContBusinessRelation.RESET;
        //             ContBusinessRelation.SETCURRENTKEY("Link to Table", "No.");
        //             ContBusinessRelation.SETRANGE("Link to Table", ContBusinessRelation."Link to Table"::Customer);
        //             ContBusinessRelation.SETRANGE("No.", "Customer No.");
        //             if ContBusinessRelation.FINDFIRST then
        //                 if ContBusinessRelation."Contact No." <> Cont."Company No." then
        //                     ERROR(Text2013910, Cont."No.", Cont.Name, "Customer No.");
        //         end;
        //         //  >>DITW15.00.00.39 RBE #1230
        //     end;
        // }
        // field(2013912; "Base Calendar Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Base Calendar Code',
        //                 FRA = 'Code calendrier principal';
        //     Description = 'DITW15.00.00.39 RBE 20/04/2011 #1230';
        //     TableRelation = "Base Calendar";
        // }
        // field(2013913; "Customer Filter"; Code[20])
        // {
        //     CaptionML = ENU = 'Customer Filter',
        //                 FRA = 'Filtre client';
        //     Description = 'DITW15.00.00.39 #1230';
        //     FieldClass = FlowFilter;
        //     TableRelation = Customer;
        // }
        // field(2013916; "Date Filter"; Date)
        // {
        //     CaptionML = ENU = 'Date Filter',
        //                 FRA = 'Filtre date';
        //     Description = 'DITW15.00.00.39 DDR 15/07/2011 #1230';
        //     FieldClass = FlowFilter;
        // }
        // field(2013920; "No. of Calls"; Integer)
        // {
        //     CalcFormula = Count("Telesales Entry" where("Customer No." = FIELD("Customer Filter"),
        //                                                  "Calling Date" = FIELD("Date Filter"),
        //                                                  "Ship-to Code" = FIELD(Code),
        //                                                  "Call Status" = FIELD("Call Status Filter"),
        //                                                  Closed = FIELD("Call Closed Filter")));
        //     CaptionML = ENU = 'No. of Calls',
        //                 FRA = 'Nbre d''appels';
        //     Description = 'DITW15.00.00.39 DDR 15/07/2011 #1230';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013940; "Call Closed Filter"; Boolean)
        // {
        //     CaptionML = ENU = 'Closed Call Filter',
        //                 FRA = 'Filtre appel clôturé';
        //     Description = 'DITW15.00.00.39 DDR 15/07/2011 #1230';
        //     FieldClass = FlowFilter;
        // }
        // field(2013941; "Call Status Filter"; Option)
        // {
        //     CaptionML = ENU = 'Calling Status Filter',
        //                 FRA = 'Filtre Status de l''appel';
        //     Description = 'DITW15.00.00.39 DDR 15/07/2011 #1230';
        //     FieldClass = FlowFilter;
        //     OptionCaptionML = ENU = ' ,No Sale,Ring Back,Customer Rings Back,LeftVoicemail,Sent Email,Unable To Contact,Next Schedule,Goods Ordered',
        //                       FRA = ' ,Pas de vente,Rappeler,Client va rappeler,Messagerie vocale,courrier électronique Envoyé,Impossible de contacter,Horaire suivant,Marchandises commandées';
        //     OptionMembers = " ","No Sale","Ring Back","Customer Rings Back",LeftVoicemail,"Sent Email","Unable To Contact","Next Schedule","Goods Ordered";
        // }
        // field(2014060; "Picking Type"; Option)
        // {
        //     CaptionML = ENU = 'Picking Type',
        //                 FRA = 'Type de prélèvement';
        //     Description = 'DITW17.00.02 DIT-770 #154';
        //     OptionCaptionML = ENU = ' ,Order,Combined',
        //                       FRA = ' ,Commande,Regroupée';
        //     OptionMembers = " ","Order",Combined;
        // }
        // field(2014061; "Truck Zone"; Option)
        // {
        //     CaptionML = ENU = 'Truck Zone',
        //                 FRA = 'Zone de camion';
        //     Description = 'DITW17.00.02 DIT-770 #154';
        //     OptionCaptionML = ENU = ' ,Right,Left',
        //                       FRA = ' ,Droite,Gauche';
        //     OptionMembers = " ",Right,Left;
        // }
        // field(2014062; "Shipment Date Formula"; DateFormula)
        // {
        //     CaptionML = ENU = 'Shipment Date Formula',
        //                 FRA = 'Formule date d''expédition';
        //     Description = 'DITW17.00.02 DIT-770 #146';
        // }
        // field(2014063; "Require 2 Drivers"; Boolean)
        // {
        //     CaptionML = ENU = 'Require 2 Drivers',
        //                 FRA = 'Demande 2 chauffeurs';
        //     Description = 'DITW17.00.02 DIT-770 #154';
        // }
        // field(2014064; "Ship-to Address Key No."; Code[20])
        // {
        //     CaptionML = ENU = 'Ship-to Address Key No.',
        //                 FRA = 'N° clé adresse destinataire';
        //     Description = 'DITW17.00.02 DIT-770 #154';
        // }
        // field(2014065; "Shipping Base Calendar Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Shipping Base Calendar Code',
        //                 FRA = 'Code calendrier principal transport';
        //     Description = 'DITW16.00.00.40 #1002';
        //     Editable = false;
        //     TableRelation = "Base Calendar";
        // }
        // field(2014066; "Customer Delivery Type"; Code[10])
        // {
        //     CaptionML = ENU = 'Customer Delivery Type',
        //                 FRA = 'Type Livraison Client';
        //     Description = 'DITW18.00.07 DIT-770 #1346';
        //     TableRelation = "Delivery Type".Code where(Type = CONST(Customer));
        // }
        // field(2014087; Distance; Decimal)
        // {
        //     CaptionML = ENU = 'Distance',
        //                 FRA = 'Distance';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.24';
        //     MinValue = 0;
        // }
        // field(2014100; "Salesperson Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Salesperson Code',
        //                 FRA = 'Code vendeur';
        //     Description = 'DITW16.00.00.40 #1002';
        //     TableRelation = "Salesperson/Purchaser";
        // }
        // field(2014101; "Transport time"; Text[50])
        // {
        //     CaptionML = ENU = 'Transport time (AAD)',
        //                 FRA = 'Temps de transport (DAA)';
        //     Description = 'DITW15.00.00.37';
        // }
        // field(2014107; Route; Code[20])
        // {
        //     CaptionML = ENU = 'Route',
        //                 FRA = 'Itinéraire';
        //     Description = 'DITW16.00.00.40 #1002 / DITW17.00.02 DIT-770 #154';
        //     TableRelation = Route;

        //     trigger OnValidate();
        //     var
        //         SalesHeader: Record "Sales Header";
        //         lrRouteCombination: Record "Route Combination";
        //         lrRoute: Record Route;
        //     begin
        //         //<<DITW17.00.02 TEC1 12/09/2013 DIT-770 #154
        //         if lrRoute.GET(Route) then begin
        //             if lrRoute."Shipping Agent Code" <> '' then
        //                 "Shipping Agent Code" := lrRoute."Shipping Agent Code";
        //             if lrRoute."Shipping Agent Service Code" <> '' then
        //                 "Shipping Agent Service Code" := lrRoute."Shipping Agent Service Code";
        //         end;

        //         lrRouteCombination.RESET;
        //         lrRouteCombination.SETRANGE("No.", "Customer No.");
        //         lrRouteCombination.SETRANGE("Address Code", Code);
        //         lrRouteCombination.SETRANGE(Code, Route);
        //         if not lrRouteCombination.FINDFIRST then begin
        //             lrRouteCombination.INIT;
        //             lrRouteCombination."No." := "Customer No.";
        //             lrRouteCombination."Address Code" := Code;
        //             lrRouteCombination.Code := Route;
        //             lrRouteCombination.INSERT;
        //         end;
        //         //>>DITW17.00.02 TEC1 DIT-770 #154
        //     end;
        // }
        // field(2014271; "Tax Warehouse Reference"; Text[20])
        // {
        //     CaptionML = ENU = 'Tax Warehouse Reference',
        //                 FRA = 'Entrepôt fiscal de référence';
        //     Description = 'DITW15.00.00.38 #1217';
        // }
        // field(2014290; "Journey Time"; DateFormula)
        // {
        //     CaptionML = ENU = 'Journey Time (EMCS)',
        //                 FRA = 'Temps de trajet (EMCS)';
        //     Description = 'DITW15.00.00.39 #1353';
        // }
        // field(2014360; "Customer Price Group"; Code[10])
        // {
        //     CaptionML = ENU = 'Customer Price Group',
        //                 FRA = 'Groupe prix client';
        //     Description = 'DIT-715 #247';
        //     TableRelation = "Customer Price Group";
        // }
        // field(2014410; "Shipment Date Alert Filter"; DateFormula)
        // {
        //     CaptionML = ENU = 'Shipment Date Alert Filter',
        //                 FRA = 'Filtre alerte date d''expedition';
        //     Description = 'DITW17.10.05 DIT-770 #754';
        // }
        // field(2014411; "Shipment Status Alert Filter"; Option)
        // {
        //     CaptionML = ENU = 'Shipment Status Alert Filter',
        //                 FRA = 'Filtre Alerte Statut expedition';
        //     Description = 'DITW17.10.05 DIT-770 #754';
        //     OptionCaptionML = ENU = 'Open,Picklist Printed,Assigned,Picked,Shipped,Return completed,Invoice',
        //                       FRA = 'Ouvert,Prélèvement imprimé,Affecté,Prélevé,Expédié,Retour terminée,Facturée';
        //     OptionMembers = Open,"Picklist Printed",Assigned,Picked,Shipped,"Return completed",Invoice;
        // }
        // field(2014412; "Return Location Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Return Location Code',
        //                 FRA = 'Code Magasin Retour';
        //     Description = 'DITW19.00.08 BL#10756';
        //     TableRelation = Location.Code where("Use As In-Transit" = CONST(false));
        // }
        // field(2014460; "Tax Office Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Tax Office Code',
        //                 FRA = 'Code Bureau de taxe';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Tax Office";
        // }
        // field(2014464; "Transaction Type"; Code[10])
        // {
        //     CaptionML = ENU = 'Transaction Type',
        //                 FRA = 'Type de transaction';
        //     Description = 'DITW15.00.00.38';
        //     TableRelation = "Transaction Type";
        // }
        // field(2014465; "Transport Method"; Code[10])
        // {
        //     CaptionML = ENU = 'Transport Method',
        //                 FRA = 'Mode de transport';
        //     Description = 'DITW15.00.00.38';
        //     TableRelation = "Transport Method";
        // }
        // field(2014466; "Transaction Specification"; Code[10])
        // {
        //     CaptionML = ENU = 'Transaction Specification',
        //                 FRA = 'Régime';
        //     Description = 'DITW15.00.00.38';
        //     TableRelation = "Transaction Specification";
        // }
        // field(2014467; "Exit Point"; Code[10])
        // {
        //     CaptionML = ENU = 'Exit Point',
        //                 FRA = 'Pays destination';
        //     Description = 'DITW15.00.00.38';
        //     TableRelation = "Entry/Exit Point";
        // }
        // field(2014470; "Area"; Code[10])
        // {
        //     CaptionML = ENU = 'Area',
        //                 FRA = 'Dépt destination/provenance';
        //     Description = 'DITW15.00.00.38';
        //     TableRelation = Area;
        // }
        // field(2014495; "Delivery Sequence"; Integer)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU = 'Delivery Sequence',
        //                 FRA = 'Séquence de livraison';
        //     Description = 'DITW15.00.00.39 RBE 21/04/2011 #1230';
        // }
        // field(2014509; Default; Boolean)
        // {
        //     CalcFormula = Exist(Customer where("No." = FIELD("Customer No."),
        //                                         "Ship-to Code" = FIELD(Code)));
        //     CaptionML = ENU = 'Default',
        //                 FRA = 'Par défaut';
        //     Description = 'DITW16.00.00.43 DIT-715 #604';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014513; "Invoice Posting"; Option)
        // {
        //     CaptionML = ENU = 'Invoice Posting',
        //                 FRA = 'Validation facture';
        //     Description = 'DITW17.00.02 DIT-770 #141';
        //     OptionCaptionML = ENU = ' ,Shipment,Order,Combine Shipments,Combine Shipments Per Sell-to',
        //                       FRA = ' ,Expédition,Commande,Combiner expeditions,Combiner les expeditions par donneur d''ordre';
        //     OptionMembers = " ",Shipment,"Order","Combine Shipments","Combine Shipments Per Sell-to";
        // }
        // field(2014514; "Invoice Period"; Option)
        // {
        //     CaptionML = ENU = 'Invoice Period',
        //                 FRA = 'Période de facturation';
        //     Description = 'DITW17.00.02 DIT-770 #154, #338';
        //     OptionCaptionML = ENU = ' ,Direct Delivery,Order,Event,Daily,Weekly,Half Montly,Montly',
        //                       FRA = ' ,Livraison,Commande,Evenement,Quotidiennement,hebdomadaire, Motié mensuel,Mensuel';
        //     OptionMembers = " ","Direct Delivery","Order","Order Manually",Daily,Weekly,"Half Montly",Montly;
        // }
        // field(2029613; "VAT Bus. Posting Group"; Code[10])
        // {
        //     CaptionML = ENU = 'VAT Bus. Posting Group',
        //                 FRA = 'Groupe compta. marché TVA';
        //     Description = 'FINXL8.00.001';
        //     TableRelation = "VAT Business Posting Group";
        // }
        // field(2029614; "Ship-to"; Boolean)
        // {
        //     CaptionML = ENU = 'Ship-to Address',
        //                 FRA = 'Adresse destinataire';
        //     Description = 'FINXL8.00.001';
        //     InitValue = true;
        // }
        // field(2029615; "Bill-to"; Boolean)
        // {
        //     CaptionML = ENU = 'Billing Address',
        //                 FRA = 'Adresse Facturation';
        //     Description = 'FINXL8.00.001';
        // }
        // field(2030010; GLN; Code[50])
        // {
        //     CaptionML = ENU = 'GLN',
        //                 FRA = 'GLN';
        //     Description = 'IPLXL9.00.001';
        // }  // BC Upgrade NANDIS03
    }
    keys
    {
        key(Key50000; GLN)  // BC Upgrade NANDIS03
        {
        }
    }


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Cust.GET("Customer No.");
    Name := Cust.Name;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    Cust.GET("Customer No.");
    Name := Cust.Name;
    //<< DITW17.10.05 YHE 02/09/2014 DIT-770 #754
    "Shipment Date Alert Filter" := Cust."Shipment Date Alert Filter" ;
    "Shipment Status Alert Filter" := Cust."Shipment Status Alert Filter";
    //>> DITW17.10.05 YHE 02/09/2014 DIT-770 #754

    // <<DITW16.00.00.40 DDR 12/12/2011 #1002
    ///? "Shipping Base Calendar Code" := Cust."Base Calendar Code";
    // >>DITW16.00.00.40 DDR #1002

    //  <<DITW15.00.00.39 RBE 20/04/2011 #1230
    if "Sell-to Contact No." = '' then
      fctUpdateSellToCont("Customer No.");
    //  >>DITW15.00.00.39 RBE #1230
    */
    //end;


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
        rShipmentMethod: Record "Shipment Method";
        Text2013660: TextConst ENU = 'You must specify %1 in %2 or %3 or %4 when %5 %6.', FRA = 'Vous devez spécifier %1 dans %2 ou %3 ou %4 quand %5 %6.';
        Text2013910: TextConst ENU = 'Contact %1 %2 is related to a different company than customer %3.', FRA = 'Le contact %1 %2 est associé à une société différente de celle du client %3.';
}

