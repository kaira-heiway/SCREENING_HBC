tableextension 50148 EntrySummaryExtFND extends "Entry Summary"
{
    //     HEI.01 CHG2075364 IBM.LS      22.07.2021
    //   # Created New Fields: 50000 - Zone Code
    //                         50001 - Empty Expiration Date
    // version NAVW18.00,QXL9.00.001,DITW18.00

    fields
    {
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify("Table ID")
        {
            CaptionML = ENU = 'Table ID', FRA = 'ID table';
        }
        modify("Summary Type")
        {
            CaptionML = ENU = 'Summary Type', FRA = 'Nom de la table';
        }
        modify("Total Quantity")
        {
            CaptionML = ENU = 'Total Quantity', FRA = 'Quantité totale';
        }
        modify("Total Reserved Quantity")
        {
            CaptionML = ENU = 'Total Reserved Quantity', FRA = 'Quantité totale réservée';
        }
        modify("Total Available Quantity")
        {
            CaptionML = ENU = 'Total Available Quantity', FRA = 'Quantité totale disponible';
        }
        modify("Current Reserved Quantity")
        {
            CaptionML = ENU = 'Current Reserved Quantity', FRA = 'Réservation en cours';
        }
        modify("Source Subtype")
        {
            CaptionML = ENU = 'Source Subtype', FRA = 'Sous-type origine';
        }
        modify("Qty. Alloc. in Warehouse")
        {
            CaptionML = ENU = 'Qty. Alloc. in Warehouse', FRA = 'Qté. allouée en entrepôt';
        }
        modify("Res. Qty. on Picks & Shipmts.")
        {
            CaptionML = ENU = 'Res. Qty. on Picks & Shipmts.', FRA = 'Qté rés. sur prélèvements et livraisons';
        }
        modify("Serial No.")
        {
            CaptionML = ENU = 'Serial No.', FRA = 'N° de série';
        }
        modify("Lot No.")
        {
            CaptionML = ENU = 'Lot No.', FRA = 'N° lot';
        }
        modify("Warranty Date")
        {
            CaptionML = ENU = 'Warranty Date', FRA = 'Date garantie';
        }
        modify("Expiration Date")
        {
            CaptionML = ENU = 'Expiration Date', FRA = 'Date d''expiration';
        }
        modify("Total Requested Quantity")
        {
            CaptionML = ENU = 'Total Requested Quantity', FRA = 'Quantité totale demandée';
        }
        modify("Selected Quantity")
        {
            CaptionML = ENU = 'Selected Quantity', FRA = 'Quantité sélectionnée';
        }
        modify("Current Pending Quantity")
        {
            CaptionML = ENU = 'Current Pending Quantity', FRA = 'Quantité suspendue actuelle';
        }
        modify("Current Requested Quantity")
        {
            CaptionML = ENU = 'Current Requested Quantity', FRA = 'Quantité demandée actuelle';
        }
        modify("Bin Content")
        {
            CaptionML = ENU = 'Bin Content', FRA = 'Contenu emplacement';
        }
        modify("Bin Active")
        {
            CaptionML = ENU = 'Bin Active', FRA = 'Empl. actif';
        }
        modify("Non-specific Reserved Qty.")
        {
            CaptionML = ENU = 'Non-specific Reserved Qty.', FRA = 'Qté réservée non spécifique';
        }
        modify("Double-entry Adjustment")
        {
            CaptionML = ENU = 'Double-entry Adjustment', FRA = 'Ajustement doublon';
        }

        //Unsupported feature: CodeInsertion on ""Selected Quantity"(Field 6505).OnValidate". Please convert manually.

        //trigger (Variable: TypeHelper)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Selected Quantity"(Field 6505).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Bin Active" and ("Total Available Quantity" > "Bin Content") then begin
          if "Selected Quantity" > "Bin Content" then
            ERROR(Text001,"Bin Content");
        end else
          if "Selected Quantity" > "Total Available Quantity" then
            ERROR(Text001,"Total Available Quantity");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Bin Active" and ("Total Available Quantity" > "Bin Content") then begin
          AvailableToSelect := QtyAvailableToSelectFromBin;
          if "Selected Quantity" > AvailableToSelect then
            ERROR(Text001,TypeHelper.Maximum(0,AvailableToSelect));
        #4..6
        */
        //end;
        field(50000; "Zone Code FND"; Code[10])
        {
            caption = 'Zone Code';
            Description = 'HEI.01';
            //TableRelation = Zone.Code where("Location Code" = FIELD("Location Code"));//BC Upgrade KAPOOV01 Drink-it,Table relation defined on DRINK-IT Field.
        }
        field(50001; "Empty Expiration Date FND"; Boolean)
        {
            caption = 'Empty Expiration Date';
            Description = 'HEI.01';
        }
        // field(2035040; "SSCC No."; Code[50])
        // {
        //     CaptionML = ENU = 'SSCC No.',
        //                 FRA = 'N° de SSCC';
        //     Description = 'DITW15.00.00.38 #1139';
        // }
        // field(2035041; "SSCC Pallet No."; Code[20])
        // {
        //     CaptionML = ENU = 'SSCC Pallet No.',
        //                 FRA = 'N° pallet SSCC';
        //     Description = 'DITW15.00.00.38 #1139';
        // }
        // field(2035050; "SSCC Tracking Exist"; Boolean)
        // {
        //     CaptionML = ENU = 'SSCC Tracking Exist',
        //                 FRA = 'Existe traçabilité SSCC';
        //     Description = 'DITW15.00.00.38 #1139';
        // }
        // field(2035053; "Creation Date"; Date)
        // {
        //     CaptionML = ENU = 'Creation Date',
        //                 FRA = 'Date création';
        //     Description = 'DITW15.00.00.38 #1139';
        // }
        // field(2035054; "Creation Time"; Time)
        // {
        //     CaptionML = ENU = 'Creation Time',
        //                 FRA = 'Temps de creation';
        //     Description = 'DITW15.00.00.38 #1139';
        // }
        // field(2035055; "SSCC Mixed No."; Code[50])
        // {
        //     CaptionML = ENU = 'Mixed SSCC No.',
        //                 FRA = 'N° de SSCC mixte';
        //     Description = 'DITW16.00.00.40 DIT-715 #275';
        // }
        // field(2035117; "Sales Quality Status"; Option)
        // {
        //     CaptionML = ENU = 'Sales Quality Status',
        //                 FRA = 'Statut Qualité vente';
        //     Description = 'QXL9.00.001';
        //     OptionCaptionML = ENU = ' ,Pass,Fail',
        //                       FRA = ' ,Bon,Mauvais';
        //     OptionMembers = " ",Pass,Fail;
        // }
        // field(2035190; "Location Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Location Code',
        //                 FRA = 'Code magasin';
        //     Description = 'DITW15.00.00.38 PRODW14.00.00.08.17';
        // }
        // field(2035191; "Bin Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Bin Code',
        //                 FRA = 'Code emplacement';
        //     Description = 'DITW15.00.00.38 PRODW14.00.00.08.17';
        // }
        // field(2035249; "Item No."; Code[20])
        // {
        //     CaptionML = ENU = 'Item No.',
        //                 FRA = 'N° article';
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        // }
        // field(2035250; "Variant Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Variant Code',
        //                 FRA = 'Code variante';
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        // }
    }
    keys
    {

        //Unsupported feature: Deletion on ""Lot No.","Serial No."(Key)". Please convert manually.
        //BC Upgrade KAPOOV01 Drink-it start(Comment keys having drink-it fields)>>
        // key(Key1; "Lot No.", "Serial No.", "SSCC No.")
        // {
        // }
        // key(Key2; "SSCC No.", "Lot No.")
        // {
        // }
        // key(Key3; "Lot No.", "SSCC No.")
        // {
        // }
        // key(Key4; "SSCC Mixed No.", "Lot No.", "SSCC No.")
        // {
        // }
        //BC Upgrade KAPOOV01 Drink-it End(Comment keys having drink-it fields)<<
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        TypeHelper: Codeunit "Type Helper";
        AvailableToSelect: Decimal;


    //Unsupported feature: PropertyModification on "Text001(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot select more than %1 units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot select more than %1 units.;FRA=Vous ne pouvez pas sélectionner plus de %1 unité(s).;
    //Variable type has not been exported.
}

