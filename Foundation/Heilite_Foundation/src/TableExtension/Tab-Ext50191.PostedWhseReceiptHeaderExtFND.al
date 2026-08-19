tableextension 50191 PostedWhseReceiptHeaderExtFND extends "Posted Whse. Receipt Header"
{
    // DITW15.00.00.21 DDR 18/06/2008 added fields
    //                                  2014062 Shipping Charge Type
    //                                  2014063 Shipping Charge No.
    //                                  2014064 Shipping Charge Per
    //                                  2014067 Total Weight (sum flowfield [Lines])
    //                                  2014068 Total Cubage (sum flowfield [Lines])
    //                                  2014075 Shipping Agent Code
    //                                  2014076 Shipping Agent Service Code
    //                                added new key
    //                              "Shipping Agent Service Code,Shipping Agent Code,Location Code,Bin Code,Status,Expected Receipt Date"
    //                              "Shipping Agent Code"
    // DITW15.00.00.25 DDR 10/10/2008 Added fields
    //                                  2014077 Truck Code
    //                                  2014078 Driver Code
    //                                  2014081 Shipping Unit Cost
    //                                  2014082 Shipping Cost Amount
    //                                  2014083 Shipping Quantity Invoiced
    //                                  2014084 Shipping Qty. Rcd. Not Invd.
    //                                Added functions
    //                                  GetFieldCaption()
    //                                  GetCaptionClass()
    // DITW15.00.00.35 DDR 19/08/2009 issue 773 Added fields
    //                                   2014092 Shipping Currency Code
    //                                Added "Shipping Currency Code" into AutoFormatExpr property for fields
    //                                  "Shipping Unit Cost","Shipping Cost Amount"
    //                 DLE 06/09/2009 issue 516 Added fields
    //                                  2014094 Physical Location Group Code
    // DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244 Added functions GetCaptionClassUom(),ShowShortcutUomValue()
    // DITW18.00.07 VSC 22/03/2016 DIT-770 #1066 New Field Flowfield "Document Shipping Costs"
    // DITW18.00.07 VSC 29/06/2016 DIT-770 #1066 Removed Fields and allign code
    //                                               2014062 "Shipping Charge Type"
    //                                               2014063 "Shipping Charge No."
    //                                               2014064 "Shipping Charge Per"
    //                                               2014081 "Shipping Unit Cost"
    //                                               2014082 "Shipping Cost Amount"
    //                                               2014083 "Shipping Quantity Invoiced"
    //                                               2014084 "Shipping Qty. Not Invd."
    //                                               2014092 "Shipping Currency Code"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.11 MSF 21/09/2017 NRQ#16082
    //                                "Require 2 Drivers"
    //                                "Driver 2 Code"
    //                                "Trailer Code"
    //                                "Route Planning No."
    //                                 Route
    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #code added to allow zones without whs advanced management
    // HEI.02 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Field created: 50000 - "Gate Entry No."
    // HEI.03 FDD-HT658 IBM.GUNERE01 06.09.2019 # Distance field added
    // HEI.04 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //   # New field created: 50004 - LSR Order No,  50005 - LSR Receipt No.

    fields
    {
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Assigned User ID")
        {
            CaptionML = ENU = 'Assigned User ID', FRA = 'Code utilisateur affecté';
        }
        modify("Assignment Date")
        {
            CaptionML = ENU = 'Assignment Date', FRA = 'Date affectation';
        }
        modify("Assignment Time")
        {
            CaptionML = ENU = 'Assignment Time', FRA = 'Heure affectation';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Zone Code")
        {
            CaptionML = ENU = 'Zone Code', FRA = 'Code zone';
        }
        modify("Bin Code")
        {
            CaptionML = ENU = 'Bin Code', FRA = 'Code emplacement';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Vendor Shipment No.")
        {
            CaptionML = ENU = 'Vendor Shipment No.', FRA = 'N° B.L. fournisseur';
        }
        modify("Whse. Receipt No.")
        {
            CaptionML = ENU = 'Whse. Receipt No.', FRA = 'N° réception entrepôt';
        }
        modify("Document Status")
        {
            CaptionML = ENU = 'Document Status', FRA = 'Statut document';
            OptionCaptionML = ENU = ' ,Partially Put Away,Completely Put Away', FRA = ' ,Partiellement rangé,Entièrement rangé';
        }
        field(50000; "Gate Entry No. FND"; Code[20])
        {
            Caption = 'Gate Entry No.';
            Description = 'HEI.02';
            Editable = false;
            TableRelation = "Gate Entry Header FND";
        }
        //BC upgrade SHARMP16 BEGIN>>------- Interface fields
        // field(50004; "LSR Order No."; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.04';
        // }
        // field(50005; "LSR Receipt No."; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     Description = 'HEI.04';
        // }
        //BC upgrade SHARMP16 end<<------- Interface fields

        //BC upgrade SHARMP16 Begin>>------- Drink-It fields
        // field(2014067; "Total Weight"; Decimal)
        // {
        //     CalcFormula = Sum("Posted Whse. Receipt Line".Weight where("No." = FIELD("No.")));
        //     CaptionML = ENU = 'Total Weight',
        //                 FRA = 'Poids total';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.21';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014068; "Total Cubage"; Decimal)
        // {
        //     CalcFormula = Sum("Posted Whse. Receipt Line".Cubage where("No." = FIELD("No.")));
        //     CaptionML = ENU = 'Total Volume (Cubage)',
        //                 FRA = 'Volume (Cubage) total';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.21';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014071; "Document Shipping Costs"; Boolean)
        // {
        //     CalcFormula = Exist("Posted Document Shipping Cost" where("Source Type" = CONST(7318),
        //                                                                "Source No." = FIELD("No.")));
        //     CaptionML = ENU = 'Document Shipping Costs',
        //                 FRA = 'Document Frais livraison';
        //     Description = 'DIT-770 #1066';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014075; "Shipping Agent Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Shipping Agent Code',
        //                 FRA = 'Code transporteur';
        //     Description = 'DITW15.00.00.21';
        //     TableRelation = "Shipping Agent";
        // }
        // field(2014076; "Shipping Agent Service Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Shipping Agent Service Code',
        //                 FRA = 'Code prestation transporteur';
        //     Description = 'DITW15.00.00.21';
        //     TableRelation = "Shipping Agent Services".Code where("Shipping Agent Code" = FIELD("Shipping Agent Code"));
        // }
        // field(2014077; "Truck Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Truck Code',
        //                 FRA = 'Code camion';
        //     Description = 'DITW15.00.00.25';
        //     TableRelation = "Whse. Shipping Truck";
        // }
        // field(2014078; "Driver Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Driver Code',
        //                 FRA = 'Code chauffeur';
        //     Description = 'DITW15.00.00.23.04';
        //     TableRelation = "Whse. Shipping Driver";
        // }
        // field(2014087; Distance; Decimal)
        // {
        //     CaptionML = ENU = 'Distance',
        //                 FRA = 'Distance';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'HEI.03';
        //     MinValue = 0;

        //     trigger OnValidate();
        //     begin
        //         //<< DITW18.00.07 VSC 05/03/2016 DIT-770 #1066
        //         //Field will be removed after onshot conversion to new tables
        //         //>> DITW18.00.07 VSC DIT-770 #1066
        //     end;
        // }
        // field(2014094; "Physical Location Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Physical Location Group Code',
        //                 FRA = 'Code groupe magasin réel';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Physical Location Group";
        // }
        // field(2014098; "Require 2 Drivers"; Boolean)
        // {
        //     Caption = 'Require 2 Drivers';
        //     Description = 'NRQ16082';
        // }
        // field(2014099; "Driver 2 Code"; Code[10])
        // {
        //     Caption = 'Driver 2 Code';
        //     Description = 'NRQ16082';
        // }
        // field(2014100; "Trailer Code"; Code[10])
        // {
        //     Caption = 'Trailer Code';
        //     Description = 'NRQ16082';
        //     TableRelation = "Whse. Shipping Truck";
        // }
        // field(2014107; Route; Code[20])
        // {
        //     Caption = 'Route';
        //     Description = 'NRQ16082';
        //     TableRelation = Route;
        // }
        // field(2014109; "Route Planning No."; Code[20])
        // {
        //     Caption = 'Route Planning No.';
        //     Description = 'NRQ16082';
        //     TableRelation = "Route Planning Worksheet";

        //     trigger OnValidate();
        //     var
        //         RoutePlanningWorksheet: Record "Route Planning Worksheet";
        //     begin
        //     end;
        // }
        //BC upgrade SHARMP16 End<<------- Drink-It fields
    }
    keys
    {
        // key(Key1; "Shipping Agent Service Code", "Shipping Agent Code", "Location Code", "Bin Code")
        // {
        // }        //BC upgrade SHARMP16 Begin>>------- Drink-It fields used
        // key(Key2; "Shipping Agent Code")
        // {
        // }        //BC upgrade SHARMP16 Begin>>------- Drink-It fields used
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You must first set up user %1 as a warehouse employee.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You must first set up user %1 as a warehouse employee.;FRA=Vous devez d'abord configurer l'utilisateur %1 en tant que magasinier.;
    //Variable type has not been exported.
}

