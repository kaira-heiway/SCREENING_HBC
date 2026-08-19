tableextension 50152 WarehouseJournalLineExtFND extends "Warehouse Journal Line"
{
    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 # Added FIELDS In-Transit Zone Code,In-Transit Bin Code,Zone-Transfer,Reference Line No.,
    //                                             Transfer Type,Transit-Zone,Movement No.
    // HEI.02 PRDGAP038 IBM HORTO01 16.10.2017 - fill in "Quality status"
    // HEI.03 CHG2154364 SAHAL01 15.03.2023 Astro - I/F Production - ProductionOrderOperationLinePick
    //   # Created New Fields: 50010 - External Document No.
    //                         50011 - External Document No.2
    // version NAVW110.0,OWM4.50,DITW110.00.09,HEI.03

    fields
    {
        modify("Journal Template Name")
        {
            CaptionML = ENU = 'Journal Template Name', FRA = 'Nom modèle feuille';
        }
        modify("Journal Batch Name")
        {
            CaptionML = ENU = 'Journal Batch Name', FRA = 'Nom feuille';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify("Registering Date")
        {
            CaptionML = ENU = 'Registering Date', FRA = 'Date enregistrement';
        }
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("From Zone Code")
        {
            CaptionML = ENU = 'From Zone Code', FRA = 'Du code zone';
        }
        modify("From Bin Code")
        {
            CaptionML = ENU = 'From Bin Code', FRA = 'Du code emplacement';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Item No.")
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Qty. (Base)")
        {
            CaptionML = ENU = 'Qty. (Base)', FRA = 'Qté (base)';
        }
        modify("Qty. (Absolute)")
        {
            CaptionML = ENU = 'Qty. (Absolute)', FRA = 'Qté (absolue)';
        }
        modify("Qty. (Absolute, Base)")
        {
            CaptionML = ENU = 'Qty. (Absolute, Base)', FRA = 'Qté (absolue, base)';
        }
        modify("Zone Code")
        {
            CaptionML = ENU = 'Zone Code', FRA = 'Code zone';
            //BC Upgrade KAPOOV01>>
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.01 PRDGAP024>>
                IF "Zone Code" <> '' THEN BEGIN
                    WHSUTILS.CheckUserAuthorizedinZone("Location Code", "Zone Code");//BC Upgrade GUNREM01 added
                    VALIDATE("Bin Code", '');
                end;
                //HEI.01 PRDGAP024<<  
            end;

            //BC Upgrade KAPOOV01<<
        }
        modify("Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""Bin Code"(Field 15)". Please convert manually.

            CaptionML = ENU = 'Bin Code', FRA = 'Code emplacement';
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
        modify("Source No.")
        {
            CaptionML = ENU = 'Source No.', FRA = 'N° origine';
        }
        modify("Source Line No.")
        {
            CaptionML = ENU = 'Source Line No.', FRA = 'N° ligne origine';
        }
        modify("Source Subline No.")
        {
            CaptionML = ENU = 'Source Subline No.', FRA = 'N° sous-ligne origine';
        }
        modify("Source Document")
        {
            CaptionML = ENU = 'Source Document', FRA = 'Document origine';
            // OptionCaptionML = ENU = ',S. Order,S. Invoice,S. Credit Memo,S. Return Order,P. Order,P. Invoice,P. Credit Memo,P. Return Order,Inb. Transfer,Outb. Transfer,Prod. Consumption,Item Jnl.,Phys. Invt. Jnl.,Reclass. Jnl.,Consumption Jnl.,Output Jnl.,BOM Jnl.,Serv Order,Job Jnl.,Assembly Consumption,Assembly Order', FRA = ',Cde vente,Fact. vente,Avoir vente,Retour vente,Cde achat,Fact. achat,Avoir achat,Retour achat,Enlog. transf.,Désenlog. transf.,Consommation O.F.,F. article,F. inventaire,F. reclass.,F. conso.,F. prod.,F. nomencl.,Cde serv,Feuille projet,Consommation d''assemblage,Ordre d''assemblage';
        }
        modify("Source Code")
        {
            CaptionML = ENU = 'Source Code', FRA = 'Code journal';
        }
        modify("To Zone Code")
        {
            CaptionML = ENU = 'To Zone Code', FRA = 'Vers code zone';
        }
        modify("To Bin Code")
        {
            CaptionML = ENU = 'To Bin Code', FRA = 'Vers code emplacement';
        }
        modify("Reason Code")
        {
            CaptionML = ENU = 'Reason Code', FRA = 'Code motif';
        }
        modify("Registering No. Series")
        {
            CaptionML = ENU = 'Registering No. Series', FRA = 'Enregistrement des n° de série';
        }
        modify("From Bin Type Code")
        {
            CaptionML = ENU = 'From Bin Type Code', FRA = 'Du code type emplacement';
        }
        modify(Cubage)
        {
            CaptionML = ENU = 'Cubage', FRA = 'Cubage';
        }
        modify(Weight)
        {
            CaptionML = ENU = 'Weight', FRA = 'Poids';
        }
        modify("Whse. Document No.")
        {
            CaptionML = ENU = 'Whse. Document No.', FRA = 'N° document entrepôt';
        }
        modify("Whse. Document Type")
        {
            CaptionML = ENU = 'Whse. Document Type', FRA = 'Type document entrepôt';
            // OptionCaptionML = ENU = 'Whse. Journal,Receipt,Shipment,Internal Put-away,Internal Pick,Production,Whse. Phys. Inventory, ,Assembly', FRA = 'Feuille entrepôt,Réception,Expédition,Rangement interne,Prélèvement interne,Production,Inventaire entrepôt, ,Assemblage';
        }
        modify("Whse. Document Line No.")
        {
            CaptionML = ENU = 'Whse. Document Line No.', FRA = 'N° ligne document entrep.';
        }
        modify("Qty. (Calculated)")
        {
            CaptionML = ENU = 'Qty. (Calculated)', FRA = 'Qté (calculée)';
        }
        modify("Qty. (Phys. Inventory)")
        {
            CaptionML = ENU = 'Qty. (Phys. Inventory)', FRA = 'Qté (constatée)';
        }
        modify("Entry Type")
        {
            CaptionML = ENU = 'Entry Type', FRA = 'Type écriture';
            OptionCaptionML = ENU = 'Negative Adjmt.,Positive Adjmt.,Movement', FRA = 'Ajust. négatif,Ajust. positif,Mouvement';
        }
        modify("Phys. Inventory")
        {
            CaptionML = ENU = 'Phys. Inventory', FRA = 'Inventaire';
        }
        modify("Reference Document")
        {
            CaptionML = ENU = 'Reference Document', FRA = 'Document référence';
            // OptionCaptionML = ENU = ' ,Posted Rcpt.,Posted P. Inv.,Posted Rtrn. Rcpt.,Posted P. Cr. Memo,Posted Shipment,Posted S. Inv.,Posted Rtrn. Shipment,Posted S. Cr. Memo,Posted T. Receipt,Posted T. Shipment,Item Journal,Prod.,Put-away,Pick,Movement,BOM Journal,Job Journal,Assembly', FRA = ' ,Récept. enreg.,Fact. achat enreg.,Récept. retour enreg.,Avoir achat enreg.,Expéd. enreg.,Fact. vente enreg.,Expéd. retour enreg.,Avoir vente enreg.,Récept. transf. enreg.,Expéd. transf. enreg.,Feuille article,Fabrication,Rangement,Prélèvement,Mouvement,Feuille nomencl.,Feuille projet,Assemblage';
        }
        modify("Reference No.")
        {
            CaptionML = ENU = 'Reference No.', FRA = 'N° référence';
        }
        modify("User ID")
        {
            CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
        }
        modify("Qty. (Calculated) (Base)")
        {
            CaptionML = ENU = 'Qty. (Calculated) (Base)', FRA = 'Qté (calculée) (base)';
        }
        modify("Qty. (Phys. Inventory) (Base)")
        {
            CaptionML = ENU = 'Qty. (Phys. Inventory) (Base)', FRA = 'Qté (constatée) (base)';
        }
        modify("Variant Code")
        {
            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify("Qty. per Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Unit of Measure', FRA = 'Quantité par unité';
        }
        modify("Unit of Measure Code")
        {
            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
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
        modify("New Serial No.")
        {
            CaptionML = ENU = 'New Serial No.', FRA = 'Nouveau n° de série';
        }
        modify("New Lot No.")
        {
            CaptionML = ENU = 'New Lot No.', FRA = 'Nouveau n° lot';
        }
        modify("New Expiration Date")
        {
            CaptionML = ENU = 'New Expiration Date', FRA = 'Nouvelle date expiration';
        }
        modify("Phys Invt Counting Period Code")
        {
            CaptionML = ENU = 'Phys Invt Counting Period Code', FRA = 'Code période inventaire stock';
        }
        modify("Phys Invt Counting Period Type")
        {
            CaptionML = ENU = 'Phys Invt Counting Period Type', FRA = 'Type période inventaire';
            OptionCaptionML = ENU = ' ,Item,SKU', FRA = ' ,Article,Point de stock';
        }

        //Unsupported feature: CodeModification on ""Zone Code"(Field 14).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if not PhysInvtEntered then
          TESTFIELD("Phys. Inventory",false);

        #4..7
          VALIDATE("From Zone Code","Zone Code")
        else
          VALIDATE("To Zone Code","Zone Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..10
        //HEI.01 PRDGAP024>>
        if "Zone Code" <> '' then begin
          WHSUTILS.CheckUserAuthorizedinZone("Location Code","Zone Code");
          VALIDATE("Bin Code",'');
        end;
        //HEI.01 PRDGAP024<<
        */
        //end;
        field(50000; "In-Transit Zone Code FND"; Code[10])
        {
            Caption = 'From Zone Code';
            Description = 'HEI.01 PRDGAP024';
            TableRelation = Zone.Code where("Location Code" = FIELD("Location Code"));

            trigger OnValidate();
            begin
                if not PhysInvtEntered then
                    TESTFIELD("Phys. Inventory", false);

                if "From Zone Code" <> xRec."From Zone Code" then begin
                    "From Bin Code" := '';
                    "From Bin Type Code" := '';
                end;
            end;
        }
        field(50001; "In-Transit Bin Code FND"; Code[20])
        {
            Caption = 'From Bin Code';
            Description = 'HEI.01 PRDGAP024';
            TableRelation = IF ("Phys. Inventory" = CONST(false),
                                "Item No." = FILTER(''),
                                "From Zone Code" = FILTER('')) "Bin Content"."Bin Code" where("Location Code" = FIELD("Location Code"))
            else IF ("Phys. Inventory" = CONST(false),
                                         "Item No." = FILTER(<> ''),
                                         "From Zone Code" = FILTER('')) "Bin Content"."Bin Code" where("Location Code" = FIELD("Location Code"),
                                                                                                      "Item No." = FIELD("Item No."))
            else IF ("Phys. Inventory" = CONST(false),
                                                                                                               "Item No." = FILTER(''),
                                                                                                               "From Zone Code" = FILTER(<> '')) "Bin Content"."Bin Code" where("Location Code" = FIELD("Location Code"),
                                                                                                                                                                              "Zone Code" = FIELD("From Zone Code"))
            else IF ("Phys. Inventory" = CONST(false),
                                                                                                                                                                                       "Item No." = FILTER(<> ''),
                                                                                                                                                                                       "From Zone Code" = FILTER(<> '')) "Bin Content"."Bin Code" where("Location Code" = FIELD("Location Code"),
                                                                                                                                                                                                                                                      "Item No." = FIELD("Item No."),
                                                                                                                                                                                                                                                      "Zone Code" = FIELD("From Zone Code"))
            else IF ("Phys. Inventory" = CONST(true),
                                                                                                                                                                                                                                                               "From Zone Code" = FILTER('')) Bin.Code where("Location Code" = FIELD("Location Code"))
            else IF ("Phys. Inventory" = CONST(true),
                                                                                                                                                                                                                                                                        "From Zone Code" = FILTER(<> '')) Bin.Code where("Location Code" = FIELD("Location Code"),
                                                                                                                                                                                                                                                                                                                       "Zone Code" = FIELD("From Zone Code"));

            trigger OnValidate();
            begin
                if not PhysInvtEntered then
                    TESTFIELD("Phys. Inventory", false);

                if CurrFieldNo = FIELDNO("From Bin Code") then
                    if "From Bin Code" <> xRec."From Bin Code" then
                        CheckBin("Location Code", "From Bin Code", false);

                "From Bin Type Code" :=
                  GetBinType("Location Code", "From Bin Code");

                Bin.CALCFIELDS("Adjustment Bin");
                Bin.TESTFIELD("Adjustment Bin", false);

                if "From Bin Code" <> '' then
                    "From Zone Code" := Bin."Zone Code";
            end;
        }
        field(50002; "Zone-Transfer FND"; Boolean)
        {
            caption = 'Zone-Transfer';
            Description = 'HEI.01 PRDGAP024';
        }
        field(50003; "Reference Line No. FND"; Integer)
        {
            caption = 'Reference Line No.';
            Description = 'HEI.01 PRDGAP024';
        }
        field(50004; "Transfer Type FND"; Option)
        {
            caption = 'Transfer Type';
            Description = 'HEI.01 PRDGAP024';
            OptionMembers = " ",Shipment,Receipt;
        }
        field(50005; "Transit-Zone FND"; Boolean)
        {
            caption = 'Transit-Zone';
            Description = 'HEI.01 PRDGAP024';
        }
        field(50006; "Movement No. FND"; Code[20])
        {
            caption = 'Movement No.';
            Description = 'HEI.01 PRDGAP024';
        }
        field(50007; "Quality Status FND"; Option)
        {
            Caption = 'Quality Status';
            Description = 'HEI.02';
            Editable = false;
            OptionCaption = 'Quality Hold,Unrestricted,Blocked';
            OptionMembers = "Quality Hold",Unrestricted,Blocked;
        }
        field(50010; "External Document No. FND"; Code[35])
        {
            Caption = 'External Document No.';
            Description = 'HEI.03';
        }
        field(50011; "External Document No.2 FND"; Code[35])
        {
            Caption = 'External Document No.2';
            Description = 'HEI.03';
        }
        //BC Upgrade KAPOOV01 Drink-it>>
        // field(2034983; "Work Order No."; Code[20])
        // {
        //     CaptionML = ENU = 'Work Order No.',
        //                 FRA = 'N° cmde. d''intervention';
        //     Description = 'DIT-715 #457';
        //     TableRelation = "Service Header"."No." where("Document Type" = CONST(Order),
        //                                                   "PM Order Status" = CONST(Released));
        // }
        // field(2034986; "Work Order Line No."; Integer)
        // {
        //     CaptionML = ENU = 'Work Order Line No.',
        //                 FRA = 'N° ligne cmde. d''intervention';
        //     Description = 'DIT-715 #457';
        // }
        // field(2035040; "SSCC No."; Code[50])
        // {
        //     CaptionML = ENU = 'SSCC No.',
        //                 FRA = 'N° SSCC';
        //     Description = 'DITW16.00.00.40 DIT-715 #274';

        //     trigger OnLookup();
        //     begin
        //         SSCCTrackingMgt.LookupLotSerialNoInfo("Item No.", "Variant Code", 1, "SSCC No.");
        //     end;

        //     trigger OnValidate();
        //     begin
        //         if "SSCC No." <> '' then
        //             SSCCTrackingMgt.CheckWhseItemTrkgSetup("Item No.", SCRequired, SCLNRequired, true);
        //     end;
        // }
        // field(2035042; "New SSCC No."; Code[50])
        // {
        //     CaptionML = ENU = 'New SSCC No.',
        //                 FRA = 'Nouveau N° de SSCC';
        //     Description = 'DITW16.00.00.40 DIT-715 #274';
        // }
        // field(2035045; "Applies-from SSCC Entry"; Integer)
        // {
        //     CaptionML = ENU = 'Applies-from Entry',
        //                 FRA = 'Lettrage à partir écriture';
        //     Description = 'DITW16.00.00.43 DIT-715 #634';
        //     MinValue = 0;
        // }
        // field(2035046; "SSCC Adjustment"; Boolean)
        // {
        //     CaptionML = ENU = 'SSCC Adjustment',
        //                 FRA = 'Ajustement SSCC';
        //     Description = 'DITW16.00.00.43 DIT-715 #745';
        // }
        //BC Upgrade KAPOOV01 Drink-it<<
    }

    keys
    {
        key(Key50000; "Journal Template Name", "Journal Batch Name", "Item No.")//BC Upgrade KAPOOV01 change key name from key1 to key50000.
        {
        }
        key(Key50001; "Journal Template Name", "Journal Batch Name", "Location Code", "Item No.", "Bin Code", "Lot No.", "Serial No.")//BC Upgrade KAPOOV01 change key name from key2 to key50002.
        {
        }
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ItemTrackingMgt.DeleteWhseItemTrkgLines(
      DATABASE::"Warehouse Journal Line",0,"Journal Batch Name",
      "Journal Template Name",0,"Line No.","Location Code",true);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    // <<DITW16.00.00.40 DDR 02/03/2012 DIT-715 #274
    SSCCTrackingMgt.DeleteWhseItemTrkgLines(
      DATABASE::"Warehouse Journal Line",0,"Journal Batch Name",
      "Journal Template Name",0,"Line No.","Location Code",true);
    // >>DITW16.00.00.40 DDR DIT-715 #274
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1009)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=must not be negative;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=must not be negative;FRA=ne doit pas être de signe négatif;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1014)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=%1 Journal;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=%1 Journal;FRA=Feuille %1;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1013)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=DEFAULT;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=DEFAULT;FRA=DEFAUT;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1012)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=Default Journal;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=Default Journal;FRA=Feuille par défaut;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1010)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=You must first set up user %1 as a warehouse employee.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=You must first set up user %1 as a warehouse employee.;FRA=Vous devez d'abord configurer l'utilisateur %1 en tant que magasinier.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=The location %1 of warehouse journal batch %2 is not enabled for user %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=The location %1 of warehouse journal batch %2 is not enabled for user %3.;FRA=Le magasin %1 de la feuille entrepôt %2 n'est pas actif pour l'utilisateur %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1017)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=%1 must be 0 or 1 for an Item tracked by Serial Number.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=%1 must be 0 or 1 for an Item tracked by Serial Number.;FRA=%1 doit être 0 ou 1 pour un article portant un numéro de série.;
    //Variable type has not been exported.
    //BC Upgrade KAPOOV01>>
    local procedure CheckBin(LocationCode: Code[10]; BinCode: Code[20]; Inbound: Boolean)
    var
        BinContent: Record "Bin Content";
        WhseJnlLine: Record "Warehouse Journal Line";
    begin

        IF (BinCode <> '') AND ("Item No." <> '') THEN BEGIN
            GetLocation(LocationCode);
            IF BinCode = Location."Adjustment Bin Code" THEN
                EXIT;
            BinContent.SetProposalMode(StockProposal);
            IF Inbound THEN BEGIN
                GetBinType(LocationCode, BinCode);
                IF Location."Bin Capacity Policy" IN
                   [Location."Bin Capacity Policy"::"Allow More Than Max. Capacity",
                    Location."Bin Capacity Policy"::"Prohibit More Than Max. Cap."]
                THEN BEGIN
                    WhseJnlLine.SETCURRENTKEY("To Bin Code", "Location Code");
                    WhseJnlLine.SETRANGE("To Bin Code", BinCode);
                    WhseJnlLine.SETRANGE("Location Code", LocationCode);
                    WhseJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
                    WhseJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
                    WhseJnlLine.SETRANGE("Line No.", "Line No.");
                    WhseJnlLine.CALCSUMS("Qty. (Absolute)", Cubage, Weight);
                end;
                IF BinContent.GET(
                     "Location Code", BinCode, "Item No.", "Variant Code", "Unit of Measure Code")
                THEN
                    BinContent.CheckIncreaseBinContent(
                      "Qty. (Absolute, Base)", WhseJnlLine."Qty. (Absolute, Base)",
                      WhseJnlLine.Cubage, WhseJnlLine.Weight, Cubage, Weight, FALSE, FALSE)
                else BEGIN
                    GetBin(LocationCode, BinCode);
                    Bin.CheckIncreaseBin(
                      BinCode, "Item No.", "Qty. (Absolute)",
                      WhseJnlLine.Cubage, WhseJnlLine.Weight, Cubage, Weight, FALSE, FALSE);
                end;
            end else BEGIN
                BinContent.GET(
                  "Location Code", BinCode, "Item No.", "Variant Code", "Unit of Measure Code");
                IF BinContent."Block Movement" IN [
                                                   BinContent."Block Movement"::Outbound, BinContent."Block Movement"::All]
                THEN
                    IF NOT StockProposal THEN
                        BinContent.FIELDERROR("Block Movement");
            end;
            BinContent.SetProposalMode(FALSE);
        end;

    end;

    local procedure GetLocation(LocationCode: Code[10])
    var
        myInt: Integer;
    begin
        IF Location.Code <> LocationCode THEN
            Location.GET(LocationCode);
        Location.TESTFIELD("Directed Put-away and Pick");
    end;

    local procedure GetBin(LocationCode: Code[10]; BinCode: Code[20])
    var
        myInt: Integer;
    begin
        IF (LocationCode = '') OR (BinCode = '') THEN
            CLEAR(Bin)
        else
            IF (Bin."Location Code" <> LocationCode) OR
               (Bin.Code <> BinCode)
            THEN
                Bin.GET(LocationCode, BinCode);
    end;
    //BC Upgrade KAPOOV01<<

    var
        WHSUTILS: Codeunit "WHS-UTILS";//BC Upgrade KAPOOV01 Codeunit
        Bin: Record Bin;//BC Upgrade KAPOOV01 added new global variable.
        Location: Record Location;//BC Upgrade KAPOOV01 added new global variable.
        SSCCTrackingMgt: Codeunit "Item Tracking Management";
        SCLNRequired: Boolean;
        SCRequired: Boolean;
        StockProposal: Boolean;//BC Upgrade KAPOOV01 added new global variable.
        Text2014412: TextConst ENU = 'Do you want to replace the existing item %1 using the item selection?', FRA = 'Souhaitez-vous remplacer l''actuel article %1 par les articles sélectionnés?';

}

