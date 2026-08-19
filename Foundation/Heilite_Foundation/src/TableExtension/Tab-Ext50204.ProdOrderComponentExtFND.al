tableextension 50204 ProdOrderComponentExtFND extends "Prod. Order Component"
{
    // version NAVW110.0.00.16177,FINXL10.00,MANXL7.00.001,DITW110.00.12A,HEI.05


    // DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008: BrewIt & Quality
    // DITW15.00.00.25.01-PRODW14.00.00.08.05A DLE 21/01/2009 License problem
    // DITW15.00.00.30-PRODW14.00.00.09 DDR 21/01/2009 merge PRODW14.00.00.08.05A
    // DITW16.00.00.40 DDR 13/06/2012 DIT-715 #338 Added functions AllItemsAvailability()
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM

    // FINXL7.00.001 RBE 21/04/2014 : Description from 50 -> 80

    // MANXL7.00.001 DAT 26/02/2014 #5: Autoreserve + Annulation for Prod. Order Comp
    // MANXL7.00.001 DAT 03/03/2014 #11: Routing Line Speed parameter
    // MANXL7.00.001 DAT 03/03/2014 #12: Version Management
    // MANXL7.00.001 WSA 15/07/2014 #87: Modify Fuctions IDs for MANXL security
    // FINXL8.00.001 BSA 02/06/2015 #178: Added field "Cross Reference No."

    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 16/02/2015 DIT-770 #1185 Get "Indirect Cost %" From SKU card
    // DITW18.00.06 MSF 15/05/2015 DIT-770 #1168 Impossible to rename item - error on field 7468520
    //                                           Change table relation for Field 2036314 "Revision No."

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 AKH 30/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #added fields Zone Code
    //                                              #added code for restriction of Zones
    // FINXL10.00 YHE 15/06/2017 NXL#29836: added code in fctValidateCrossReference
    // DITW110.00.11 SFI 31/08/2017 BL#30569 Added changes for SKU blocking
    // DITW110.00.12A HBA 07/06/2018 NRQ#51782: Added field "Production jnl. flushing" 2035266

    // HEI.02 FDD-PRDGAP024 IBM SOICAD01 25.07.2017 #Changed Zone code table relation to not show in transit zones

    // HEI.03 FDD-PRDGAPID003 & PRDGAPID027 IBM.NAIKH01 25.07.2017
    //   # Addded a new flow field  50001- "Lot No."

    // HEI.04 FDD-PRDGAPID027  IBM.NAIKH01 27.07.2017
    //   # Commented the code to Not fill the default Bin Code.

    // HEI.05 FDD-PRDGAP024 IBM POENAB01 02.08.2017 #Zone code development without whs advanced mgmt
    //   #Changed Table Relation for field 33 Bin Code
    //   #Code added in Bin Code - OnValidate()

    // HEI.06 FDD-GAPID031 IBM.PATHAA02 17.08.2017
    //   # Description made non-Editable

    // HEI.07 FDD-PRDGAP027  IBM.NAIKH01 23.08.2017
    //   # Added Code in Function "OpenItemTrackingLines()".
    //   # Added Code in trigger "Bin Code - OnValidate()".

    // HEI.08 FDD_CHG2003754 IBM ISYED01 03.19.2019
    //  #Added fix to not update BIN by default if confirm not to override bincode.

    //Bc Upgrade YADAVM09 Lot no field length changes from 20 to 50.
    //***************************************************************************
    //HEI.09 FDD-DTW002 11.03.26 #Production jnl. flushing field added to Production BOM Line table as part of BC Upgrade.
    //Field ->(DIT-F2035266-->50002)-"Production jnl. flushing" added

    //PATHAA02 14.04.26 [PID754,FDD-DTW-002,IBM GAP DTW 36]
    //# Production Jnl Flushing; to flow the boolen from Production BOM to components.


    fields
    {
        modify(Status)
        {
            CaptionML = ENU = 'Status', FRA = 'Statut';
            // OptionCaptionML = ENU = 'Simulated,Planned,Firm Planned,Released,Finished', FRA = 'Simulé,Planifié,Planifié ferme,Lancé,Terminé';
        }
        modify("Prod. Order No.")
        {
            CaptionML = ENU = 'Prod. Order No.', FRA = 'N° ordre de fabrication';
        }
        modify("Prod. Order Line No.")
        {
            CaptionML = ENU = 'Prod. Order Line No.', FRA = 'N° ligne O.F.';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify("Item No.")
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
        }
        modify(Description)
        {
            //Editable = false;// BC Upgrade YADAVM09 >>Should be handled on page level.
            CaptionML = ENU = 'Description', FRA = 'Désignation';
            //Unsupported feature: Change Description on "Description(Field 12)". Please convert manually.


            //Unsupported feature: Change Editable on "Description(Field 12)". Please convert manually.

        }
        modify("Unit of Measure Code")
        {
            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify(Position)
        {
            CaptionML = ENU = 'Position', FRA = 'Position';
        }
        modify("Position 2")
        {
            CaptionML = ENU = 'Position 2', FRA = 'Position 2';
        }
        modify("Position 3")
        {
            CaptionML = ENU = 'Position 3', FRA = 'Position 3';
        }
        modify("Lead-Time Offset")
        {
            CaptionML = ENU = 'Lead-Time Offset', FRA = 'Décalage du délai';
        }
        modify("Routing Link Code")
        {
            CaptionML = ENU = 'Routing Link Code', FRA = 'Code lien gamme';
        }
        modify("Scrap %")
        {
            CaptionML = ENU = 'Scrap %', FRA = '% perte';
        }
        modify("Variant Code")
        {
            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify("Expected Quantity")
        {
            CaptionML = ENU = 'Expected Quantity', FRA = 'Quantité prévue';
        }
        modify("Remaining Quantity")
        {
            CaptionML = ENU = 'Remaining Quantity', FRA = 'Quantité restante';
        }
        modify("Act. Consumption (Qty)")
        {
            CaptionML = ENU = 'Act. Consumption (Qty)', FRA = 'Consommation réelle (qté)';
        }
        modify("Flushing Method")
        {
            CaptionML = ENU = 'Flushing Method', FRA = 'Méthode consommation';
            //OptionCaptionML = ENU = 'Manual,Forward,Backward,Pick + Forward,Pick + Backward', FRA = 'Manuelle,Pré-déduction,Post-déduction,Prélèvement + Pré-déduction,Prélèvement + Post-déduction';
        }
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Shortcut Dimension 1 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 2 Code', FRA = 'Code raccourci axe 2';
        }
        modify("Bin Code")
        {
            TableRelation = IF ("Zone Code FND" = FILTER(<> '')) Bin.Code where("Location Code" = FIELD("Location Code"), "Zone Code" = FIELD("Zone Code FND")) else IF ("Zone Code FND" = FILTER(= '')) Bin.Code where("Location Code" = FIELD("Location Code"));//BCUPGRADE YADAVM09
            //Unsupported feature: Change TableRelation on ""Bin Code"(Field 33)". Please convert manually.

            CaptionML = ENU = 'Bin Code', FRA = 'Code emplacement';
            trigger OnAfterValidate()
            begin
                //HEI.05 PRDGAP024>>
                IF "Bin Code" <> '' THEN BEGIN
                    Bin.GET("Location Code", "Bin Code");
                    "Zone Code FND" := Bin."Zone Code";
                end;
                //HEI.05 PRDGAP024<<

                //<<HEI.07
                IF "Bin Code" <> xRec."Bin Code" THEN BEGIN
                    IF "Lot No. FND" <> '' THEN BEGIN
                        HeinekenGlobal.DeleteReservationEntryRec(Rec);
                        "Lot No. FND" := '';
                    end;
                end;
                //>>HEI.07
            end;


        }
        modify("Supplied-by Line No.")
        {
            CaptionML = ENU = 'Supplied-by Line No.', FRA = 'Approvisionnée par ligne n°';
        }
        modify("Planning Level Code")
        {
            CaptionML = ENU = 'Planning Level Code', FRA = 'Code niveau de planification';
        }
        modify("Item Low-Level Code")
        {
            CaptionML = ENU = 'Item Low-Level Code', FRA = 'Code plus bas niveau article';
        }
        modify(Length)
        {
            CaptionML = ENU = 'Length', FRA = 'Longueur';
        }
        modify(Width)
        {
            CaptionML = ENU = 'Width', FRA = 'Largeur';
        }
        modify(Weight)
        {
            CaptionML = ENU = 'Weight', FRA = 'Poids';
        }
        modify(Depth)
        {
            CaptionML = ENU = 'Depth', FRA = 'Profondeur';
        }
        modify("Calculation Formula")
        {
            CaptionML = ENU = 'Calculation Formula', FRA = 'Formule de calcul';
            // OptionCaptionML = ENU = ' ,Length,Length * Width,Length * Width * Depth,Weight', FRA = ' ,Longueur,Longueur * largeur,Longueur * largeur * profondeur,Poids';
        }
        modify("Quantity per")
        {
            CaptionML = ENU = 'Quantity per', FRA = 'Quantité par';
        }
        modify("Unit Cost")
        {
            CaptionML = ENU = 'Unit Cost', FRA = 'Coût unitaire';
        }
        modify("Cost Amount")
        {
            CaptionML = ENU = 'Cost Amount', FRA = 'Coût total';
        }
        modify("Due Date")
        {
            CaptionML = ENU = 'Due Date', FRA = 'Date besoin';
        }
        modify("Due Time")
        {
            CaptionML = ENU = 'Due Time', FRA = 'Heure besoin';
        }
        modify("Qty. per Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Unit of Measure', FRA = 'Quantité par unité';
        }
        modify("Remaining Qty. (Base)")
        {
            CaptionML = ENU = 'Remaining Qty. (Base)', FRA = 'Quantité restante (base)';
        }
        modify("Quantity (Base)")
        {
            CaptionML = ENU = 'Quantity (Base)', FRA = 'Quantité (base)';
        }
        modify("Reserved Qty. (Base)")
        {
            CaptionML = ENU = 'Reserved Qty. (Base)', FRA = 'Quantité réservée (base)';
        }
        modify("Reserved Quantity")
        {
            CaptionML = ENU = 'Reserved Quantity', FRA = 'Quantité réservée';
        }
        modify("Expected Qty. (Base)")
        {
            CaptionML = ENU = 'Expected Qty. (Base)', FRA = 'Quantité prévue (base)';
        }
        modify("Due Date-Time")
        {
            CaptionML = ENU = 'Due Date-Time', FRA = 'Date/Heure besoin';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Substitution Available")
        {
            CaptionML = ENU = 'Substitution Available', FRA = 'Substitut disponible';
        }
        modify("Original Item No.")
        {
            CaptionML = ENU = 'Original Item No.', FRA = 'N° de l''article initial';
        }
        modify("Original Variant Code")
        {
            CaptionML = ENU = 'Original Variant Code', FRA = 'Code variante initial';
        }
        modify("Pick Qty.")
        {
            CaptionML = ENU = 'Pick Qty.', FRA = 'Prélever qté';
        }
        modify("Qty. Picked")
        {
            CaptionML = ENU = 'Qty. Picked', FRA = 'Qté prélevée';
        }
        modify("Qty. Picked (Base)")
        {
            CaptionML = ENU = 'Qty. Picked (Base)', FRA = 'Qté prélevée (base)';
        }
        modify("Completely Picked")
        {
            CaptionML = ENU = 'Completely Picked', FRA = 'Entièrement prélévé';
        }
        modify("Pick Qty. (Base)")
        {
            CaptionML = ENU = 'Pick Qty. (Base)', FRA = 'Prélever qté (base)';
        }
        modify("Direct Unit Cost")
        {
            CaptionML = ENU = 'Direct Unit Cost', FRA = 'Coût unitaire direct';
        }
        modify("Indirect Cost %")
        {
            CaptionML = ENU = 'Indirect Cost %', FRA = '% coût indirect';
        }
        modify("Overhead Rate")
        {
            CaptionML = ENU = 'Overhead Rate', FRA = 'Frais généraux';
        }
        modify("Direct Cost Amount")
        {
            CaptionML = ENU = 'Direct Cost Amount', FRA = 'Coût direct total';
        }
        modify("Overhead Amount")
        {
            CaptionML = ENU = 'Overhead Amount', FRA = 'Frais généraux totaux';
        }

        //Unsupported feature: CodeModification on ""Item No."(Field 11).OnValidate". Please convert manually.//BCUPGRADE YADAVM09 Drink it code not Migrated

        //trigger "(Field 11)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WhseValidateSourceLine.ProdComponentVerifyChange(Rec,xRec);
        ReserveProdOrderComp.VerifyChange(Rec,xRec);
        CALCFIELDS("Reserved Qty. (Base)");
        #4..17
        end;
        Description := Item.Description;
        Item.TESTFIELD("Base Unit of Measure");
        VALIDATE("Unit of Measure Code",Item."Base Unit of Measure");
        GetUpdateFromSKU;
        CreateDim(DATABASE::Item,"Item No.");
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..20
        // << DITW110.00.11 SFI 31/08/2017 BL#30569
        Item.BlockedSKU("Location Code","Variant Code",true);
        // >> DITW110.00.11 SFI BL#30569
        #21..24

        // <<DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008
        if Item."Item Tracking Code" <> '' then
          "Lot Tracked" := true;
        // >>DITW15.00.00.22 PRODW14.00.00.08 DDR
        //<<FINXL8.00.001 BSA 02/06/2015 #178
        if recFinXLSetup.READPERMISSION then fctGetCrossReference;
        //>>FINXL8.00.001 BSA 02/06/2015 #178
        */
        //end;


        //Unsupported feature: CodeModification on ""Variant Code"(Field 21).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if Item."No." <> "Item No." then
          Item.GET("Item No.");
        if "Variant Code" = '' then
          Description := Item.Description
        else begin
          ItemVariant.GET("Item No.","Variant Code");
          Description := ItemVariant.Description;
        end;
        GetDefaultBin;
        WhseValidateSourceLine.ProdComponentVerifyChange(Rec,xRec);
        ReserveProdOrderComp.VerifyChange(Rec,xRec);
        #12..14
        UpdateUnitCost;
        VALIDATE("Expected Quantity");
        GetUpdateFromSKU;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..8
        // << DITW110.00.11 SFI 31/08/2017 BL#30569
        Item.BlockedSKU("Location Code","Variant Code",true);
        // >> DITW110.00.11 SFI BL#30569
        #9..17
        */
        //end;


        //Unsupported feature: CodeModification on ""Location Code"(Field 30).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if Item."No." <> "Item No." then
          Item.GET("Item No.");
        UpdateUnitCost;
        VALIDATE("Expected Quantity");

        GetDefaultBin;
        WhseValidateSourceLine.ProdComponentVerifyChange(Rec,xRec);
        ReserveProdOrderComp.VerifyChange(Rec,xRec);
        GetUpdateFromSKU;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
        // << DITW110.00.11 SFI 31/08/2017 BL#30569
        Item.BlockedSKU("Location Code","Variant Code",true);
        // >> DITW110.00.11 SFI BL#30569
        #6..9
        */
        //end;


        //Unsupported feature: CodeModification on ""Bin Code"(Field 33).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if Quantity > 0 then
          BinCode := WMSManagement.BinContentLookUp("Location Code","Item No.","Variant Code",'',"Bin Code")
        else
          BinCode := WMSManagement.BinLookUp("Location Code","Item No.","Variant Code",'');

        if BinCode <> '' then
          VALIDATE("Bin Code",BinCode);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*

        if Quantity > 0 then
        //HEI.01 PRDGAP024 delete BinCode := WMSManagement.BinContentLookUp("Location Code","Item No.","Variant Code",'',"Bin Code")
          BinCode := WMSManagement.BinContentLookUp("Location Code","Item No.","Variant Code","Zone Code","Bin Code")//HEI.01 PRDGAP024 SINGLE
        else
          //HEI.01 PRDGAP024 delete BinCode := WMSManagement.BinLookUp("Location Code","Item No.","Variant Code",'');
          BinCode := WMSManagement.BinLookUp("Location Code","Item No.","Variant Code","Zone Code");//HEI.01 PRDGAP024 SINGLE
        #5..7
        */
        //end;


        //Unsupported feature: CodeModification on ""Bin Code"(Field 33).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Bin Code" <> '' then begin
          TESTFIELD("Location Code");
          WMSManagement.FindBin("Location Code","Bin Code",'');
          WhseIntegrationMgt.CheckBinTypeCode(DATABASE::"Prod. Order Component",
            FIELDCAPTION("Bin Code"),
            "Location Code",
            "Bin Code",0);
          CheckBin;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Bin Code" <> '' then begin
          TESTFIELD("Location Code");
          // DITW17.00.02 DDR 07/11/2013 DIT-715 #806
          //GetLocation("Location Code");
          //IF Location."Skip Consumption Put-Away" <> TRUE THEN  //DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806
          //  Location.TESTFIELD("Directed Put-away and Pick",FALSE);
          //IF Quantity > 0 THEN
          //  WMSManagement.FindBinContent("Location Code","Bin Code","Item No.","Variant Code",'')
          //else
        #3..9
        //HEI.05 PRDGAP024>>
        if "Bin Code" <> '' then begin
          Bin.GET("Location Code","Bin Code");
          "Zone Code" := Bin."Zone Code";
        end;
        //HEI.05 PRDGAP024<<

        //<<HEI.07
        if "Bin Code" <> xRec."Bin Code" then begin
          if "Lot No." <>'' then begin
            HeinekenGlobal.DeleteReservationEntryRec(Rec);
            "Lot No." := '';
            end;
        end;
        //>>HEI.07
        */
        //end;
        field(50000; "Zone Code FND"; Code[10])
        {
            Caption = 'Zone Code';
            Description = 'HEI.01 PRDGAP024';
            TableRelation = Zone.Code where("Location Code" = FIELD("Location Code"),
                                             "Use As In-Transit FND" = FILTER(false));

            trigger OnValidate();
            begin
                //HEI.01 PRDGAP024>>
                if "Zone Code FND" <> '' then begin
                    WHSUTILS.CheckUserAuthorizedinZone("Location Code", "Zone Code FND");
                    VALIDATE("Bin Code", '');
                end;
                //HEI.01 PRDGAP024<<
            end;
        }
        //field(50001; "Lot No."; Code[20])//Bc Upgrade YADAVM09
        field(50001; "Lot No. FND"; Code[50])//Bc Upgrade YADAVM09
        {
            Caption = 'Lot No.';
            CalcFormula = Lookup("Reservation Entry"."Lot No." where("Source ID" = FIELD("Prod. Order No."),
                                                                      "Item No." = FIELD("Item No."),
                                                                      "Source Prod. Order Line" = FIELD("Prod. Order Line No."),
                                                                      "Source Ref. No." = FIELD("Line No."),
                                                                      "Source Type" = CONST(5407),
                                                                      "Source Subtype" = CONST("3"),
                                                                      "Lot No." = FILTER(<> '')));
            Description = 'HEI.03 FDD PRDGAP003 & 027';
            FieldClass = FlowField;
        }
        field(50002; "Production jnl. flushing FND"; Boolean)
        {
            Caption = 'Production jnl. flushing';
            Description = 'HEI.09';
        }
        /* //BC Upgrade YADAVM09 Drink it code commented>>
        field(2029610;"Cross-Reference No.";Code[20])
        {
            CaptionML = ENU='Cross-Reference No.',
                        FRA='Référence externe';
            Description = 'FINXL8.00.001';

            trigger OnLookup();
            begin
                //<<FINXL8.00.001 BSA 02/06/2015 #178
                if recFinXLSetup.READPERMISSION then fctLookupCrossReference();
                //>>FINXL8.00.001 BSA 02/06/2015 #178
            end;

            trigger OnValidate();
            begin
                //<<FINXL8.00.001 BSA 02/06/2015 #178
                if recFinXLSetup.READPERMISSION then fctValidateCrossReference;
                //>>FINXL8.00.001 BSA 02/06/2015 #178
            end;
        }
        field(2035176;"Show on Prod. Order";Boolean)
        {
            CaptionML = ENU='Show on Prod. Order',
                        FRA='Afficher sur Ordre de production';
            Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        }
        field(2035251;"Actual Quantity";Decimal)
        {
            CalcFormula = -Sum("Comp. Tracking Entry"."Quantity (Base)" WHERE ("Item No."=FIELD("Item No."),
                                                                               "Variant Code"=FIELD("Variant Code"),
                                                                               "Source Type"=CONST(5407),
                                                                               "Source ID"=FIELD("Prod. Order No."),
                                                                               "Source Prod. Order Line"=FIELD("Prod. Order Line No."),
                                                                               "Source Ref. No."=FIELD("Line No.")));
            CaptionML = ENU='Actual Quantity',
                        FRA='Quantité réel';
            DecimalPlaces = 0:5;
            Description = 'DITW15.00.00.22 PRODW14.00.00.08';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2035252;"Calculation Required";Boolean)
        {
            CaptionML = ENU='Calculation Required',
                        FRA='Calcul nécessaire';
            Description = 'DITW15.00.00.22 PRODW14.00.00.08';
            Editable = false;
        }
        field(2035260;"Principal Component";Boolean)
        {
            CaptionML = ENU='Principal Component',
                        FRA='Composant principal';
            Description = 'DITW15.00.00.22 PRODW14.00.00.08';
            Editable = false;
        }
        field(2035261;"Lot Tracked";Boolean)
        {
            CaptionML = ENU='Lot Tracked',
                        FRA='Lot tracé';
            Description = 'DITW15.00.00.22 PRODW14.00.00.08';
            Editable = false;
        }
        field(2035262;"Manual Insert";Boolean)
        {
            CaptionML = ENU='Manual Insert',
                        FRA='Insertion manuelle';
            Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        }
        field(2035263;"Special Component";Boolean)
        {
            CaptionML = ENU='Special Component',
                        FRA='Composant spécial';
            Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        }
        field(2035266;"Production jnl. flushing";Boolean)
        {
            Caption = 'Production jnl. flushing';
            Description = 'DITW110.00.12A HBA 07/06/2018 NRQ#51782';
        }
        field(2036313;Critical;Boolean)
        {
            CaptionML = ENU='Critical',
                        FRA='Critique';
            Description = 'MANXL7.00.001';
        }
        field(2036314;"Revision No.";Code[10])
        {
            CaptionML = ENU='Revision No.',
                        FRA='N° révision';
            Description = 'MANXL7.00.001 - DITW18.00.06 MSF 15/05/2015 DIT-770 #1168';
            Editable = false;
            TableRelation = "Item Minor Revision"."Revision No." WHERE ("Item No."=FIELD("Item No."));
        }
        */ //BC Upgrade YADAVM09 Drink it code commented<<
    }
    /* //BC Upgrade YADAVM09 'Critical' Drink it field code>>
    keys
    {      
        key(Key1; Status, "Prod. Order No.", Critical)
        {
        }    
    }
     */ //BC Upgrade YADAVM09 'Critical' Drink it field code<<


    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger (Variable: CompTrackingEntry)();
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
    if Status = Status::Finished then
      ERROR(Text000);
    if Status = Status::Released then begin
    #4..40
    ItemTrackingMgt.DeleteWhseItemTrkgLines(
      DATABASE::"Prod. Order Component",Status,"Prod. Order No.",'',
      "Prod. Order Line No.","Line No.","Location Code",true);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..43

    // <<DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008
    // <<DITW15.00.00.25.01-PRODW14.00.00.08.05A DLE 21/01/2009
    if CompTrackingEntry.READPERMISSION then
      CompTrackingMgt.DeleteCompTrackingEntries(Rec);
    // >>DITW15.00.00.22 PRODW14.00.00.08 DDR
    */
    //end;

    //PATHAA02 14.04.26 [PID754,FDD-DTW-002,IBM GAP DTW 36]>>
    trigger OnAfterInsert()
    var
        Rec_prodbomline: Record "Production BOM Line";
        Rec_Prodbomversion: Record "Production BOM Version";
        RecProductionorder: Record "Production Order";
    begin
        RecProductionorder.SetRange("No.", "Prod. Order No.");
        IF RecProductionorder.FindFirst() then begin
            Rec_prodbomline.Reset();
            Rec_prodbomline.SetRange("Production BOM No.", RecProductionorder."Prod. BOM No. 112FDW");
            Rec_prodbomline.SetRange("Version Code", RecProductionorder."Prod. BOM Vrsn Code 112FDW");
            Rec_prodbomline.SetRange(Type, Rec_prodbomline.Type::Item);
            Rec_prodbomline.SetRange("No.", Rec."Item No.");
            if Rec_prodbomline.FindFirst() then begin
                Rec."Production jnl. flushing FND" := Rec_prodbomline."Production jnl. flushing FND";
                //BC Upgrade Kamnay01 - Bug fix>>
                Rec."Zone Code FND" := Rec_prodbomline."Zone Code FND";
                Rec."Bin Code" := Rec_prodbomline."Bin Code FND";
                //BC Upgrade Kamnay01 - Bug fix<<  
                Rec.Modify(false)
            end;
        end;
    end;
    //PATHAA02 14.04.26 [PID754,FDD-DTW-002,IBM GAP DTW 36]<<

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
    //BCUPGRADE YADAVM09>>
    procedure OpenItemTrackingLines2()//BCUPGRADE YADAVM09 did't find event in base to add customise code so created new function
    var
        ProdOrderCompReserve: Codeunit "Prod. Order Comp.-Reserve";
    begin
        //<<HEI.07
        IF "Location Code" <> '' THEN BEGIN
            IF "Bin Code" = '' THEN
                ERROR(Text002);
        end;
        //>>HEI.07
        ProdOrderCompReserve.CallItemTracking(Rec);
    end;
    //BCUPGRADE YADAVM09<<

    //BCUPGRADE YADAVM09 New function created to handle currfieldno of function Update Bin>>
    procedure GetCurrentFieldno(var LCurrFieldNo: Integer)
    begin
        LCurrFieldNo := CurrFieldNo;
    end;
    //BCUPGRADE YADAVM09<<



    //Unsupported feature: PropertyModification on "Text000(Variable 1028)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=A finished production order component cannot be inserted, modified, or deleted.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=A finished production order component cannot be inserted, modified, or deleted.;FRA=Il est impossible d'insérer, de modifier ou de supprimer un composant O.F. terminé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1015)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=The changed %1 now points to bin %2. Do you want to update the bin on this line?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=The changed %1 now points to bin %2. Do you want to update the bin on this line?;FRA=Le %1 modifié pointe désormais vers l'emplacement %2. Souhaitez-vous mettre à jour l'emplacement sur cette ligne ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text99000000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text99000000 : ENU=You cannot delete item %1 in line %2 because at least one item ledger entry is associated with it.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text99000000 : ENU=You cannot delete item %1 in line %2 because at least one item ledger entry is associated with it.;FRA=Vous ne pouvez pas supprimer l'article %1 dans la ligne %2 car au moins une écriture comptable article y est associée.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text99000001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text99000001 : ENU=You cannot rename a %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text99000001 : ENU=You cannot rename a %1.;FRA=Vous ne pouvez pas renommer l'enregistrement %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text99000002(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text99000002 : ENU=You cannot change flushing method to %1 when there is at least one record in table %2 associated with it.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text99000002 : ENU=You cannot change flushing method to %1 when there is at least one record in table %2 associated with it.;FRA=Vous ne pouvez pas modifier la méthode consommation en %1 si au moins un enregistrement de la table %2 y est associé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text99000003(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text99000003 : ENU=You cannot change %1 when %2 is %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text99000003 : ENU=You cannot change %1 when %2 is %3.;FRA=Vous ne pouvez pas modifier %1 si %2 est %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text99000007(Variable 1029)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text99000007 : ENU=You cannot change flushing method to %1 because a pick has already been created for production order component %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text99000007 : ENU=You cannot change flushing method to %1 because a pick has already been created for production order component %2.;FRA=Vous ne pouvez pas modifier la méthode consommation en %1 car un prélèvement a déjà été créé pour le composant O.F. %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text99000008(Variable 1030)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text99000008 : ENU=You cannot change flushing method to %1 because production order component %2 has already been picked.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text99000008 : ENU=You cannot change flushing method to %1 because production order component %2 has already been picked.;FRA=Vous ne pouvez pas modifier la méthode consommation en %1 car le composant O.F. %2 a déjà été prélevé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text99000009(Variable 1013)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text99000009 : ENU=Automatic reservation is not possible.\Do you want to reserve items manually?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text99000009 : ENU=Automatic reservation is not possible.\Do you want to reserve items manually?;FRA=La réservation automatique n'est pas possible.\Souhaitez-vous réserver les articles manuellement ?;
    //Variable type has not been exported.

    var
        Bin: Record Bin;
        Bin2: Record Bin;
        HeinekenGlobal: Codeunit "Heineken Global";
        //recFinXLSetup: Record "Finance XL Setup";//BCUPGRADE YADAVM09 object not used anywhere in the code
        WHSUTILS: Codeunit "WHS-UTILS";
        ProdOrderComponents: Page "Prod. Order Components";

        // CompTrackingMgt: Codeunit "Component Tracking Management";//BCUPGRADE YADAVM09 object not used anywhere in the code
        blnValidateCrossRef: Boolean;
        DefaultBin: Code[20];
        Text002: Label 'Please select the BIN Code';
        Text99000004: TextConst ENU = 'Change %1 from %2 to %3?', FRA = 'Remplacer %2 par %3 dans le champ %1?';
}

