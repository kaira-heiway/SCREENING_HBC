tableextension 50059 ReservationEntryExtFND extends "Reservation Entry"
{
    // version NAVW110.0,QXL9.00.001,OWM4.50,DITW110.00.09,HEI.04
    // DITW15.00.00.38 DDR 25/10/2010 issue 1139 SSCC Functionnalities
    //                                  Added functions TextCaptionDoc()
    //                     10/12/2010 issue 1139 (DIT711 101) Modified function TextCaptionKeyTable()
    // DITW16.00.00.40 DDR 03/02/2012 #1331 (HIT0069.1 VVE 19/04/2011) FEFO tracking
    //                                  Added key "Item No.,Lot No.,Serial No.,Source Type,Source Subtype,Source ID,Source Ref. No."
    //                                  + Sumindexfield "Quantity (Base)"
    // DITW16.00.00.42 DDR 05/03/2013 DIT-715 #574 Added "Item Tracking" into key
    //                                   "Source ID,Source Ref. No.,Source Type,Source Subtype,Source Batch Name,Source Prod. Order Line,
    //                                   ...Reservation Status,Shipment Date,Expected Receipt Date,Item Tracking"
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM
    //                                             NORRIQ owm - Online Warehouse Management
    //                                             Copyright 2008 by NORRIQ A/S, www.norriq.dk
    //                                               New Key: Source Type,Source Subtype,Serial No.
    //                                                        Source Type,Source Subtype,Source ID,Reservation Status,Location Code,Item No.,Lot No.,Serial No.

    // FINXL7.00.001 RBE 20/03/2013: Item description extend from 30 -> 80 chars

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 DDR 13/07/2015 DIT-770 #1258 Modified properties of key
    //                                             "Source ID,Source Ref. No.,Source Type,Source Subtype,Source Batch Name,Source Prod. Order Line,
    //                                             ...Reservation Status,Shipment Date,Expected Receipt Date,Item Tracking"
    // DITW19.00.08 DDR 29/09/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                      Added fields
    //                                                        2013716 Strength Spec. Code
    //                                                        2013717 Strength Spec. Value
    //                                                        2013720 New Strength Spec. Value
    // DITW19.00.08 DDR 17/10/2016 BL#10443 Modified function GetTaxSpecCaption()
    // DITW19.00.08 DDR 20/10/2016 BL#10443 Bugfix function GetTaxSpecCaption()
    //                                      Added "Vol-Strength Spec. Value" into all SumIndexFields of keys
    //                                      Added functions UpdateVSonQtyHandle(),CalcVolumeStrength()
    //                                      Added fields
    //                                        2013718 "Vol-Strength Spec. Code"
    //                                        2013719 "Vol-Strength Spec. Value"
    //                                        2013721 "New Vol-Strength Spec. Value"
    // DITW19.00.08A VSC 05/01/2017 BL#10443 New function UpdateNewVSonQtyHandle
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 YHE 15/03/2017 NRQ#24111 merge DIT2016 W1 R8A
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // DITW110.00.09 AKH 30/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // DITW110.00.09 VSC 12/04/2017 NRQ#18376 Fix Multiply bij Qty
    // DITW110.00.09 VSC 12/04/2017 NRQ#18376 New function InitStrengthValues
    // HEI.01 CHG2075364 IBM.LS      21.07.2021
    //   # Created New Field: 50000 - Zone Code
    //   # Added Code
    // HEI.02 CHG2119481 IBM.LS      10.12.2021
    //   # Created New Fields: 50001 - KG/HL
    //                         50002 - Weight of Extract
    //   # Modified Fields (KG/HL and Weight of Extract) Editable property as No
    // HEI.03 CHG2119481 IBM.LS      21.01.2022
    //   # Created New Field: 50003 - Reference No.
    // HEI.04 HB1487 - CHG2070737 IBM NASTAA02 18.04.2022 # Mass Upload of Production Orders
    //   # New Field created: 50004 - Created from Import PO
    // BC Upgrade NANDIS03 - As per primary analysis Code against HEI.01 does not need to be added in BC as standard functionality is changed

    //BC Upgrade Kamnay01  Created this table  extension to add the field  for "Your Reference" . This field is required for FDD-DTW 006
    fields
    {
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify("Item No.")
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
        }
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Quantity (Base)")
        {
            CaptionML = ENU = 'Quantity (Base)', FRA = 'Quantité (base)';
        }
        modify("Reservation Status")
        {
            CaptionML = ENU = 'Reservation Status', FRA = 'Etat de la réservation';
            //OptionCaptionML = ENU = 'Reservation,Tracking,Surplus,Prospect', FRA = 'Réservation,Suivi,Excédent,Prospect';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Creation Date")
        {
            CaptionML = ENU = 'Creation Date', FRA = 'Date création';
        }
        modify("Transferred from Entry No.")
        {
            CaptionML = ENU = 'Transferred from Entry No.', FRA = 'Transféré de l''écriture n°';
        }
        modify("Source Type")
        {
            CaptionML = ENU = 'Source Type', FRA = 'Type origine';
        }
        modify("Source Subtype")
        {
            CaptionML = ENU = 'Source Subtype', FRA = 'Sous-type origine';
            OptionCaptionML = ENU = '0,1,2,3,4,5,6,7,8,9,10', FRA = '0,1,2,3,4,5,6,7,8,9,10';
        }
        modify("Source ID")
        {
            CaptionML = ENU = 'Source ID', FRA = 'ID origine';
        }
        modify("Source Batch Name")
        {
            CaptionML = ENU = 'Source Batch Name', FRA = 'Nom feuille origine';
        }
        modify("Source Prod. Order Line")
        {
            CaptionML = ENU = 'Source Prod. Order Line', FRA = 'Ligne O.F. origine';
        }
        modify("Source Ref. No.")
        {
            CaptionML = ENU = 'Source Ref. No.', FRA = 'N° réf. origine';
        }
        modify("Item Ledger Entry No.")
        {
            CaptionML = ENU = 'Item Ledger Entry No.', FRA = 'N° écriture comptable article';
        }
        modify("Expected Receipt Date")
        {
            CaptionML = ENU = 'Expected Receipt Date', FRA = 'Date réception prévue';
        }
        modify("Shipment Date")
        {
            CaptionML = ENU = 'Shipment Date', FRA = 'Date de préparation';
        }
        modify("Serial No.")
        {
            CaptionML = ENU = 'Serial No.', FRA = 'N° de série';
        }
        modify("Created By")
        {
            CaptionML = ENU = 'Created By', FRA = 'Créé par';
        }
        modify("Changed By")
        {
            CaptionML = ENU = 'Changed By', FRA = 'Modifié par';
        }
        modify(Positive)
        {
            CaptionML = ENU = 'Positive', FRA = 'Positif';
        }
        modify("Qty. per Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Unit of Measure', FRA = 'Quantité par unité';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Action Message Adjustment")
        {

            //Unsupported feature: Change CalcFormula on ""Action Message Adjustment"(Field 31)". Please convert manually.

            CaptionML = ENU = 'Action Message Adjustment', FRA = 'Ajustement message d''action';
        }
        modify(Binding)
        {
            CaptionML = ENU = 'Binding', FRA = 'Lien';
            //OptionCaptionML = ENU = ' ,Order-to-Order', FRA = ' ,Ordre pour ordre';
        }
        modify("Suppressed Action Msg.")
        {
            CaptionML = ENU = 'Suppressed Action Msg.', FRA = 'Message d''action supprimé';
        }
        modify("Planning Flexibility")
        {
            CaptionML = ENU = 'Planning Flexibility', FRA = 'Flexibilité planification';
           // OptionCaptionML = ENU = 'Unlimited,None', FRA = 'Illimitée,Aucune';
        }
        modify("Appl.-to Item Entry")
        {
            CaptionML = ENU = 'Appl.-to Item Entry', FRA = 'Écr. article à lettrer';
        }
        modify("Warranty Date")
        {
            CaptionML = ENU = 'Warranty Date', FRA = 'Date garantie';
        }
        modify("Expiration Date")
        {
            CaptionML = ENU = 'Expiration Date', FRA = 'Date d''expiration';
        }
        modify("Qty. to Handle (Base)")
        {
            CaptionML = ENU = 'Qty. to Handle (Base)', FRA = 'Quantité à traiter (base)';
        }
        modify("Qty. to Invoice (Base)")
        {
            CaptionML = ENU = 'Qty. to Invoice (Base)', FRA = 'Qté à facturer (base)';
        }
        modify("Quantity Invoiced (Base)")
        {
            CaptionML = ENU = 'Quantity Invoiced (Base)', FRA = 'Quantité facturée (base)';
        }
        modify("New Serial No.")
        {
            CaptionML = ENU = 'New Serial No.', FRA = 'Nouveau n° de série';
        }
        modify("New Lot No.")
        {
            CaptionML = ENU = 'New Lot No.', FRA = 'Nouveau n° lot';
        }
        modify("Disallow Cancellation")
        {
            CaptionML = ENU = 'Disallow Cancellation', FRA = 'Interdire l''annulation';
        }
        modify("Lot No.")
        {
            CaptionML = ENU = 'Lot No.', FRA = 'N° lot';
        }
        modify("Variant Code")
        {

            //Unsupported feature: Change TableRelation on ""Variant Code"(Field 5401)". Please convert manually.

            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify("Appl.-from Item Entry")
        {
            CaptionML = ENU = 'Appl.-from Item Entry', FRA = 'Écriture article à lettrer';
        }
        modify(Correction)
        {
            CaptionML = ENU = 'Correction', FRA = 'Correction';
        }
        modify("New Expiration Date")
        {
            CaptionML = ENU = 'New Expiration Date', FRA = 'Nouvelle date expiration';
        }
        modify("Item Tracking")
        {
            CaptionML = ENU = 'Item Tracking', FRA = 'Traçabilité';
           // OptionCaptionML = ENU = 'None,Lot No.,Lot and Serial No.,Serial No.', FRA = 'Aucun,N° lot,N° lot et de série,N° de série';
        }

        //Unsupported feature: CodeModification on ""Quantity (Base)"(Field 4).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Quantity := CalcReservationQuantity;
        "Qty. to Handle (Base)" := "Quantity (Base)";
        "Qty. to Invoice (Base)" := "Quantity (Base)";
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        // <<DITW19.00.08 DDR 20/10/2016 BL#10443
        UpdateVSonQtyHandle;
        // >>DITW19.00.08 DDR BL#10443
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Qty. to Handle (Base)"(Field 50)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW19.00.08 DDR 20/10/2016 BL#10443
        UpdateVSonQtyHandle;
        // >>DITW19.00.08 DDR BL#10443
        */
        //end;
        field(50000; "Zone Code FND"; Code[10])
        {
            Description = 'HEI.01';
            Caption = 'Zone Code';
            TableRelation = Zone.Code where("Location Code" = FIELD("Location Code"));
        }
        field(50001; "KG/HL FND"; Decimal)
        {
            Caption = 'KG/HL';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50002; "Weight of Extract FND"; Decimal)
        {
            Caption = 'Weight of Extract';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50003; "Reference No. FND"; Code[20])
        {
            Caption = 'Reference No.';
            Description = 'HEI.03';
            Editable = false;
        }
        field(50004; "Created from Import PO FND"; Boolean)
        {
            Caption = 'Created from Import PO';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(54000; "Your Reference FND"; Text[30])
        {
            Caption = 'Your Reference';
            DataClassification = ToBeClassified;
        }
        // field(2013716; "Strength Spec. Code"; Code[20])
        // {
        //     CaptionClass = GetTaxSpecCaption(0, FIELDNO("Strength Spec. Code"));
        //     CaptionML = ENU = 'Strength Spec. Code',
        //                 FRA = 'Code contrainte spécification taxe';
        //     Description = 'DITW19.00.08 BL#10443';
        //     TableRelation = "Tax Specification" where(Type = CONST(Specification));
        // }
        // field(2013717; "Strength Spec. Value"; Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Strength Spec. Value"));
        //     AutoFormatType = 2013664;
        //     CaptionClass = GetTaxSpecCaption(1, FIELDNO("Strength Spec. Value"));
        //     CaptionML = ENU = 'Strength Spec. Value',
        //                 FRA = 'Valeur contrainte spécification';
        //     Description = 'DITW19.00.08 BL#10443';
        // }
        // field(2013718; "Vol-Strength Spec. Code"; Code[20])
        // {
        //     CaptionClass = GetTaxSpecCaption(0, FIELDNO("Vol-Strength Spec. Code"));
        //     CaptionML = ENU = 'Vol-Strength Spec. Code',
        //                 FRA = 'Code spécification contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';
        //     TableRelation = "Tax Specification" where(Type = CONST(Specification));
        // }
        // field(2013719; "Vol-Strength Spec. Value"; Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Vol-Strength Spec. Value"));
        //     AutoFormatType = 2013664;
        //     CaptionClass = GetTaxSpecCaption(1, FIELDNO("Vol-Strength Spec. Value"));
        //     CaptionML = ENU = 'Vol-Strength Spec. Value',
        //                 FRA = 'Valeur spécification contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';
        // }
        // field(2013720; "New Strength Spec. Value"; Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("New Strength Spec. Value"));
        //     AutoFormatType = 2013664;
        //     CaptionClass = GetTaxSpecCaption(1, FIELDNO("New Strength Spec. Value"));
        //     CaptionML = ENU = 'New Strength Spec. Value',
        //                 FRA = 'Nouvelle valeur spécification contrainte';
        //     Description = 'DITW19.00.08 BL#10443';
        // }
        // field(2013721; "New Vol-Strength Spec. Value"; Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("New Vol-Strength Spec. Value"));
        //     AutoFormatType = 2013664;
        //     CaptionClass = GetTaxSpecCaption(1, FIELDNO("New Vol-Strength Spec. Value"));
        //     CaptionML = ENU = 'New Vol-Strength Spec. Value',
        //                 FRA = 'Nouvelle valeur spécification contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';
        // }
        // field(2035098; "Your Reference"; Text[30])
        // {
        //     CaptionML = ENU = 'Your Reference',
        //                 FRA = 'Votre référence';
        //     Description = 'QXL9.00.001';
        // }
        // field(2035172; "Gyle No."; Code[20])
        // {
        //     CaptionML = ENU = 'Gyle No.',
        //                 FRA = 'Gyle N°';
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        // }
        // field(2035191; "Bin Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Bin Code',
        //                 FRA = 'Code emplacement';
        //     Description = '#1331';
        //     TableRelation = Bin.Code where("Location Code" = FIELD("Location Code"));
        // }  // BC Upgrade NANDIS03
    }
    keys
    {

        //Unsupported feature: PropertyChange on ""Source ID","Source Ref. No.","Source Type","Source Subtype","Source Batch Name","Source Prod. Order Line","Reservation Status","Shipment Date","Expected Receipt Date"(Key)". Please convert manually.


        //Unsupported feature: PropertyChange on ""Item No.","Variant Code","Location Code","Reservation Status","Shipment Date","Expected Receipt Date","Serial No.","Lot No."(Key)". Please convert manually.


        //Unsupported feature: PropertyChange on ""Item No.","Source Type","Source Subtype","Reservation Status","Location Code","Variant Code","Shipment Date","Expected Receipt Date","Serial No.","Lot No."(Key)". Please convert manually.


        //Unsupported feature: PropertyChange on ""Item No.","Variant Code","Location Code","Item Tracking","Reservation Status","Lot No.","Serial No."(Key)". Please convert manually.

        // key(Key1; "Item No.", "Lot No.", "Serial No.", "Source Type", "Source Subtype", "Source ID", "Source Ref. No.")
        // {
        //     SumIndexFields = "Quantity (Base)", "Vol-Strength Spec. Value";
        // }
        // key(Key2; "Source Type", "Source Subtype", "Serial No.")
        // {
        // }
        // key(Key3; "Source Type", "Source Subtype", "Source ID", "Reservation Status", "Location Code", "Item No.", "Lot No.", "Serial No.")
        // {
        // }  // BC Upgrade NANDIS03
    }


    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger (Variable: SSCCLineReserv)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ActionMessageEntry.SETCURRENTKEY("Reservation Entry");
    ActionMessageEntry.SETRANGE("Reservation Entry","Entry No.");
    ActionMessageEntry.DELETEALL;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3

    // <<DITW15.00.00.38 DDR 25/10/2010 - 24/11/2010 #1139
    if SSCCSetup.READPERMISSION then
      SSCCLineReserv.DeleteLineTrigger(Rec);
    // >>DITW15.00.00.38 DDR #1139
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    // var
    //     SSCCLineReserv: Codeunit "SSCC Line-Reserve";  // BC Upgrade NANDIS03

    var
        //SSCCLedgEntry: Record "SSCC Ledger Entry";  // BC Upgrade NANDIS03
        WhseActivityLineL: Record "Warehouse Activity Line";


    //Unsupported feature: PropertyModification on "Text001(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=Line;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=Line;FRA=Ligne;
    //Variable type has not been exported.

    var
        //SSCCSetup: Record "SSCC Setup";  // BC Upgrade NANDIS03
        Item: Record Item;
}

