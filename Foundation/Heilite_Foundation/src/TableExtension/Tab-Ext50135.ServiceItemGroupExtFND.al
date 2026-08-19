tableextension 50135 ServiceItemGroupExtFND extends "Service Item Group"
{
    // version NAVW18.00,DITW110.00.12A

    // DITW15.00.00.35 DDR 24/04/2009 Added fields
    //                                  2034877 FA Template Code
    //                                  2034878 Create Fixed Asset
    // DITW15.00.00.38 DDR 09/12/2010 issue 1189 Added fields
    //                                  2034909 Allow Grouping Fixed Asset
    // DITW15.00.00.39 DDR 17/08/2011 issue 1258 Added fields
    //                                  2034929 Reuse Service Item
    //                                  2034930 Default Return Reason Code
    // DITW16.00.00.41 DDR 21/06/2012 DIT-715 #297 Plant Maintenance Functionnality
    //                                             Added functions GetCaptionClassPM(),SetCaptionClassPM()
    //                                             Added flowfilters
    //                                               2034942 Plant Maintenance Caption
    //                 DDR 17/09/2012 DIT-715 #297 Bugfix length local variables for function GetCaptionClassPM()
    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.10.03 MSF 03/03/2014 DIT-770 #300 :Loan in use - service item for multi deliveries of one item
    //                                           Added Fields 2014410 - "Free reason code"
    //                                                        2014411 - "Recurring"Boolean"
    // DITW18.00.06 DDR 15/04/2015 DIT-770 #983 Review functions GetCaptionClassPM(),SetCaptionClassPM()
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    // DITW110.00.12A ISL 21/06/2018 NRQ#67425 Added new field 2034943 "Create On"
    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Field created: 50000 - Truck No.

    fields
    {
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Create Service Item")
        {
            CaptionML = ENU = 'Create Service Item', FRA = 'Créer article de service';
        }
        modify("Default Contract Discount %")
        {
            CaptionML = ENU = 'Default Contract Discount %', FRA = '% remise contrat par défaut';
        }
        modify("Default Serv. Price Group Code")
        {
            CaptionML = ENU = 'Default Serv. Price Group Code', FRA = 'Code gpe tarifs serv. par déf.';
        }
        modify("Default Response Time (Hours)")
        {
            CaptionML = ENU = 'Default Response Time (Hours)', FRA = 'Délai de réponse par déf. (heures)';
        }
        field(50000; "Truck No. FND"; Code[20])   // BC Upgrade NANDIS03 - Field id should be 50000, but in NAV its 5000
        {
            caption = 'Truck No.';
            Description = 'HEI.01';
            //TableRelation = "Whse. Shipping Truck";  // BC Upgrade NANDIS03 - Table releation blocked as its a APtean table
        }
        // field(2014410; "Free reason code"; Code[10])
        // {
        //     CaptionML = ENU = 'Free Reason Code',
        //                 FRA = 'Code motif gratuit';
        //     Description = 'DITW17.10.03 DIT-770 #300';
        //     TableRelation = "Free Reason Code".Code;
        // }
        // field(2014411; Recurring; Boolean)
        // {
        //     CaptionML = ENU = 'Recurring',
        //                 FRA = 'Abonnement';
        //     Description = 'DITW17.10.03 DIT-770 #300';
        // }
        // field(2034877; "FA Template Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Fixed Asset Template Code',
        //                 FRA = 'Code modèle immobilisation';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "FA Template";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.35 DDR 24/04/2009 - DITW15.00.00.38 DDR 09/12/2010 #1189
        //         VALIDATE("Create Fixed Asset", "FA Template Code" <> '');
        //     end;
        // }
        // field(2034878; "Create Fixed Asset"; Boolean)
        // {
        //     CaptionML = ENU = 'Create Fixed Asset',
        //                 FRA = 'Créer immobilisation';
        //     Description = 'DITW15.00.00.35';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.35 DDR 24/04/2009
        //         if not "Create Fixed Asset" then begin
        //             CLEAR("FA Template Code");
        //             CLEAR("Create FA G/L Journal");
        //             // <<DITW15.00.00.38 DDR 09/12/2010 #1189
        //             CLEAR("Allow Grouping Fixed Asset");
        //             // >>DITW15.00.00.38 DDR #1189
        //         end;
        //     end;
        // }
        // field(2034879; "Create FA G/L Journal"; Boolean)
        // {
        //     CaptionML = ENU = 'Create Fixed Asset G/L Journal',
        //                 FRA = 'Créer Feuille compta. immo.';
        //     Description = 'DITW15.00.00.35';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.35 DDR 24/04/2009 - DITW15.00.00.38 DDR 09/12/2010 #1189
        //         if "Create FA G/L Journal" then
        //             TESTFIELD("Create Fixed Asset");
        //     end;
        // }
        // field(2034909; "Allow Grouping Fixed Asset"; Boolean)
        // {
        //     CaptionML = ENU = 'Allow Grouping Fixed Asset',
        //                 FRA = 'Regroupement immobilisation autorisé';
        //     Description = 'DITW15.00.00.38 #1189';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 09/12/2010 #1189
        //         if "Allow Grouping Fixed Asset" then
        //             TESTFIELD("Create Fixed Asset");
        //     end;
        // }
        // field(2034929; "Reuse Service Item"; Boolean)
        // {
        //     CaptionClass = GetCaptionClassPM(FIELDCAPTION("Reuse Service Item"), Text2014310_2034929);
        //     CaptionML = ENU = 'Reuse Service Item',
        //                 FRA = 'Réutiliser article de service';
        //     Description = 'DITW15.00.00.39 #1258';
        // }
        // field(2034930; "Default Return Reason Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Default Return Reason Code',
        //                 FRA = 'Code motif retour par défaut';
        //     Description = 'DITW15.00.00.39 #1258';
        //     TableRelation = "Return Reason";
        // }
        // field(2034942; "Plant Maintenance Caption"; Boolean)
        // {
        //     CaptionML = ENU = 'Plant Maintenance Caption',
        //                 FRA = 'Label Maintenance Usine';
        //     Description = 'DITW16.00.00.41 DIT-715 #297';
        //     FieldClass = FlowFilter;
        // }
        // field(2034943; "Create On"; Option)
        // {
        //     Caption = 'Create On';
        //     Description = 'DITW110.00.12A NRQ#67425';
        //     OptionCaption = 'Sales,Purchase';
        //     OptionMembers = Sales,Purchase;
        // }  // BC Upgrade NANDIS03 - Aptean code blocked
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        RunModeCaptionPM: Boolean;
        Text2014310_3: TextConst ENU = 'Create Equipment', FRA = 'Créer Equipement';
        Text2014310_2034929: TextConst ENU = 'Reuse Equipment', FRA = 'Réutiliser Equipement';
}

