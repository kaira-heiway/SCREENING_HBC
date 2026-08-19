tableextension 50176 TrackingSpecificationExtFND extends "Tracking Specification"
{
    //     DITW15.00.00.38 DDR 25/10/2010 issue 1139 SSCC Functionnalities
    //                                  Added field "Quantity (Base)","Qty. to Handle","Qty. to Invoice" in SumIndexFields key2
    // DITW16.00.00.40 DDR 03/02/2012 #1331 (HIT0069.1 VVE 19/04/2011) FEFO tracking
    //                                  Added key "Location Code,Bin Code" + Sumindexfield "Quantity (Base)"
    //                     01/03/2012 DIT-715 #253 Bugfix function CreateLotNoInformation(),CreateSerialNoInformation() to validate fields

    // FINXL7.00.001 RBE 20/03/2013: Item description extend from 30 -> 80 chars

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.03 MSF 28/05/2014 DIT-770 #715 Upgrade W1 Rollup 6 ChangeLog.W1.36366 file 474255
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.07 VSC 13/01/2016 DIT-770 #1825 Fill the expiration date
    // DITW19.00.08 DDR 29/09/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                      Added fields
    //                                                        2013716 Strength Spec. Code
    //                                                        2013717 Strength Spec. Value
    //                                                        2013720 New Strength Spec. Value
    //                                                        2014410 Buffer Status Dit1
    //                                                      Added functions InitStrengthValues
    // DITW19.00.08 DDR 17/10/2016 BL#10443 Modified function GetTaxSpecCaption()
    // DITW19.00.08 DDR 20/10/2016 BL#10443 Bugfix function GetTaxSpecCaption()
    //                                      Modified functions InitStrengthValues(),CalcVolumeStrength(),UpdateVsOnQtyBase(),UpdateVsOnQtyHandle()
    //                                      Added fields
    //                                        2013718 "Vol-Strength Spec. Code"
    //                                        2013719 "Vol-Strength Spec. Value"
    //                                        2013721 "New Vol-Strength Spec. Value"
    // DITW19.00.08 DDR 27/10/2016 BL#10443 Bugfix function InitStrengthValues

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // DITW110.00.09 AKH 29/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // DITW110.00.09 VSC 11/04/2017 NRQ#18376 Bugfix. Use Record Assignment Like ItemJnlLine. or PurchLine., etc
    // DITW110.00.11 VSC 26/09/2017 NRQ#30577 Merge - QXL10.01 VSC 26/09/2017 NRQ#38341 : Multisite – Quality tracking per Location
    // DITW110.00.11 VSC 28/09/2017 NRQ#30577 Merge - QXL10.01 VSC 27/09/2017 NRQ#38351 : XL It should not be possible to select a blocked lot no on outbound
    // QXL11.01 MTR 13/09/2018 NRQ#24975 : Created function ModifyQualityTest()
    // DITW111.00.13 MSF 09/11/2018 NRQ#91858 Auto suggest FEFO does not work anymore for location with warehouse shipment
    // DITW111.00.13A MSF 06/05/2019 NRQ#106834 AUTO FEFO and Undo Tracking Lines functions for transfer orders
    // HEI.01 CHG2012342 IBM GAVANM01 15/11/2019   # code added in fct CreateLotNoInformation, reason is: “Your Reference” info somehow is not copied/used in “Item Ledger Entries” (list of transactions/entries).
    // HEI.02 IBM MATHEJ01 08.01.2020 - #CHG2037233: Corrections for Expiry Date Generation Functionality
    //   # New Function: CalcExpiryDate
    //   # Modified Function: Lot No. - OnValidate(),CreateLotNoInformation
    // HEI.03 CHG2100218 IBM SAXENA03 25.03.2021
    //   # Replaced FINDSET with FINDSET(false,false) of function GetUndefinedLots(()
    // HEI.04 CHG2119178 IBM.AS 30.06.2021
    //   # HeiLite Base Stability Changes for Posting functions at JOB NAS
    //   # Adding GUIAllowed function added in Functions Expiration Date - OnValidate(),
    //   Strength Spec. Value - OnValidate, Vol-Strength Spec. Value - OnValidate()
    // HEI.05 CHG2075364 IBM.LS      20.07.2021
    //   # Created New Field: 50000 - Zone Code
    //   # Added Code
    // HEI.06 CHG2119481 IBM.LS      10.12.2021
    //   # Created New Fields: 50001 - KG/HL
    //                         50002 - Weight of Extract
    //   # Modified Fields (KG/HL and Weight of Extract) Editable property as No
    // HEI.07 CHG2119481 IBM.LS      21.01.2022
    //   # Created New Field: 50003 - Reference No.
    //   # Added Code for Reference No.
    // NRQ212654 EZOG 22/03/2022 Fix Lot Blocked   

    //-------------------------------------------------------------------------------------------------------------
    //BC Upgrade KAPOOV01 13-11-2025 # Changed Key name from Key1 to Key50000.
    //BC Upgrade KAPOOV01 13-11-2025 # GetUndefinedLots FUNCTION is Obsolete in BC cannot take HEI.03 After discussion with Saikat, Saikat confirmed to skip this customization as it is a small customization.
    //BC Upgrade KAPOOV01 13-11-2025 # For HEI.07 Event subscribed-OnAfterInitFromItemJnlLine in HeinekenBCUpgrade codeunit.
    //BC Upgrade KAPOOV01 13-11-2025 # For HEI.04 Event subscribed-OnValidateExpirationDateOnBeforeResetExpirationDate in HeinekenBCUpgrade codeunit.

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
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Creation Date")
        {
            CaptionML = ENU = 'Creation Date', FRA = 'Date création';
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
        modify("Transfer Item Entry No.")
        {
            CaptionML = ENU = 'Transfer Item Entry No.', FRA = 'N° écriture article transfert';
        }
        modify("Serial No.")
        {
            CaptionML = ENU = 'Serial No.', FRA = 'N° de série';
        }
        modify(Positive)
        {
            CaptionML = ENU = 'Positive', FRA = 'Positif';
        }
        modify("Qty. per Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Unit of Measure', FRA = 'Quantité par unité';
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
        modify("Quantity Handled (Base)")
        {
            CaptionML = ENU = 'Quantity Handled (Base)', FRA = 'Quantité traitée (base)';
        }
        modify("Quantity Invoiced (Base)")
        {
            CaptionML = ENU = 'Quantity Invoiced (Base)', FRA = 'Quantité facturée (base)';
        }
        modify("Qty. to Handle")
        {
            CaptionML = ENU = 'Qty. to Handle', FRA = 'Quantité à traiter';
        }
        modify("Qty. to Invoice")
        {
            CaptionML = ENU = 'Qty. to Invoice', FRA = 'Qté à facturer';
        }
        modify("Buffer Status")
        {
            CaptionML = ENU = 'Buffer Status', FRA = 'Statut tampon';
            OptionCaptionML = ENU = ' ,MODIFY,INSERT', FRA = ' ,MODIFIER,INSÉRER';
        }
        modify("Buffer Status2")
        {
            CaptionML = ENU = 'Buffer Status2', FRA = 'Statut2 tampon';
            OptionCaptionML = ENU = ',ExpDate blocked', FRA = ',Date exp. bloquée';
        }
        modify("Buffer Value1")
        {
            CaptionML = ENU = 'Buffer Value1', FRA = 'Valeur1 tampon';
        }
        modify("Buffer Value2")
        {
            CaptionML = ENU = 'Buffer Value2', FRA = 'Valeur2 tampon';
        }
        modify("Buffer Value3")
        {
            CaptionML = ENU = 'Buffer Value3', FRA = 'Valeur3 tampon';
        }
        modify("Buffer Value4")
        {
            CaptionML = ENU = 'Buffer Value4', FRA = 'Valeur4 tampon';
        }
        modify("Buffer Value5")
        {
            CaptionML = ENU = 'Buffer Value5', FRA = 'Valeur5 tampon';
        }
        modify("New Serial No.")
        {
            CaptionML = ENU = 'New Serial No.', FRA = 'Nouveau n° de série';
        }
        modify("New Lot No.")
        {
            CaptionML = ENU = 'New Lot No.', FRA = 'Nouveau n° lot';
        }
        modify("Prohibit Cancellation")
        {
            CaptionML = ENU = 'Prohibit Cancellation', FRA = 'Interdire l''annulation';
        }
        modify("Lot No.")
        {
            CaptionML = ENU = 'Lot No.', FRA = 'N° lot';
            //BC Upgrade KAPOOV01>>
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.02>>
                IF "Expiration Date" = 0D THEN
                    IF ("Source Type" = 83) AND ("Source Subtype" = 6) THEN BEGIN
                        ItemJrnlLine.RESET();
                        ItemJrnlLine.SETRANGE(ItemJrnlLine."Journal Template Name", "Source ID");
                        ItemJrnlLine.SETRANGE(ItemJrnlLine."Line No.", "Source Ref. No.");
                        ItemJrnlLine.SETRANGE(ItemJrnlLine."Item No.", "Item No.");
                        ItemJrnlLine.SETRANGE(ItemJrnlLine."Journal Batch Name", "Source Batch Name");
                        ItemJrnlLine.SETRANGE(ItemJrnlLine."Location Code", "Location Code");
                        ItemJrnlLine.SETRANGE(ItemJrnlLine."Entry Type", ItemJrnlLine."Entry Type"::Output);
                        IF ItemJrnlLine.FINDFIRST() THEN
                            "Expiration Date" := CalcExpiryDate(ItemJrnlLine."Posting Date");
                    end;
                //HEI.02<<
            end;
            //BC Upgrade KAPOOV01<<
        }
        modify("Variant Code")
        {
            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify("Bin Code")
        {
            CaptionML = ENU = 'Bin Code', FRA = 'Code emplacement';
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
        modify("Quantity actual Handled (Base)")
        {
            CaptionML = ENU = 'Quantity actual Handled (Base)', FRA = 'Quantité réelle traitée (base)';
        }

        //Unsupported feature: CodeModification on ""Quantity (Base)"(Field 4).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ("Quantity (Base)" * "Quantity Handled (Base)" < 0) or
           (ABS("Quantity (Base)") < ABS("Quantity Handled (Base)"))
        then
        #4..8

        if not QuantityToInvoiceIsSufficient then
          VALIDATE("Appl.-to Item Entry",0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..11

        // <<DITW19.00.08 DDR 20/10/2016 BL#10443
        if "Strength Spec. Code" <> '' then
          UpdateVsOnQtyBase;
        // >>DITW19.00.08 DDR BL#10443
        */
        //end;


        //Unsupported feature: CodeModification on ""Expiration Date"(Field 41).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WMSManagement.CheckItemTrackingChange(Rec,xRec);
        if "Buffer Status2" = "Buffer Status2"::"ExpDate blocked" then begin
          "Expiration Date" := xRec."Expiration Date";
          MESSAGE(Text004);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
          //>>HEI.04
          if GUIALLOWED then
          //<<HEI.04
            MESSAGE(Text004);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Qty. to Handle (Base)"(Field 50).OnValidate". Please convert manually.

        //trigger  to Handle (Base)"(Field 50)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ("Qty. to Handle (Base)" * "Quantity (Base)" < 0) or
           (ABS("Qty. to Handle (Base)") > ABS("Quantity (Base)")
            - "Quantity Handled (Base)")
        #4..8
        InitQtyToInvoice;
        "Qty. to Handle" := CalcQty("Qty. to Handle (Base)");
        CheckSerialNoQty;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..11

        // <<DITW19.00.08 DDR 20/10/2016 BL#10443
        if "Strength Spec. Code" <> '' then
          UpdateVsOnQtyHandle;
        // >>DITW19.00.08 DDR BL#10443
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Lot No."(Field 5400).OnValidate". Please convert manually.

        //trigger (Variable: ItemJrnlLine)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Lot No."(Field 5400).OnValidate". Please convert manually.

        //trigger "(Field 5400)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Lot No." <> xRec."Lot No." then begin
          TESTFIELD("Quantity Handled (Base)",0);
          TESTFIELD("Appl.-from Item Entry",0);
          if IsReclass then
            "New Lot No." := "Lot No.";
          WMSManagement.CheckItemTrackingChange(Rec,xRec);
          InitExpirationDate;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..7
          // <<DITW19.00.08 DDR 29/09/2016 20/10/2016 BL#10443
          if "Strength Spec. Code" <> '' then
            VALIDATE("Strength Spec. Code");
          if "Vol-Strength Spec. Code" <> '' then
            VALIDATE("Vol-Strength Spec. Code");
          // >>DITW19.00.08 DDR BL#10443

        end;
        //<< DITW18.00.07 VSC 13/01/2016 DIT-770 #1825
        if recItem.GET("Item No.") then
          if recItemTracking.GET(recItem."Item Tracking Code") then
            if recItemTracking."Man. Expir. Date Entry Reqd." then
              if FORMAT(recItem."Expiration Calculation") <> '' then begin
                recProdOrder.SETRANGE("No.","Source ID");
                if recProdOrder.FINDFIRST then
                  datCreationDate :=CALCDATE(recItem."Expiration Calculation",recProdOrder."Due Date");
                  "Expiration Date" := datCreationDate;
              end;//HEI.02 (added ;)
        //>> DITW18.00.07 VSC DIT-770 #1825
        //HEI.02>>
        if "Expiration Date" = 0D then
          if ("Source Type" = 83) and ("Source Subtype" = 6) then
            begin
              ItemJrnlLine.RESET;
              ItemJrnlLine.SETRANGE(ItemJrnlLine."Journal Template Name","Source ID");
              ItemJrnlLine.SETRANGE(ItemJrnlLine."Line No.","Source Ref. No.");
              ItemJrnlLine.SETRANGE(ItemJrnlLine."Item No.","Item No.");
              ItemJrnlLine.SETRANGE(ItemJrnlLine."Journal Batch Name","Source Batch Name");
              ItemJrnlLine.SETRANGE(ItemJrnlLine."Location Code","Location Code");
              ItemJrnlLine.SETRANGE(ItemJrnlLine."Entry Type",ItemJrnlLine."Entry Type"::Output);
              if ItemJrnlLine.FINDFIRST then
                "Expiration Date" := CalcExpiryDate(ItemJrnlLine."Posting Date");
            end;
        //HEI.02<<
        */
        //end;
        field(50000; "Zone Code FND"; Code[10])
        {
            Caption = 'Zone Code';
            Description = 'HEI.05';
            TableRelation = Zone.Code where("Location Code" = FIELD("Location Code"));
        }
        field(50001; "KG/HL FND"; Decimal)
        {
            Caption = 'KG/HL';
            Description = 'HEI.06';
            Editable = false;
        }
        field(50002; "Weight of Extract FND"; Decimal)
        {
            Caption = 'Weight of Extract';
            Description = 'HEI.06';
            Editable = false;
        }
        field(50003; "Reference No. FND"; Code[20])
        {
            Caption = 'Reference No.';
            Description = 'HEI.07';
            Editable = false;
        }

        field(54000; "Your Reference FND"; Text[30])
        {
            Caption = 'Your Reference';
            DataClassification = ToBeClassified;
            Editable = true;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ModifyLotNoInformation("Lot No.");
            end;
        }
        //BC Upgrade KAPOOV01 Drink-it Start>>
        // field(2013716; "Strength Spec. Code"; Code[20])
        // {
        //     CaptionClass = GetTaxSpecCaption(0, FIELDNO("Strength Spec. Code"));
        //     CaptionML = ENU = 'Strength Spec. Code',
        //                 FRA = 'Code contrainte spécification taxe';
        //     Description = 'DITW19.00.08 BL#10443';
        //     TableRelation = "Tax Specification" where(Type = CONST(Specification));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 29/09/2016 BL#10443
        //         if ("Strength Spec. Code" <> xRec."Strength Spec. Code") or ("Lot No." <> xRec."Lot No.") then begin
        //             InitStrengthValues;
        //             VALIDATE("Qty. to Handle (Base)");
        //         end;
        //     end;
        // }
        // field(2013717; "Strength Spec. Value"; Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Strength Spec. Value"));
        //     AutoFormatType = 2013664;
        //     CaptionClass = GetTaxSpecCaption(1, FIELDNO("Strength Spec. Value"));
        //     CaptionML = ENU = 'Strength Spec. Value',
        //                 FRA = 'Valeur contrainte spécification';
        //     Description = 'DITW19.00.08 BL#10443';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 29/09/2016 BL#10443
        //         TESTFIELD("Strength Spec. Code");
        //         if ("Buffer Status Dit1" = "Buffer Status Dit1"::"Strength blocked") or not HasTaxSpecEditable("Strength Spec. Code") then begin
        //             "Strength Spec. Value" := xRec."Strength Spec. Value";
        //             //>>HEI.04
        //             if GUIALLOWED then
        //                 //<<HEI.04
        //                 MESSAGE(Text2013660, FIELDCAPTION("Strength Spec. Value"));
        //         end;
        //         if ("Strength Spec. Value" <> xRec."Strength Spec. Value") and (CurrFieldNo = FIELDNO("Strength Spec. Value")) then begin
        //             recItem.GET("Item No.");
        //             recItem.TESTFIELD("Strength Method", recItem."Strength Method"::Variable);
        //         end;

        //         if IsReclass then
        //             "New Strength Spec. Value" := "Strength Spec. Value";
        //     end;
        // }
        // field(2013718; "Vol-Strength Spec. Code"; Code[20])
        // {
        //     CaptionClass = GetTaxSpecCaption(0, FIELDNO("Vol-Strength Spec. Code"));
        //     CaptionML = ENU = 'Vol-Strength Spec. Code',
        //                 FRA = 'Code spécification contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';
        //     TableRelation = "Tax Specification" where(Type = CONST(Specification));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 17/08/2016 BL#10443
        //         if ("Vol-Strength Spec. Code" <> xRec."Vol-Strength Spec. Code") or ("Lot No." <> xRec."Lot No.") then begin
        //             InitStrengthValues;
        //             VALIDATE("Qty. to Handle (Base)");
        //         end;
        //     end;
        // }
        // field(2013719; "Vol-Strength Spec. Value"; Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Vol-Strength Spec. Value"));
        //     AutoFormatType = 2013664;
        //     CaptionClass = GetTaxSpecCaption(1, FIELDNO("Vol-Strength Spec. Value"));
        //     CaptionML = ENU = 'Vol-Strength Spec. Value',
        //                 FRA = 'Valeur spécification contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 17/08/2016 BL#10443
        //         TESTFIELD("Vol-Strength Spec. Code");
        //         if ("Buffer Status Dit1" = "Buffer Status Dit1"::"Strength blocked") or not HasTaxSpecEditable("Vol-Strength Spec. Code") then begin
        //             "Vol-Strength Spec. Value" := xRec."Vol-Strength Spec. Value";
        //             //>>HEI.04
        //             if GUIALLOWED then
        //                 //<<HEI.04
        //                 MESSAGE(Text2013660, FIELDCAPTION("Vol-Strength Spec. Value"));
        //         end;
        //         if ("Vol-Strength Spec. Value" <> xRec."Vol-Strength Spec. Value") and (CurrFieldNo = FIELDNO("Vol-Strength Spec. Value")) then begin
        //             recItem.GET("Item No.");
        //             recItem.TESTFIELD("Strength Method", recItem."Strength Method"::Variable);
        //         end;

        //         if IsReclass then
        //             "New Vol-Strength Spec. Value" := "Vol-Strength Spec. Value";
        //     end;
        // }
        // field(2013720; "New Strength Spec. Value"; Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("New Strength Spec. Value"));
        //     AutoFormatType = 2013664;
        //     CaptionClass = GetTaxSpecCaption(1, FIELDNO("New Strength Spec. Value"));
        //     CaptionML = ENU = 'New Strength Spec. Value',
        //                 FRA = 'Nouvelle valeur spécification contrainte';
        //     Description = 'DITW19.00.08 BL#10443';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 29/09/2016 BL#10443
        //         TESTFIELD("Strength Spec. Code");
        //         if not IsReclass or not HasTaxSpecEditable("Strength Spec. Code") then
        //             FIELDERROR("New Strength Spec. Value");
        //         if ("Strength Spec. Value" <> xRec."Strength Spec. Value") and (CurrFieldNo = FIELDNO("Strength Spec. Value")) then begin
        //             recItem.GET("Item No.");
        //             recItem.TESTFIELD("Strength Method", recItem."Strength Method"::Variable);
        //         end;
        //     end;
        // }
        // field(2013721; "New Vol-Strength Spec. Value"; Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("New Vol-Strength Spec. Value"));
        //     AutoFormatType = 2013664;
        //     CaptionClass = GetTaxSpecCaption(1, FIELDNO("New Vol-Strength Spec. Value"));
        //     CaptionML = ENU = 'New Vol-Strength Spec. Value',
        //                 FRA = 'Nouvelle valeur spécification contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 17/08/2016 29/09/2016 BL#10443
        //         TESTFIELD("Vol-Strength Spec. Code");
        //         if not IsReclass or not HasTaxSpecEditable("Vol-Strength Spec. Code") then
        //             FIELDERROR("New Vol-Strength Spec. Value");
        //         if ("Vol-Strength Spec. Value" <> xRec."Vol-Strength Spec. Value") and (CurrFieldNo = FIELDNO("Vol-Strength Spec. Value")) then begin
        //             recItem.GET("Item No.");
        //             recItem.TESTFIELD("Strength Method", recItem."Strength Method"::Variable);
        //         end
        //     end;
        // }
        // field(2014410; "Buffer Status Dit1"; Option)
        // {
        //     CaptionML = ENU = 'Buffer Status2',
        //                 FRA = 'Statut2 tampon';
        //     Description = 'DITW19.00.08 BL#10443';
        //     Editable = false;
        //     OptionCaptionML = ENU = ',Strength blocked',
        //                       FRA = ',Contrainte bloquée';
        //     OptionMembers = ,"Strength blocked";
        // }
        // field(2035098; "Your Reference"; Text[30])
        // {
        //     CaptionML = ENU = 'Your Reference',
        //                 FRA = 'Votre référence';
        //     Description = 'QXL9.00.001';

        //     trigger OnValidate();
        //     begin
        //         ModifyLotNoInformation("Lot No.");
        //         //<< QXL11.01 MTR 13/09/2018 NRQ#24975
        //         ModifyQualityTest("Lot No.");
        //         //>> QXL11.01 MTR 13/09/2018 NRQ#24975
        //     end;
        // }
        // field(2035099; "Session ID"; Guid)
        // {
        //     CaptionML = ENU = 'Session ID',
        //                 FRA = 'ID session';
        //     Description = 'QXL9.00.001';
        // }
        // field(2035100; "New Location Code"; Code[10])
        // {
        //     CaptionML = ENU = 'New Location Code',
        //                 FRA = 'Nouveau code magasin';
        //     Description = 'QXL9.00.001';
        //     TableRelation = Location;
        // }
        // field(2035101; "New Bin Code"; Code[20])
        // {
        //     CaptionML = ENU = 'New Bin Code',
        //                 FRA = 'Nouveau code emplacement';
        //     Description = 'QXL9.00.001';
        //     TableRelation = Bin.Code where("Location Code" = FIELD("New Location Code"),
        //                                     "Item Filter" = FIELD("Item No."),
        //                                     "Variant Filter" = FIELD("Variant Code"));
        // }
        // field(2035102; Scheduled; Boolean)
        // {
        //     CaptionML = ENU = 'Scheduled',
        //                 FRA = 'Planifié(e)';
        //     Description = 'QXL9.00.001';
        // }
        // field(2035172; "Gyle No."; Code[20])
        // {
        //     CaptionML = ENU = 'Gyle No.',
        //                 FRA = 'Gyle N°';
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        // }
        //BC Upgrade KAPOOV01 Drink-it End<<
    }
    keys
    {

        //Unsupported feature: PropertyChange on ""Source ID","Source Type","Source Subtype","Source Batch Name","Source Prod. Order Line","Source Ref. No."(Key)". Please convert manually.

        key(Key50000; "Location Code", "Bin Code")//BC Upgrade KAPOOV01 Changed Key name from Key1 to Key50000
        {
            SumIndexFields = "Quantity (Base)";
        }
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD("Quantity Handled (Base)",0);
    TESTFIELD("Quantity Invoiced (Base)",0);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TESTFIELD("Quantity Handled (Base)",0);
    TESTFIELD("Quantity Invoiced (Base)",0);


    //<<QXL9.00.001 DAT 23/03/2016
    if ("Lot No." <> '') and not ExistReservLotSerial() then begin
      if LotNoInfo.GET("Item No.","Variant Code","Lot No.") then begin
        LotNoInfo.CALCFIELDS(Inventory);
        if LotNoInfo.Inventory = 0 then
          LotNoInfo.DELETE(true);
      end;
    end;
    if "Serial No." <> '' then begin
      if SerialNoInfo.GET("Item No.","Variant Code","Serial No.") then begin
        SerialNoInfo.CALCFIELDS(Inventory);
        if SerialNoInfo.Inventory = 0 then
          SerialNoInfo.DELETE(true);
      end;
    end;
    if ("New Lot No." <> '') and not ExistReservNewLotSerial() then begin
      if LotNoInfo.GET("Item No.","Variant Code","New Lot No.") then begin
        LotNoInfo.CALCFIELDS(Inventory);
        if LotNoInfo.Inventory = 0 then
          LotNoInfo.DELETE(true);
      end;
    end;
    if "New Serial No." <> '' then begin
      if SerialNoInfo.GET("Item No.","Variant Code","New Serial No.") then begin
        SerialNoInfo.CALCFIELDS(Inventory);
        if SerialNoInfo.Inventory = 0 then
          SerialNoInfo.DELETE(true);
      end;
    end;
    //>>QXL9.00.001 DAT 23/03/2016
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        ItemJrnlLine: Record "Item Journal Line";


    //Unsupported feature: PropertyModification on "Text000(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You cannot invoice more than %1 units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You cannot invoice more than %1 units.;FRA=Vous ne pouvez pas facturer plus de %1 unité(s).;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot handle more than %1 units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot handle more than %1 units.;FRA=Vous ne pouvez pas gérer plus de %1 unité(s).;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=must not be less than %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=must not be less than %1;FRA=ne doit pas être inférieur(e) à %1;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=%1 must be -1, 0 or 1 when %2 is stated.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=%1 must be -1, 0 or 1 when %2 is stated.;FRA=La %1 doit être -1, 0 or 1 lorsqu'un %2 est indiqué.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=Expiration date has been established by existing entries and cannot be changed.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=Expiration date has been established by existing entries and cannot be changed.;FRA=La date d'expiration a été fixée par les écritures existantes et ne peut pas être modifiée.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=%1 in %2 for %3 %4, %5: %6, %7: %8 is currently %9. It must be %10.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=%1 in %2 for %3 %4, %5: %6, %7: %8 is currently %9. It must be %10.;FRA=%1 dans %2 pour le %3 %4, le %5 %6, le %7 %8, est actuellement %9. Ce doit être %10.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "RemainingQtyErr(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //RemainingQtyErr : ENU=The %1 in item ledger entry %2 is too low to cover %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //RemainingQtyErr : ENU=The %1 in item ledger entry %2 is too low to cover %3.;FRA=Le %1 dans l'écriture comptable article %2 est trop faible pour couvrir %3.;
    //Variable type has not been exported.
    //BC Upgrade KAPOOV01 Start
    procedure CalcExpiryDate(PostDate: Date): Date
    var

    begin
        //HEI.02>>
        IF recItem.GET("Item No.") THEN
            IF FORMAT(recItem."Expiration Calculation") <> '' THEN
                EXIT(CALCDATE(recItem."Expiration Calculation", PostDate));
        EXIT(0D);
        //HEI.02<<
    end;

    procedure InitFromWhseActivityLine(WhseActivityLine: Record "Warehouse Activity Line")
    var
        ItemL: Record Item;
    begin
        //HEI.05>>
        ItemL.GET(WhseActivityLine."Item No.");
        SetItemData(
          WhseActivityLine."Item No.", WhseActivityLine.Description, WhseActivityLine."Location Code",
          WhseActivityLine."Variant Code", WhseActivityLine."Bin Code", WhseActivityLine."Qty. per Unit of Measure");
        SetSourceFromWhseActivityLine(WhseActivityLine);
        //SetStrengthCodes(ItemL."Strength Spec. Code", ItemL."Vol-Strength Spec. Code");//BC Upgrade KAPOOV01 Drink-it
        SetQuantities(
          WhseActivityLine."Qty. (Base)", WhseActivityLine."Qty. to Handle", WhseActivityLine."Qty. to Handle (Base)",
          WhseActivityLine."Qty. to Handle", WhseActivityLine."Qty. to Handle (Base)", WhseActivityLine."Qty. Handled (Base)",
          WhseActivityLine."Qty. Handled (Base)");
        //HEI.05<<
    end;

    procedure SetSourceFromWhseActivityLine(WhseActivityLine: Record "Warehouse Activity Line")
    var
        myInt: Integer;
    begin
        //HEI.05>>
        "Source Type" := DATABASE::"Warehouse Activity Line";
        "Source Subtype" := WhseActivityLine."Activity Type".AsInteger();
        "Source ID" := WhseActivityLine."No.";
        "Source Ref. No." := WhseActivityLine."Line No.";
        "Source Batch Name" := FORMAT(WhseActivityLine."Action Type");
        "Source Prod. Order Line" := WhseActivityLine."Linked To Line No. FND";
        "Zone Code FND" := WhseActivityLine."Zone Code";
        //"Your Reference" := FORMAT(WhseActivityLine."Shipping Advice");//BC Upgrade KAPOOV01 Drink-it
        //HEI.05<<
    end;

    procedure SetRefNo(RefNo: Code[20])
    var
        myInt: Integer;
    begin
        //HEI.07>>
        "Reference No. FND" := RefNo;
        //HEI.07<<
    end;
    //BC Upgrade KAPOOV01 End

    //Yashraj >>
    procedure ModifyLotNoInformation(LotNo: Code[20])
    var
        LotNoInformation: Record "Lot No. Information";
    begin
        //<<QXL9.00.001 DAT 23/03/2016
        IF LotNoInformation.GET("Item No.", "Variant Code", LotNo) THEN BEGIN
            LotNoInformation."Your Reference FND" := "Your Reference FND";
            LotNoInformation.MODIFY();
        END;
    end;
    //>>QXL9.00.001 DAT 23/03/2016
    //Yashraj<<

    var
        recItem: Record Item;
        recItemTracking: Record "Item Tracking Code";
        Location: Record Location;
        //QualitySetup: Record "Quality Setup";//BC Upgrade KAPOOV01 Drink-it
        LotNoInfo: Record "Lot No. Information";
        recProdOrder: Record "Production Order";
        SerialNoInfo: Record "Serial No. Information";
        datCreationDate: Date;
        Text2013660: TextConst ENU = '%1 has been established by existing entries and cannot be changed.', FRA = '%1 a a été fixé(e) par les écritures existantes et ne peut pas être modifé(e).';
}

