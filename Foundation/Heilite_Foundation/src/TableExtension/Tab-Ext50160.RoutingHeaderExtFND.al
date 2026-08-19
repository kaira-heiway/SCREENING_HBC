tableextension 50160 RoutingHeaderExtFND extends "Routing Header"
{
    // version NAVW110.0,QXL9.00.001,DITW110.00.09,HEI.01

    //     DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008: BrewIt & Quality
    // DITW15.00.00.27 PRODW14.03.00.08.05 DLE 25/10/2008: Added new Field: "Auto Recreate New Test Line"

    // FINXL7.00.001 RBE 20/03/2013: Item description extend from 30 -> 80 chars

    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // DITW110.00.09 AKH 30/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9

    // HEI.01 FDD-GAPID043 IBM LAZARE02 01.09.2017 # New fields: Linked Item No., Linked SKU
    fields
    {
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Description 2")
        {
            CaptionML = ENU = 'Description 2', FRA = 'Désignation 2';
        }
        modify("Search Description")
        {
            CaptionML = ENU = 'Search Description', FRA = 'Désignation de recherche';
        }
        modify("Last Date Modified")
        {
            CaptionML = ENU = 'Last Date Modified', FRA = 'Date dern. modification';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify(Status)
        {
            CaptionML = ENU = 'Status', FRA = 'Statut';
            //OptionCaptionML = ENU = 'New,Certified,Under Development,Closed', FRA = 'Création en cours,Validée,Modification en cours,Clôturée';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            OptionCaptionML = ENU = 'Serial,Parallel', FRA = 'Séquentielle,Parallèle';
        }
        modify("Version Nos.")
        {
            CaptionML = ENU = 'Version Nos.', FRA = 'N° version';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        field(50000; "Linked Item No. FND"; Code[20])
        {
            Caption = 'Linked Item No.';
            Description = 'HEI.01';
            TableRelation = Item;
        }
        field(50001; "Linked SKU FND"; Code[10])
        {
            Caption = 'Linked SKU';
            Description = 'HEI.01';
            TableRelation = "Stockkeeping Unit"."Location Code" where("Item No." = FIELD("Linked Item No. FND"));

            //BC UPGRADE PATHAA02 StdCost-FDD DTW 16>>
            trigger OnValidate()
            var
                item: Record Item;
            begin
                if Rec."Linked SKU FND" <> xRec."Linked SKU FND" then begin
                    if item.Get(Rec."Linked Item No. FND") then begin
                        item."Routing No." := Rec."No.";
                        item.Modify();
                    end;
                end;
            end;
            //BC UPGRADE PATHAA02 StdCost-FDD DTW 16<<
        }
        /* //BCUPGRADE YADAVM09 Drink it field commented>>
        field(2035116; "Quality Measures Status"; Option)
        {
            CaptionML = ENU = 'Status',
                        FRA = 'Statut';
            Description = 'QXL9.00.001';
            OptionCaptionML = ENU = 'New,Certified,Under Development,Closed',
                              FRA = 'Création en cours,Validée,Modification en cours,Clôturée';
            OptionMembers = New,Certified,"Under Development",Closed;
        }
        field(2035117; "Auto Recreate New Test Line"; Boolean)
        {
            CaptionML = ENU = 'Auto Recreate New Test',
                        FRA = 'Auto-créer nouveau test';
            Description = 'QXL9.00.001';
        }
        */ //BCUPGRADE YADAVM09 Drink it field commented<<
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=This Routing is being used on Items.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=This Routing is being used on Items.;FRA=Cette gamme est utilisée dans des articles.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=All versions attached to the routing will be closed. Close routing?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=All versions attached to the routing will be closed. Close routing?;FRA=Toutes les versions rattachées à la gamme vont être clôturées. Souhaitez-vous clôturer la gamme ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=You cannot rename the %1 when %2 is %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=You cannot rename the %1 when %2 is %3.;FRA=Vous ne pouvez pas renommer l'enregistrement %1 lorsque la valeur %2 est %3.;
    //Variable type has not been exported.
}

