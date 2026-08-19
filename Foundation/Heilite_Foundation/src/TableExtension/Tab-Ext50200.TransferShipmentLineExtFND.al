tableextension 50200 TransferShipmentLineExtFND extends "Transfer Shipment Line"
{
    // version NAVW110.0.00.16585,DITW110.00.11,HEI.04
    //     HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Fields created: 50000 - To Gate Entry No.
    //                         50001 - From Gate Entry No.
    // HEI.02 CHG0257267 IBM.AB 16.01.2019
    //   # Field length for Prod. BOM Version Code is increased from 10 to 20
    // DITW110.00.12 AKH 30/03/2018 NRQ#16026 Order Shipment Planning: Sync Sales - Transfer
    // HEI.03 FDD-HT1304 IBM NASTAA02 01.07.2020 # IC Transfer Order Automation
    //   # New Field created : 50002 - IC Shipment Adjusted
    // CHG2104608: DITW111.00.13 ISL 18/12/2018 NRQ#96024 Deleted field 2014461 "Prod. BOM Version Code"
    // HEI.04 CHG2161264 DEBUSD01 10.11.2022 Shipment KPI Interface
    //   # 50004 - "Document Sub Type" (flowfield)
    //*****************************************************************************************************
    //BC UPGRADE PATHAA02-20.11.25    
    //"Product Group Code"-Deprecated in BC-commented>>       
    //DIT fields commente;Unused record variables-DIT -commented;DIT keys-commented ;Text constants-DIT commented   
    //HEI.01-Done(Dependency with Gate Entry Header);  HEI.02-Done-DIT field-"Prod. BOM Version Code" added and later deleted;   HEI.03-Done;
    //HEI.04- field 50004-->"Transfer Header"."Document Subtype Code"(Field-2014421) Is DIT, Table relation table(Table-2014472) is DIT-->COMMENTED
    // BC Upgrade SHUKLP03 >> Added document subtype code added and changed field id to 50066.

    fields
    {
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify("Item No.")
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Unit of Measure")
        {
            CaptionML = ENU = 'Unit of Measure', FRA = 'Unité';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Shortcut Dimension 1 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 2 Code', FRA = 'Code raccourci axe 2';
        }
        modify("Gen. Prod. Posting Group")
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group', FRA = 'Groupe compta. produit';
        }
        modify("Inventory Posting Group")
        {
            CaptionML = ENU = 'Inventory Posting Group', FRA = 'Groupe compta. stock';
        }
        modify("Quantity (Base)")
        {
            CaptionML = ENU = 'Quantity (Base)', FRA = 'Quantité (base)';
        }
        modify("Qty. per Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Unit of Measure', FRA = 'Quantité par unité';
        }
        modify("Unit of Measure Code")
        {
            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify("Gross Weight")
        {
            CaptionML = ENU = 'Gross Weight', FRA = 'Poids brut';
        }
        modify("Net Weight")
        {
            CaptionML = ENU = 'Net Weight', FRA = 'Poids net';
        }
        modify("Unit Volume")
        {
            CaptionML = ENU = 'Unit Volume', FRA = 'Volume unitaire';
        }
        modify("Variant Code")
        {
            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify("Units per Parcel")
        {
            CaptionML = ENU = 'Units per Parcel', FRA = 'Conditionnement';
        }
        modify("Description 2")
        {
            CaptionML = ENU = 'Description 2', FRA = 'Désignation 2';
        }
        modify("Transfer Order No.")
        {
            CaptionML = ENU = 'Transfer Order No.', FRA = 'N° ordre transfert';
        }
        modify("Shipment Date")
        {
            CaptionML = ENU = 'Shipment Date', FRA = 'Date d''expédition';
        }
        modify("Shipping Agent Code")
        {
            CaptionML = ENU = 'Shipping Agent Code', FRA = 'Code transporteur';
        }
        modify("Shipping Agent Service Code")
        {
            CaptionML = ENU = 'Shipping Agent Service Code', FRA = 'Code prestation transporteur';
        }
        modify("In-Transit Code")
        {
            CaptionML = ENU = 'In-Transit Code', FRA = 'Code transit';
        }
        modify("Transfer-from Code")
        {
            CaptionML = ENU = 'Transfer-from Code', FRA = 'Code prov. transfert';
        }
        modify("Transfer-to Code")
        {
            CaptionML = ENU = 'Transfer-to Code', FRA = 'Code dest. transfert';
        }
        modify("Item Shpt. Entry No.")
        {
            CaptionML = ENU = 'Item Shpt. Entry No.', FRA = 'N° séquence expéd. article';
        }
        modify("Shipping Time")
        {
            CaptionML = ENU = 'Shipping Time', FRA = 'Délai d''expédition';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Item Category Code")
        {
            CaptionML = ENU = 'Item Category Code', FRA = 'Code catégorie article';
        }
        //BC UPGRADE PATHAA02-Deprecated in BC>>
        // modify("Product Group Code")
        // {
        //     CaptionML = ENU = 'Product Group Code', FRA = 'Code groupe produits';
        // }
        //BC UPGRADE PATHAA02-Deprecated in BC<<
        modify("Transfer-from Bin Code")
        {
            CaptionML = ENU = 'Transfer-from Bin Code', FRA = 'Transf. du code emplacement';
        }
        field(50000; "To Gate Entry No. FND"; Code[20])
        {
            Caption = 'To Gate Entry No.';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = "Gate Entry Header FND";
        }
        field(50001; "From Gate Entry No. FND"; Code[20])
        {
            Caption = 'From Gate Entry No.';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = "Gate Entry Header FND";
        }
        field(50002; "IC Shipment Adjusted FND"; Boolean)
        {
            Caption = 'IC Shipment Adjusted';
            Description = 'HEI.03';
            Editable = false;
        }
        field(50066; "Document Subtype Code FND"; Code[10])
        {
            //BC UPGRADE SHUKLP03 >>
            CalcFormula = Lookup("Transfer Header"."Document Subtype Code FND" where("No." = FIELD("Document No."))); //BC UPGRADE SHUKLP03
            Caption = 'Document Subtype Code';
            Description = 'HEI.04';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Document Subtype Code FND".Code where("Report Selection Type" = CONST(Inventory)); //BC UPGRADE SHUKLP03
            //BC UPGRADE SHUKLP03<<
        }

        //BC UPGRADE PATHAA02-DIT fields>>
        /*
        field(2013612; "Item Charge Quantity per"; Decimal)
        {
            CaptionML = ENU = 'Item Charge Quantity per',
                        FRA = 'Quantité frais annexes par';
            DecimalPlaces = 0 : 5;
            Description = 'DITW15.00.00.38 #703';
            MinValue = 0;
        }
        field(2013637; "Deposit Value"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Deposit Value';
            Description = 'DITW110.00.11 BL#14417';
        }
        field(2013660; "Extra Charge Type"; Option)
        {
            CaptionML = ENU = 'Extra Charge Type',
                        FRA = 'Type frais extra';
            Description = 'DITW15.00.00.37';
            OptionCaptionML = ENU = ' ,Amount,Price %,Amount %,Fixed Amount,Volume /Unit,Weight,Cubage,Distance,Sales Price',
                              FRA = ' ,Montant,Prix %,Montant %,Montant Fixe,Volume /Unit,Poids,Cubage,Distance,Prix vente';
            OptionMembers = " ",Amount,"Price %","Amount %","Fixed Amount",VolumeHL,Weight,Cubage,Distance,"Price Item";
        }
        field(2013661; "Item Charge Value"; Decimal)
        {
            AutoFormatExpression = GetAutoformatRoundingType('');
            AutoFormatType = 2;
            CaptionML = ENU = 'Item Charge Value',
                        FRA = 'Valeur frais annexes';
            Description = 'DITW15.00.00.37';
        }
        field(2013662; "Is Item Charge"; Boolean)
        {
            CaptionML = ENU = 'Is Item Charge',
                        FRA = 'Est frais annexes';
            Description = 'DITW15.00.00.37';
        }
        field(2013663; "ItemCharge Incl. Price"; Boolean)
        {
            CaptionML = ENU = 'Item Charge Incl. Price',
                        FRA = 'Frais annexe inclus prix';
            Description = 'DITW15.00.00.37';
        }
        field(2013664; "Item Charge Discount %"; Decimal)
        {
            CaptionML = ENU = 'Item Charge Discount %',
                        FRA = 'Remise frais annexes %';
            Description = 'DITW15.00.00.37';
        }
        field(2013665; "Allow Item Charge Line Disc."; Boolean)
        {
            CaptionML = ENU = 'Allow Item Charge Line Discount',
                        FRA = 'Frais annexes remise ligne autorisé';
            Description = 'DITW15.00.00.37';
            InitValue = true;
        }
        field(2013667; "Item DTax Group Code"; Code[10])
        {
            CaptionML = ENU = 'Item Tax Group Code',
                        FRA = 'Code groupe taxe article';
            Description = 'DITW15.00.00.37';
            TableRelation = "Drink Tax Group".Code where("Source Type" = CONST(Item));
        }
        field(2013694; "Opposite Amount Sign"; Boolean)
        {
            CaptionML = ENU = 'Opposite Amount Sign',
                        FRA = 'Signe opposé montant';
            Description = 'DITW15.00.00.37';
        }
        field(2013695; "Item Charge Type"; Option)
        {
            CaptionML = ENU = 'Item Charge Type',
                        FRA = 'Type frais annexes';
            Description = 'DITW15.00.00.37';
            OptionCaptionML = ENU = ' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
                              FRA = ' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
            OptionMembers = " ",Tax,Deposit,Discount,Promotion,,"Shipping Cost";
        }
        field(2013696; "Transf.-from Location Gr. Code"; Code[10])
        {
            CaptionML = ENU = 'Transfer-from Location Tax Group Code',
                        FRA = 'Transfer du Code groupe magasin taxe';
            Description = 'DITW15.00.00.37';
            TableRelation = "Location Group";
        }
        field(2013708; "Due Tax"; Boolean)
        {
            CaptionML = ENU = 'Due Tax',
                        FRA = 'Taxe due';
            Description = 'DITW15.00.00.37';
        }
        field(2013715; "Tax Formula"; Code[80])
        {
            CaptionML = ENU = 'Tax Formula',
                        FRA = 'Formule taxe';
            Description = 'DITW15.00.00.37';
        }
        field(2013716; "Strength Spec. Code"; Code[20])
        {
            CaptionClass = GetTaxSpecCaption(0, FIELDNO("Strength Spec. Code"));
            CaptionML = ENU = 'Strength Spec. Code',
                        FRA = 'Code contrainte spécification taxe';
            Description = 'DITW19.00.08 BL#10443';
            TableRelation = "Tax Specification" where(Type = CONST(Specification));
        }
        field(2013718; "Vol-Strength Spec. Code"; Code[20])
        {
            CaptionClass = GetTaxSpecCaption(0, FIELDNO("Vol-Strength Spec. Code"));
            CaptionML = ENU = 'Vol-Strength Spec. Code',
                        FRA = 'Code spécification contrainte volume';
            Description = 'DITW19.00.08 BL#10443';
            TableRelation = "Tax Specification" where(Type = CONST(Specification));
        }
        field(2013722; "Duty Suspended"; Boolean)
        {
            CaptionML = ENU = 'Duty Suspended',
                        FRA = 'Taxe en suspension';
            Description = 'DITW15.00.00.37';
        }
        field(2013726; "Company Tax Registration No."; Text[20])
        {
            CaptionML = ENU = 'Company Tax Registration No.',
                        FRA = 'N° identif. accise société';
            Description = 'DITW15.00.00.36';
        }
        field(2013727; "AAD No. Series - Shipment"; Code[10])
        {
            CaptionML = ENU = 'AAD No. Series - Shipment',
                        FRA = 'Souches de n° DAA - Expédition';
            Description = 'DITW15.00.00.36';
            TableRelation = "No. Series";

            trigger OnLookup();
            var
                lrTempTransLine: Record "Transfer Line" temporary;
                lDefaultAADCode: Code[10];
            begin
            end;
        }
        field(2013728; "AAD No. - Shipment"; Code[20])
        {
            CaptionML = ENU = 'AAD No. - Shipment',
                        FRA = 'N° DAA - Expédition';
            Description = 'DITW15.00.00.36';

            trigger OnValidate();
            begin
                // <<DITW15.00.00.39 DDR 11/07/2011 #1369
                if CurrFieldNo = FIELDNO("AAD No. - Shipment") then
                    TESTFIELD("Applies-to AAD Trck. Entry No.", 0);
                // >>DITW15.00.00.39 DDR #1369
            end;
        }
        field(2013729; "Tariff No."; Code[10])
        {
            CaptionML = ENU = 'Tariff No.',
                        FRA = 'Nomenclature produits';
            Description = 'DITW15.00.00.36';
            TableRelation = "Tariff Number";
        }
        field(2013731; "Applies-to AAD Trck. Entry No."; Integer)
        {
            CaptionML = ENU = 'Applies-to Correction AAD Trck. Entry No.',
                        FRA = 'N° Ecriture correction suivi DAA lettrage';
            Description = 'DITW15.00.00.39 #1369';
            TableRelation = "AAD Tracking Entry"."Entry No." where("Entry Type" = CONST(Outbound),
                                                                    "Source Type" = CONST(Location),
                                                                    "Source No." = FIELD("Transfer-to Code"));

            trigger OnValidate();
            var
                AADTrackingEntry: Record "AAD Tracking Entry";
            begin
                TESTFIELD("Item No.");
                if "Applies-to AAD Trck. Entry No." <> 0 then begin
                    TESTFIELD("LRN No. - Shipment");
                    AADTrackingEntry.GET("Applies-to AAD Trck. Entry No.");
                    VALIDATE("AAD No. - Shipment", AADTrackingEntry."AAD No.");
                    VALIDATE("ARC No. - Shipment", AADTrackingEntry."ARC No.");
                end;
            end;
        }
        field(2013758; "Transf.-to Location Gr. Code"; Code[10])
        {
            CaptionML = ENU = 'Transfer-to Location Tax Group Code',
                        FRA = 'Transfer vers code groupe magasin taxe';
            Description = 'DITW15.00.00.37';
            TableRelation = "Location Group";
        }
        field(2013759; "Calculate Tax on Location"; Option)
        {
            CaptionML = ENU = 'Calculate Tax on Location',
                        FRA = 'Calculer taxe sur magasin';
            Description = 'DITW15.00.00.37';
            OptionCaptionML = ENU = ' ,From,To,Both',
                              FRA = ' ,De,Vers,Les deux';
            OptionMembers = " ",From,"To",Both;
        }
        field(2013767; "Unit Volume HL"; Decimal)
        {
            CaptionClass = GetUomCaptionClass(FIELDNO("Unit Volume HL"));
            CaptionML = ENU = 'Unit Volume',
                        FRA = 'Volume unitaire';
            DecimalPlaces = 0 : 5;
            Description = 'DITW15.00.00.36';
            MinValue = 0;
        }
        field(2013768; "Trsf-to Unit Volume HL"; Decimal)
        {
            CaptionClass = GetUomCaptionClass(FIELDNO("Trsf-to Unit Volume HL"));
            CaptionML = ENU = 'Trsf-to Unit Volume',
                        FRA = 'Transfer-vers Volume unitaire';
            DecimalPlaces = 0 : 5;
            Description = 'DITW18.00.06 DIT-770 #1395';
            MinValue = 0;
        }
        field(2013798; "Item Charge No."; Code[20])
        {
            CaptionML = ENU = 'Item Charge No.',
                        FRA = 'N° frais annexes';
            Description = 'DITW15.00.00.37';
            TableRelation = IF ("Item Charge Type" = CONST(" ")) "Item Charge"
            else IF ("Item Charge Type" = FILTER(<> " ")) "Item Charge" where("Item Charge Type" = FIELD("Item Charge Type"));
        }
        field(2014064; "Shipping Charge Per"; Option)
        {
            CaptionML = ENU = 'Shipping Charge Per',
                        FRA = 'Frais transport par';
            Description = 'DITW15.00.00.37';
            OptionCaptionML = ENU = 'Shipment,Weight,Volume',
                              FRA = 'Expédition,Poids,Volume';
            OptionMembers = Shipment,Weight,Volume;
        }
        field(2014077; "Truck Code"; Code[10])
        {
            CaptionML = ENU = 'Truck Code',
                        FRA = 'Code camion';
            Description = 'DITW15.00.00.25';
            TableRelation = "Whse. Shipping Truck";
        }
        field(2014078; "Driver Code"; Code[10])
        {
            CaptionML = ENU = 'Driver Code',
                        FRA = 'Code chauffeur';
            Description = 'DITW15.00.00.25';
            TableRelation = "Whse. Shipping Driver";
        }
        field(2014079; Cubage; Decimal)
        {
            CaptionML = ENU = 'Volume (Cubage)',
                        FRA = 'Volume (cubage)';
            DecimalPlaces = 0 : 5;
            Description = 'DITW15.00.00.37';
        }
        field(2014080; Weight; Decimal)
        {
            CaptionML = ENU = 'Weight',
                        FRA = 'Poids';
            DecimalPlaces = 0 : 5;
            Description = 'DITW15.00.00.37';
        }
        field(2014081; Route; Code[20])
        {
            Caption = 'Route';
            Description = 'DITW110.00.12 NRQ#16026';
            TableRelation = Route;
        }
        field(2014082; "Route Planning No."; Code[20])
        {
            Caption = 'Route Planning No.';
            Description = 'DITW110.00.12 NRQ#16026';
            TableRelation = "Route Planning Worksheet";
        }
        field(2014083; "Truck Zone"; Option)
        {
            Caption = 'Truck Zone';
            Description = 'DITW110.00.12 NRQ#16026';
            OptionCaption = '" ,Right,Left"';
            OptionMembers = " ",Right,Left;
        }
        field(2014084; "Shipment Status"; Option)
        {
            Caption = 'Shipping Status';
            Description = 'DITW110.00.12 NRQ#16026';
            OptionCaption = 'Open,Picklist Printed,Assigned,Picked,Shipped,Return completed,Invoice';
            OptionMembers = Open,"Picklist Printed",Assigned,Picked,Shipped,"Return completed",Invoice;
        }
        field(2014087; Distance; Decimal)
        {
            CaptionML = ENU = 'Distance',
                        FRA = 'Distance';
            DecimalPlaces = 0 : 5;
            Description = 'DITW15.00.00.37';
            MinValue = 0;
        }
        field(2014094; "Trsf-from Ph. Location Gr Code"; Code[10])
        {
            CaptionML = ENU = 'Transfer-from Physical Location Group Code',
                        FRA = 'Transf. du Code groupe magasin réel';
            Description = 'DITW15.00.00.37';
            TableRelation = "Physical Location Group";
        }
        field(2014101; "Trsf-to Ph. Location Gr Code"; Code[10])
        {
            CaptionML = ENU = 'Transfer-to Physical Location Group Code',
                        FRA = 'Transfer vers code groupe magasin réel';
            Description = 'DITW15.00.00.37';
            TableRelation = "Physical Location Group";
        }
        field(2014112; "Unit Amount"; Decimal)
        {
            AutoFormatExpression = GetAutoformatRoundingType('');
            AutoFormatType = 2;
            CaptionML = ENU = 'Unit Amount',
                        FRA = 'Montant unitaire';
            Description = 'DITW15.00.00.37';
        }
        field(2014113; "Tax Item No."; Code[20])
        {
            CaptionML = ENU = 'Tax Tracking Item No.',
                        FRA = 'N° article traçable Taxe';
            Description = 'DITW15.00.00.38 #703';
            TableRelation = Item;
        }
        field(2014260; "LRN No. Series - Shipment"; Code[10])
        {
            CaptionML = ENU = 'LRN No. Series - Shipment',
                        FRA = 'Souches de n° LRN - Expédition';
            Description = 'DITW15.00.00.38 #1217';
            TableRelation = "No. Series";
        }
        field(2014261; "LRN No. - Shipment"; Code[20])
        {
            CaptionML = ENU = 'LRN No. - Shipment',
                        FRA = 'N° LRN - Expédition';
            Description = 'DITW15.00.00.38 #1217';
        }
        field(2014262; "ARC No. - Shipment"; Code[30])
        {
            CaptionML = ENU = 'ARC No. - Shipment',
                        FRA = 'N° ARC - Expédition';
            Description = 'DITW15.00.00.38 #1217';

            trigger OnValidate();
            begin
                // <<DITW15.00.00.39 DDR 11/07/2011 #1369
                if CurrFieldNo = FIELDNO("ARC No. - Shipment") then
                    TESTFIELD("Applies-to AAD Trck. Entry No.", 0);
                // >>DITW15.00.00.39 DDR #1369
            end;
        }
        field(2014263; "SAD No. - Shipment"; Code[30])
        {
            CaptionML = ENU = 'SAD No. - Shipment',
                        FRA = 'N° SAD - Expédition';
            Description = 'DITW15.00.00.38 #1217';
        }
        field(2014265; "Product Tax Code"; Code[10])
        {
            CaptionML = ENU = 'Tax Product Code',
                        FRA = 'Code Produit taxe';
            Description = 'DITW15.00.00.38 #1217';
            TableRelation = "Tax Product";
        }
        field(2014267; "ARC No. Mandatory - Shipment"; Boolean)
        {
            CaptionML = ENU = 'ARC No. Mandatory - Shipment',
                        FRA = 'N° ARC obligatoire - Expédition';
            Description = 'DITW15.00.00.38 #1217';
        }
        field(2014271; "Company Tax Warehouse Ref."; Text[20])
        {
            CaptionML = ENU = 'Company Tax Warehouse Reference',
                        FRA = 'Entrepôt fiscal de référence société';
            Description = 'DITW15.00.00.38 #1217';
        }
        field(2014287; "Cancellation Reason Type"; Option)
        {
            CaptionML = ENU = 'Cancellation Reason Type',
                        FRA = 'Type motif d''annulation';
            Description = 'DITW15.00.00.38 #1217';
            OptionCaptionML = ENU = ' ,Typing Error,Commercial Transaction Interrupt,Duplicate eAAD,State conflict',
                              FRA = ' ,Erreur de frappe,Interruption transaction commerciale,Double eAAD,Conflit administration';
            OptionMembers = " ",TypingError,TransactInterrupt,DuplicAAD,StateConflict;

            trigger OnValidate();
            var
                EMCS810OutMgt: Codeunit "EMCS EDI-IE810 Outbox";
            begin
                // <<DITW15.00.00.38 DDR 08/10/2010
                TESTFIELD("ARC No. Mandatory - Shipment", true);
                TESTFIELD("ARC No. - Shipment");

                if xRec."Cancellation Reason Type" <> "Cancellation Reason Type" then begin
                    EMCS810OutMgt.TestDocumentOutbox(
                      DATABASE::"Transfer Shipment Line", "Document No.", "ARC No. - Shipment", true);

                    TransferShptLine.RESET;
                    TransferShptLine.SETRANGE("Document No.", "Document No.");
                    TransferShptLine.SETFILTER("Line No.", '<>%1', "Line No.");
                    TransferShptLine.SETRANGE("ARC No. - Shipment", "ARC No. - Shipment");
                    // <<DITW18.00.06 DDR 15/04/2015 DIT-770 #1329
                    if not TransferShptLine.ISEMPTY then
                        // >>DITW18.00.06 DDR DIT-770 #1329
                        TransferShptLine.MODIFYALL("Cancellation Reason Type", "Cancellation Reason Type");
                end;
            end;
        }
        field(2014292; "Cancellation Reason Comment"; Boolean)
        {
            CalcFormula = Exist("EMCS Comment Line" where("Table ID" = CONST(5745),
                                                           "Document Type" = CONST(0),
                                                           "Document No." = FIELD("Document No."),
                                                           "Document Line No." = FIELD("Line No."),
                                                           "Field ID" = CONST(2014287)));
            CaptionML = ENU = 'Cancellation Reason Comment',
                        FRA = 'Commentaire motif d''annulation';
            Description = 'DITW16.00.00.40 DIT715 #187';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014410; Collapse; Boolean)
        {
            CaptionML = ENU = 'Collapse',
                        FRA = 'Réduire';
            Description = 'DITW15.00.00.37';
        }
        field(2014434; "Line Amount"; Decimal)
        {
            AutoFormatExpression = GetAutoformatRoundingType('');
            AutoFormatType = 1;
            CaptionML = ENU = 'Line Amount',
                        FRA = 'Montant ligne';
            Description = 'DITW15.00.00.38 #1171';
        }
        field(2014440; "Attached to Line No."; Integer)
        {
            CaptionML = ENU = 'Attached to Line No.',
                        FRA = 'Attaché à la ligne n°';
            Description = 'DITW15.00.00.37';
            Editable = false;
            TableRelation = "Transfer Line"."Line No." where("Document No." = FIELD("Document No."),
                                                              "Line No." = FIELD("Attached to Line No."),
                                                              "Attached to Line No." = CONST(0));
        }
        field(2014460; "Production BOM No."; Code[20])
        {
            CaptionML = ENU = 'Production BOM No.',
                        FRA = 'N° nomenclature production';
            Description = 'DITW18.00.06 DIT-770 #1449';
            TableRelation = "Production BOM Header";
        }
        field(2014462; "BOM Line No."; Integer)
        {
            CaptionML = ENU = 'BOM Line No.',
                        FRA = 'N° ligne nomenclature';
            Description = 'DITW18.00.06 DIT-770 #1449';
            NotBlank = true;
            TableRelation = IF ("Production BOM No." = FILTER(<> '')) "Production BOM Line"."Line No." where("Production BOM No." = FIELD("Production BOM No."))
            else IF ("Production BOM No." = CONST('')) "BOM Component"."Line No." where("Parent Item No." = FIELD("BOM Item No."));
        }
        field(2014463; "BOM Item No."; Code[20])
        {
            CaptionML = ENU = 'BOM Item No.',
                        FRA = 'N° article nomenclature';
            Description = 'DITW18.00.06 DIT-770 #1449';
            TableRelation = Item;
        }
        field(2014464; "BOM Qty. per Unit of Measure"; Decimal)
        {
            CaptionML = ENU = 'BOM Qty. per Unit of Measure',
                        FRA = 'Quantité par unité nomenclature';
            DecimalPlaces = 0 : 5;
            Description = 'DITW18.00.06 DIT-770 #1449';
        }
        field(2014476; "Packaging Type Code"; Code[10])
        {
            CaptionML = ENU = 'Packaging Type Code',
                        FRA = 'Code Type de Conditionnement';
            Description = 'DITW15.00.00.38 #1217';
            TableRelation = "Packaging Type";

            trigger OnValidate();
            begin
                // <<DITW15.00.00.38 DDR 16/09/2010 #1217
                // <<DITW18.00.06 DDR 20/10/2015 DIT-770 #1449
                if (CurrFieldNo = FIELDNO("Packaging Type Code")) and ("Tax Item No." <> '') and
                  ("Packaging Type Code" <> '') and (xRec."Packaging Type Code" <> "Packaging Type Code")
                then
                    TESTFIELD("Packaging Type Code", xRec."Packaging Type Code");
                // >>DITW18.00.06 DDR DIT-770 #1449

                if "Packaging Type Code" <> '' then begin
                    PackagingType.GET("Packaging Type Code");
                    if PackagingType.Countable then begin
                        // <<DITW15.00.00.38 DDR 22/02/2010 #1217 (DIT711 151)
                        // <<DITW15.00.00.38 DDR 11/03/2011 #703
                        if "Tax Item No." <> '' then begin
                            Item.GET("Tax Item No.");
                            ItemUnitOfMeasure.GET("Tax Item No.", Item."Sales Unit of Measure");
                        end else
                            if "Attached to Line No." <> 0 then begin
                                TransferShptLine.GET("Document No.", "Attached to Line No.");
                                ItemUnitOfMeasure.GET(TransferShptLine."Item No.", TransferShptLine."Unit of Measure Code");
                            end else
                                // >>DITW15.00.00.38 DDR #703
                                ItemUnitOfMeasure.GET("Item No.", "Unit of Measure Code");

                        if "Packaging Type Code" = ItemUnitOfMeasure."Packaging Type Code" then begin
                            ItemUnitOfMeasure.TESTFIELD("Pack Qty. per Unit of Measure");
                            "Pack Qty. per Unit of Measure" := ItemUnitOfMeasure."Pack Qty. per Unit of Measure";
                        end else
                            "Pack Qty. per Unit of Measure" := 1;
                        // >>DITW15.00.00.38 DDR #1217 (DIT711 151)
                        // <<DITW15.00.00.38 DDR 31/01/2011 #1217 (DIT711 140) - 16/02/2011 (DIT711 148)
                        TESTFIELD("Pack Qty. per Unit of Measure");
                        "No. of Packages" := ROUND(Quantity * "Pack Qty. per Unit of Measure", 1)
                        // >>DITW15.00.00.38 DDR #1217 (DIT711 140) (DIT711 148)
                    end else
                        "No. of Packages" := 0;
                end else
                    // <<DITW15.00.00.38 DDR 22/02/2010 #1217 (DIT711 151)
                    "No. of Packages" := 0;
                // >>DITW15.00.00.38 DDR #1217 (DIT711 151)

                // >>DITW15.00.00.38 DDR #1217
            end;
        }
        field(2014477; "No. of Packages"; Decimal)
        {
            CaptionML = ENU = 'No. of Packages',
                        FRA = 'Nbre de colis';
            DecimalPlaces = 0 : 2;
            Description = 'DITW15.00.00.38 #1217';

            trigger OnValidate();
            begin
                // <<DITW15.00.00.38 DDR 16/09/2010 #1223
                TESTFIELD(Quantity);
                // <<DITW18.00.06 DDR 20/10/2015 DIT-770 #1449
                if ("Tax Item No." <> '') and (xRec."No. of Packages" <> "No. of Packages") then
                    TESTFIELD("No. of Packages", xRec."No. of Packages");
                // >>DITW18.00.06 DDR DIT-770 #1449
            end;
        }
        field(2014478; "Commercial Seal ID"; Text[35])
        {
            CaptionML = ENU = 'Commercial Seal ID',
                        FRA = 'ID sceau commerciale';
            Description = 'DITW15.00.00.38 #1217';

            trigger OnValidate();
            begin
                // <<DITW15.00.00.38 DDR 16/09/2010 #1223
                TESTFIELD(Quantity);
            end;
        }
        field(2014482; "Pack Qty. per Unit of Measure"; Decimal)
        {
            CaptionML = ENU = 'Packaging Qty. per Unit of Measure',
                        FRA = 'Quantité conditionnement par unité';
            DecimalPlaces = 0 : 5;
            Description = 'DITW15.00.00.38 #1217 (DIT711 148)';
        }
        field(2014500; "Has Item Charge"; Boolean)
        {
            CalcFormula = Exist("Transfer Shipment Line" where("Document No." = FIELD("Document No."),
                                                                "Attached to Line No." = FIELD("Line No.")));
            CaptionML = ENU = 'Has Item Charge',
                        FRA = 'A des Frais Annexes';
            Description = 'DITW17.10.03 DIT-770 #541';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2035391; "External Document No."; Code[35])
        {
            CalcFormula = Lookup("Transfer Shipment Header"."External Document No." where("No." = FIELD("Document No.")));
            CaptionML = ENU = 'External Document No.',
                        FRA = 'N° document externe';
            Description = 'DITW17.00.02 DIT-770 #180';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2035392; "Posting Date"; Date)
        {
            CalcFormula = Lookup("Transfer Shipment Header"."Posting Date" where("No." = FIELD("Document No.")));
            CaptionML = ENU = 'Posting Date',
                        FRA = 'Date comptabilisation';
            Description = 'DITW17.00.02 DIT-770 #180';
            FieldClass = FlowField;
        }
        */
        //BC UPGRADE PATHAA02-DIT fields<<
    }
    keys
    {
        // //BC UPGRADE PATHAA02-DIT fields>>
        // key(Key1; "Document No.", "AAD No. Series - Shipment", "Company Tax Registration No.", "Tariff No.", "Item No.")
        // {
        // }
        // key(Key2; "Document No.", "LRN No. Series - Shipment", "Company Tax Registration No.", "Company Tax Warehouse Ref.", "Tariff No.", "Item No.")
        // {
        // }
        // key(Key3; "Document No.", "Attached to Line No.", Collapse, "Is Item Charge", "ItemCharge Incl. Price", "Extra Charge Type")
        // {
        // }
        // key(Key4; "Document No.", "Attached to Line No.", "Is Item Charge")
        // {
        // }
        // key(Key5; "ARC No. - Shipment", "Company Tax Registration No.", "Company Tax Warehouse Ref.", "Tariff No.", "Item No.")
        // {
        // }
        // key(Key6; "Applies-to AAD Trck. Entry No.")
        // {
        // }
        //BC UPGRADE PATHAA02-DIT fields<<
    }


    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    var
    //EmcsCommentLine: Record "EMCS Comment Line"; //BC UPGRADE PATHAA02-DIT(T2014265)-not used
    //begin
    /*
    // <<DITW16.00.00.40 DDR 22/12/2011 DIT-715 #187
    EmcsCommentLine.SETRANGE("Table ID",DATABASE::"Transfer Shipment Line");
    EmcsCommentLine.SETRANGE("Document Type",0);
    EmcsCommentLine.SETRANGE("Document No.","Document No.");
    EmcsCommentLine.SETRANGE("Document Line No.","Line No.");
    EmcsCommentLine.DELETEALL;
    // >>DITW16.00.00.40 DDR DIT-715 #187
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        GLSetup: Record "General Ledger Setup";

    var
        Item: Record Item;
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        //EmcsSetup: Record "EMCS Setup"; //BC UPGRADE PATHAA02-T2014260-DIT
        //PackagingType: Record "Packaging Type";//BC UPGRADE PATHAA02-T2014424-DIT
        TransferShptHeader: Record "Transfer Shipment Header";
        TransferShptLine: Record "Transfer Shipment Line";
    //Text2014265: Label 'If you change %1, that may affect one or more lines and you must update the existing lines manually.\\Do you want to change %1?';//BC UPGRADE PATHAA02-DIT
}

