tableextension 50190 WarehouseReceiptLineExtFND extends "Warehouse Receipt Line"
{
    // version NAVW110.0.00.14199,OWM4.50,QXL9.00.001,DITW110.00.12A,NRQ102424,HEI.15
    //     DITW15.00.00.21 DDR 20/06/2008 Change Caption of field38 "Cubage" > Caption "Volume (Cubage)"
    //                                Added test to calculate Weight & Cubage (Location field "Allow Calculate Weight Cubage")
    //                                Added key
    //                                  "Source Document,Source No."
    // DITW15.00.00.23.04 DDR 12/09/2008
    //                               Added fields
    //                                  2014079 "Weight to Receive"
    //                                  2014080 "Cubage to Receive"
    //                               Change Caption of field38 "Volume (Cubage)" -> "Volume Outstanding (Cubage)"
    //                               Change Caption of field39 "Weight"          -> "Weight Outstanding"
    // DITW15.00.00.25 DDR 16/10/2008 Added function UpdateShippingWhseHeader();GetWhseRcptHeader()
    //                                Added UpdateShippingWhseHeader when insert new record
    // DITW15.00.00.25.01 DDR 12/01/2009 License problem
    // DITW15.00.00.30 DDR 21/01/2009 merge DITW15.00.00.25.01
    // DITW15.00.00.33 DDR 13/05/2009 Added fields
    //                                  2013667 Item DTax Group Code
    //                                  2013751 Src. DTax Group Code
    // DITW15.00.00.35 DLE 06/09/2009 issue 516 Added fields
    //                                  2013696 Location Group Code
    //                                  2014094 Physical Location Group Code
    // DITW15.00.00.36 DDR 06/11/2009 issue 777 Added functions ShowCommentLines(),HasComments(),DrillDownTotalHeaderVolWeight()
    // DITW15.00.00.38 PRODW14.00.00.08.17 DDR 10/02/2011 issue 1273
    //                                Added fields
    //                                  2035090 No. of Quality tests
    //                                Added check item quality measures to open the item tracking lines
    //                                Added to transfer Bin Code for item tracking lines
    // DITW15.00.00.38 DDR 11/03/2011 issue 458 Replaced caption field2013696 'Location Group' -> 'Location Tax Group'
    //                                                           field2014094 (dutch)
    // DITW15.00.00.39 DDR 12/04/2011 issue 1296 Added AAD/ARC functionnality
    //                                  Added fields
    //                                    2013728 AAD No.
    //                                    2014263 ARC No.
    //                                    2014267 ARC No. Mandatory
    //                                    2014476 Packaging Type Code
    //                                    2014482 Pack Qty. per Unit of Measure
    //                                  Added functions
    //                                    EDILookupExtTrackingARC(),TestOpenEDIInboxDocNo(),UpdateDocSourceLines(),
    //                                    TestDocTypeSourceLineEmcs()
    //                     06/05/2011 issue 1296 Bugfix function UpdateDocSourceLines()
    //                     21/06/2011 issue 1370 Bugfix TableRelation property field2013751 "Source DTax Group Code"
    //                     11/07/2011 issue 1369 Added fields
    //                                  2013731 Applies-to AAD Trck. Entry No.
    // DITW15.00.00.39 PRODW14.00.00.08.18 DDR 26/07/2011 issue 1409
    //                                  Added function UpdateBinOpenQualityTests()
    //                                  Added text constants Text2035090,Text2035091
    //                     18/08/2011 issue 1369 Bugfix to clear field "Applies-to AAD Trck. entry no."
    // DITW15.00.00.39 PRODW14.00.00.08.18 DDR 18/08/2011 issue 1410
    //                                           Show all Quality tests, Removed source item ledger entry in flowfield
    //                                           Modified 'CalcFormula' property field2035090 No. of Quality Tests
    // DITW15.00.00.39 DDR 22/08/2011 issue 1399
    //                                Added fields
    //                                  2014105 Exist Posting Error Lines (flowfield)
    // DITW16.00.00.40 DDR 12/12/2011 issue 1002 Added call function DeleteLinkWhseRqst()
    //                                           Added functions IsLastSourceSourceDoc()
    //                     02/01/2012 DIT-715 issue 185
    //                                Added fields
    //                                  2014440 Attached to Line No.
    //                                Added functions UpdateAttachedLines(),SetWhseRcptHeader()
    //                     13/02/2012 DIT-715 #244
    //                                Added fields
    //                                  2014069 Shortcut Unit of Measure1 Code
    //                                  2014089 Shortcut Unit of Measure2 Code
    //                                  2014093 Shortcut Unit of Measure3 Code
    //                                Added functions GetCaptionClassUom(),ShowShortcutUomValue()
    //                     13/06/2012 DIT-715 #338 Added functions AllItemsAvailability()
    // DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific
    //                                             Added function OpenSSCCTrackingLines()
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM
    //                                             NORRIQ owm - Online Warehouse Management
    //                                             Copyright 2008 by NORRIQ A/S, www.norriq.dk
    //                                               New Key: No.,Source No.

    // FINXL7.00.001 RBE 20/03/2013: Item description extend 30 -> 80 chars
    // FINXL7.00.001 RBE 20/03/2013 Added code to update outstanding quantities from Qty to receive

    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0013.1
    //                             change return reason code on source doc
    // DITW17.00.02 AT  10/09/2013 DIT-770 #144 merge WHN-001 HIT0014.1
    //                             added approved prod group + approved line amount
    // DITW17.00.02 DDR 14/10/2013 DIT-715 #745 Merge
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.07 VSC 28/01/2016 DIT-770 #1702 Manco and Surplus Receipt tolerances per Item
    // DITW18.00.07 VSC 19/02/2016 DIT-770 #1703 CalcBaseQty Set to Global
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    // DITW18.00.07 VSC 29/06/2016 DIT-770 #1066 Removed Fields and allign code Delete Function UpdateShippingWhseHeader

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // DITW110.00.09 AKH 29/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // DITW110.00.11 VSC 03/10/2017 NRQ#33755 New Field Backorder Type
    // DITW110.00.11 MSF 04/10/2017 NRQ#39012 : Added Action GetPstdDocLinesToRevere
    // DITW110.00.12 MSF 07/05/2018 NRQ#69180 Create whse receipt-shipment should work directly again after the Whse document was deleted
    // DITW110.00.12A 21/06/2018 NRQ#74560 Conflict Backorder type and lot tracking in the warehouse receipt line
    //                                     Added function VerifyQuantity

    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #code added to allow zones without whs advanced management
    // HEI.02 FDD-PRDGAP024 IBM POENAB01 01.08.2017
    //   #changed table relation for field 13 Zone Code
    // HEI.03 FDD-SLSGAP001 IBM NASTAA02 08.09.2017 # MDM Customer Card
    //   # Increased "Src. DTax Group Code" field length from 10 to 20 characters
    // HEI.04 FDD-KDD0TC001 IBM HORTOC01 26.09.2017
    //   # New fields

    // HEI.05 FDD LOGGAP08 IBM POSTOI01 29.05.2018
    //   # new field 50008 Source Original Quantity Decimal
    // DITW110.00.13 ISL 05/12/2018 NRQ#91882 Synchronized "Backorder Type"
    // DITW111.00.13 MSF 06/12/2018 NRQ#94671 Line and header alert for not fully assigned lines - in warehouse shipment and sales order
    //                                         Added field Lot Reserved Qty. (Base)
    // HEI.06 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new fields added "Load No." & "Sequence No."
    // HEI.07 FDD_CHG2024489_HLP-200 HL Gate Control  SAXENS01 20.11.2019
    //   added new key "Unit of Measure Code"
    // DITW111.00.13 DDR 09/01/2019 NRQ#97823 Upgrade/Fix lost calculation of fields "Cubage to Receive","Weight to Receive"
    // HEI.08 CHG2095415 IBM BULIMC01 06.05.2021#new field added: 50012 -"Item Category Code"
    // HEI.09 CHG2155847 HB2821 IBM NANDIS01 03.08.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # New field created - Astro Integration(ID - 50013 - Boolean)
    // HEI.10 CHG2155847 HB2821 IBM NANDIS01 08.09.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # field deleted - Astro Integration(ID - 50013 - Boolean)
    // HEI.11 CHG2162715 HB3020 NORRIQ KOROLA04 07.11.2022
    //   # SPL Code, SPL Name - fields created
    // HEI.12 CHG2155847 HB2821 IBM NANDIS01 24.11.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # New field added - "Astro Unique ID"
    // DITW114.00.15 DDR 24/04/2020 NRQ#102424 Fix remove checking on source promotion lines
    // HEI.13 CHG2188015 DEBUSD01 10.01.2023 Qty to Ship behavior on promotionline partialShipments
    //   # merge NRQ#102424
    // HEI.14 CHG2204926 COSTES04 16.05.2023 Fix tablerelation for bin code
    //   # update table relation bin code
    // HEI.15 CHG2200362 COSTES04 13.06.2023 Updating Return reasons Code
    //   # update table relation for Return Reason Code

    // BC Upgrade SHUKLP03 >>
    // DrinkIT code, fields, actions and procedures are blocked.
    // HEI.14 => Did not find any change in BC and Nav table relation property of field BinCode.
    // HEI.15 => Not added because "Return Reason Code" is DrinkIT field.
    // BC Upgrade SHUKLP03 <<

    fields
    {
        modify("Bin Code")
        {
            trigger OnAfterValidate()
            var
                Bin: Record Bin;
            begin
                if "Bin Code" <> '' then begin//BC Upgrade SHARMP16 --purchprocesstesting
                                              //HEI.01 PRDGAP024>>
                    Bin.GET("Location Code", "Bin Code");
                    "Zone Code" := Bin."Zone Code";
                    //HEI.01 PRDGAP024<<
                end;//BC Upgrade SHARMP16 --purchprocesstesting
            end;
        }
        modify("Zone Code")
        {
            TableRelation = Zone.Code where("Location Code" = field("Location Code"), "Use As In-Transit FND" = filter(false));
            trigger OnAfterValidate()
            begin
                IF xRec."Zone Code" <> "Zone Code" THEN BEGIN
                    IF "Zone Code" <> '' THEN BEGIN
                        GetLocation("Location Code");
                        //HEI.01 PRDGAP024 delete line Location.TESTFIELD("Directed Put-away and Pick");
                        //HEI.01 PRDGAP024>>
                        IF "Zone Code" <> '' THEN BEGIN
                            WHSUTILS.CheckUserAuthorizedinZone("Location Code", "Zone Code");
                            VALIDATE("Bin Code", '');
                        end;
                        //HEI.01 PRDGAP024<<
                    end;
                    "Bin Code" := '';
                end;
            end;
        }
        field(50005; "RPM Solution FND"; Option)
        {
            Caption = 'RPM Solution';
            Description = 'HEI.04';
            Editable = false;
            OptionCaption = '" ,Deposit,Full-for-Empty with revenue impact (FFE with revenue),Full-for Empty without revenue impact (FFE w/o revenue)"';
            OptionMembers = " ",Deposit,"Full-for-Empty with revenue impact (FFE with revenue)","Full-for Empty without revenue impact (FFE w/o revenue)";
        }
        field(50006; "RPM Type FND"; Code[20])
        {
            Caption = 'RPM Type';
            Description = 'HEI.04';
            Editable = false;
            TableRelation = "Return Pack Material Type FND".Code;
        }
        field(50007; "Item Type FND"; Option)
        {
            Caption = 'Item Type';
            Description = 'HEI.04';
            Editable = false;
            OptionCaption = '" ,RPM Related,Product Related"';
            OptionMembers = " ","RPM Related","Product Related";
        }
        field(50008; "Source Original Quantity FND"; Decimal)
        {
            CaptionML = ENU = 'Source Original Quantity',
                        FRA = 'Quantité Originale';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.05';
            Editable = false;
        }
        field(50010; "Sequence No. FND"; Integer)
        {
            Caption = 'Sequence No.';
            Description = 'HEI.06';
        }
        field(50011; "Load No. FND"; Integer)
        {
            Caption = 'Load No.';
            Description = 'HEI.06';
        }
        field(50012; "Item Category Code FND"; Code[20])
        {
            Caption = 'Item Category Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
        }
        field(50054; "Astro Unique ID FND"; Code[20])
        {
            Caption = 'Astro Unique ID';
            DataClassification = ToBeClassified;
            Description = 'HEI.12';
            Editable = false;
        }
        field(50057; "SPL Code FND"; Code[20])
        {
            Caption = 'SPL Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
            TableRelation = "Vendor SPL Relation FND"."SPL Code";

            trigger OnLookup();
            var
                PL: Record "Purchase Line";
                VendorSPL: Record "Vendor SPL Relation FND";
                VendorSPLPage: Page "Vendor SPL List";
            begin
                //HEI.11 >>
                if not PL.GET(PL."Document Type"::Order, Rec."Source No.", Rec."Source Line No.") then
                    exit;

                VendorSPL.SETRANGE("Vendor No.", PL."Buy-from Vendor No.");
                VendorSPL.SETRANGE(Blocked, false);

                VendorSPLPage.SETTABLEVIEW(VendorSPL);
                VendorSPLPage.LOOKUPMODE(true);
                if VendorSPLPage.RUNMODAL() <> ACTION::LookupOK then
                    exit;

                VendorSPLPage.GETRECORD(VendorSPL);
                VALIDATE("SPL Code FND", VendorSPL."SPL Code");
                //HEI.11 <<
            end;

            trigger OnValidate();
            var
                PL: Record "Purchase Line";
                VendorSPL: Record "Vendor SPL Relation FND";
            begin
                //HEI.11 >>
                "SPL Name FND" := '';
                if PL.GET(PL."Document Type"::Order, Rec."Source No.", Rec."Source Line No.") then begin
                    if VendorSPL.GET(PL."Buy-from Vendor No.", "SPL Code FND") then
                        "SPL Name FND" := VendorSPL.Name
                    else
                        "SPL Code FND" := '';
                end;
                //HEI.11 <<
            end;
        }
        field(50058; "SPL Name FND"; Text[50])
        {
            Caption = 'SPL Name';
            DataClassification = ToBeClassified;
            Description = 'HEI.11';
            Editable = false;
        }

        // BC Upgrade SHUKLP03 >> DrinkIT fields are blocked

        //     field(2013667; "Item DTax Group Code"; Code[10])
        //     {
        //         CaptionML = ENU = 'Item Tax Group Code',
        //                     FRA = 'Code groupe taxe article';
        //         Description = 'DITW15.00.00.33';
        //         TableRelation = "Drink Tax Group".Code where("Source Type" = CONST(Item));
        //     }
        //     field(2013696; "Location Group Code"; Code[10])
        //     {
        //         CaptionML = ENU = 'Location Tax Group Code',
        //                     FRA = 'Code groupe magasin taxe';
        //         Description = 'DITW15.00.00.35';
        //         TableRelation = "Location Group";
        //     }
        //     field(2013728; "AAD No."; Code[20])
        //     {
        //         CaptionML = ENU = 'AAD No.',
        //                     FRA = 'N° DAA';
        //         Description = 'DITW15.00.00.39 #1296';

        //         trigger OnValidate();
        //         var
        //             PurchLine: Record "Purchase Line";
        //             SalesLine: Record "Sales Line";
        //             TransferLine: Record "Transfer Line";
        //         begin
        //             // <<DITW15.00.00.39 DDR 12/04/2011 #1296
        //             if Quantity = 0 then
        //                 FIELDERROR(Quantity);

        //             if (xRec."AAD No." <> "AAD No.") and ("AAD No." <> '') then
        //                 TestDocTypeSourceLineEmcs();

        //             if "AAD No." <> '' then begin
        //                 // <<DITW15.00.00.39 DDR 11/07/2011 #1369
        //                 if CurrFieldNo = FIELDNO("AAD No.") then
        //                     TESTFIELD("Applies-to AAD Trck. Entry No.", 0);
        //                 // >>DITW15.00.00.39 DDR #1369
        //                 AADDocMgt.CheckAADNo("AAD No.");
        //                 case "Source Type" of
        //                     DATABASE::"Purchase Line":
        //                         if PurchLine.GET("Source Subtype", "Source No.", "Source Line No.") then begin
        //                             PurchLine.TESTFIELD("Tariff No.");
        //                         end;
        //                     DATABASE::"Sales Line":
        //                         if SalesLine.GET("Source Subtype", "Source No.", "Source Line No.") then begin
        //                             SalesLine.TESTFIELD("Tariff No.");
        //                         end;
        //                     DATABASE::"Transfer Line":
        //                         if TransferLine.GET("Source No.", "Source Line No.") then begin
        //                             TransferLine.TESTFIELD("Tariff No.");
        //                         end;
        //                 end;
        //             end;
        //             if xRec."AAD No." <> "AAD No." then
        //                 UpdateDocSourceLines(FIELDNAME("AAD No."));
        //         end;
        //     }
        //     field(2013731; "Applies-to AAD Trck. Entry No."; Integer)
        //     {
        //         CaptionML = ENU = 'Applies-to Correction AAD Trck. Entry No.',
        //                     FRA = 'N° Ecriture correction suivi DAA lettrage';
        //         Description = 'DITW15.00.00.39 #1369';
        //         TableRelation = "AAD Tracking Entry"."Entry No." where("Entry Type" = CONST(Outbound));

        //         trigger OnValidate();
        //         var
        //             AADTrackingEntry: Record "AAD Tracking Entry";
        //         begin
        //             TESTFIELD("Item No.");
        //             if "Applies-to AAD Trck. Entry No." <> 0 then begin
        //                 // <<DITW15.00.00.39 DDR 18/08/2011 #1369
        //                 if xRec."Applies-to AAD Trck. Entry No." = 0 then begin
        //                     TESTFIELD("AAD No.", '');
        //                     TESTFIELD("ARC No.", '');
        //                 end;
        //                 // >>DITW15.00.00.39 DDR #1369
        //                 AADTrackingEntry.GET("Applies-to AAD Trck. Entry No.");
        //                 "AAD No." := AADTrackingEntry."AAD No.";
        //                 "ARC No." := AADTrackingEntry."ARC No.";
        //             end else begin
        //                 // <<DITW15.00.00.39 DDR 18/08/2011 #1369
        //                 "AAD No." := '';
        //                 "ARC No." := '';
        //                 // >>DITW15.00.00.39 DDR #1369
        //             end;
        //         end;
        //     }
        //     field(2013751; "Src. DTax Group Code"; Code[20])
        //     {
        //         CaptionML = ENU = 'Source Tax Group Code',
        //                     FRA = 'Code groupe taxe Source';
        //         Description = 'DITW15.00.00.33-.39 #1370,HEI.03';
        //         TableRelation = "Drink Tax Group".Code;
        //     }
        //     field(2014067; "Backorder Type"; Option)
        //     {
        //         Caption = 'Backorder Type';
        //         Description = 'DITW110.00.11 NRQ#33755';
        //         OptionCaption = '" ,Backorder,No Backorder"';
        //         OptionMembers = " ",Backorder,"No Backorder";

        //         trigger OnValidate();
        //         var
        //             ItemBackOrderNotification: Notification;
        //         begin
        //             //<< DITW110.00.11 VSC 03/10/2017 NRQ#33755

        //             case "Source Type" of
        //                 DATABASE::"Purchase Line":
        //                     begin
        //                         case "Source Subtype" of
        //                             1:
        //                                 begin
        //                                     if "Backorder Type" = "Backorder Type"::Backorder then
        //                                         ERROR(Text2014067, FIELDCAPTION("Backorder Type"), "Backorder Type");
        //                                 end;
        //                             5:
        //                                 ;
        //                             else
        //                                 "Backorder Type" := "Backorder Type"::" ";
        //                         end;
        //                     end;
        //                 DATABASE::"Sales Line":
        //                     begin
        //                         case "Source Subtype" of
        //                             1:
        //                                 ;
        //                             5:
        //                                 begin
        //                                     if "Backorder Type" = "Backorder Type"::Backorder then
        //                                         ERROR(Text2014067, FIELDCAPTION("Backorder Type"), "Backorder Type");
        //                                     //<<DITW110.00.12A 21/06/2018 NRQ#74560
        //                                     if (Rec."Backorder Type" <> Rec."Backorder Type"::" ") then begin
        //                                         VerifyQuantity(Rec);
        //                                     end;
        //                                     //>>DITW110.00.12A 21/06/2018 NRQ#74560
        //                                     // <<DITW110.00.13 ISL 05/12/2018 NRQ#91882
        //                                     BackorderMgt.SyncBackorder("Source Subtype", "Source No.", "Source Line No.", "Backorder Type");
        //                                     // >>DITW110.00.13 ISL NRQ#91882
        //                                 end;
        //                             else
        //                                 "Backorder Type" := "Backorder Type"::" ";
        //                         end;
        //                     end;
        //                 DATABASE::"Transfer Line":
        //                     begin
        //                         "Backorder Type" := "Backorder Type"::" ";
        //                     end;
        //             end;
        //         end;
        //     }
        //     field(2014079; "Cubage to Receive"; Decimal)
        //     {
        //         CaptionML = ENU = 'Volume to Receive (Cubage)',
        //                     FRA = 'Volume à recevoir (Cubage)';
        //         DecimalPlaces = 0 : 5;
        //         Description = 'DITW15.00.00.23.04';
        //     }
        //     field(2014080; "Weight to Receive"; Decimal)
        //     {
        //         CaptionML = ENU = 'Weight To Receive',
        //                     FRA = 'Poids à recevoir';
        //         DecimalPlaces = 0 : 5;
        //         Description = 'DITW15.00.00.23.04';
        //     }
        //     field(2014094; "Physical Location Group Code"; Code[10])
        //     {
        //         CaptionML = ENU = 'Physical Location Group Code',
        //                     FRA = 'Code groupe magasin réel';
        //         Description = 'DITW15.00.00.35';
        //         TableRelation = "Physical Location Group";
        //     }
        //     field(2014105; "Posting Error Line"; Boolean)
        //     {
        //         CaptionML = ENU = 'Posting Error',
        //                     FRA = 'Erreur de validation';
        //         Description = 'DITW15.00.00.39 #1399';
        //     }
        //     field(2014262; "ARC No."; Code[30])
        //     {
        //         CaptionML = ENU = 'ARC No.',
        //                     FRA = 'N° ARC';
        //         Description = 'DITW15.00.00.39 #1296';

        //         trigger OnLookup();
        //         var
        //             NewText: Text[1024];
        //         begin
        //             // <<DITW15.00.00.39 DDR 12/04/2011 #1296
        //             NewText := "ARC No.";
        //             if EDILookupExtTrackingARC(NewText) then
        //                 VALIDATE("ARC No.", NewText);
        //         end;

        //         trigger OnValidate();
        //         var
        //             TempWhseRcptLine: Record "Warehouse Receipt Line" temporary;
        //         begin
        //             // <<DITW15.00.00.39 DDR 12/04/2011 #1296
        //             if (xRec."ARC No." <> "ARC No.") and ("ARC No." <> '') then
        //                 TestDocTypeSourceLineEmcs();

        //             if "ARC No." <> '' then
        //                 TESTFIELD("ARC No. Mandatory")
        //             else
        //                 if "ARC No. Mandatory" then begin
        //                     TempWhseRcptLine := Rec;
        //                     TempWhseRcptLine.SETRECFILTER;
        //                     if GUIALLOWED and not HideValidationDialog and (CurrFieldNo <> 0) then
        //                         MESSAGE(Text2014260, FIELDCAPTION("ARC No."), TABLECAPTION, TempWhseRcptLine.GETFILTERS);
        //                 end;
        //             if xRec."ARC No." <> "ARC No." then begin
        //                 // <<DITW15.00.00.39 DDR 18/08/2011 #1369
        //                 if (CurrFieldNo <> 0) or ((xRec."ARC No." <> '') and ("ARC No." = '')) then
        //                     MODIFY;
        //                 UpdateDocSourceLines(FIELDNAME("ARC No."));
        //             end;
        //             // <<DITW15.00.00.39 DDR 11/07/2011 #1369
        //             if CurrFieldNo = FIELDNO("ARC No.") then
        //                 TESTFIELD("Applies-to AAD Trck. Entry No.", 0);
        //             // >>DITW15.00.00.39 DDR #1369
        //         end;
        //     }
        //     field(2014263; "SAD No."; Code[30])
        //     {
        //         CaptionML = ENU = 'SAD No.',
        //                     FRA = 'N° SAD';
        //         Description = 'DITW15.00.00.39 #1296';

        //         trigger OnValidate();
        //         begin
        //             // <<DITW15.00.00.39 DDR 12/04/2011 #1296
        //             if xRec."SAD No." <> "SAD No." then
        //                 UpdateDocSourceLines(FIELDNAME("SAD No."));
        //         end;
        //     }
        //     field(2014267; "ARC No. Mandatory"; Boolean)
        //     {
        //         CaptionML = ENU = 'ARC No. Mandatory (EMCS)',
        //                     FRA = 'N° ARC obligatoire (EMCS)';
        //         Description = 'DITW15.00.00.39 #1296';
        //     }
        //     field(2014418; "Lot Reserved Qty. (Base)"; Decimal)
        //     {
        //         CalcFormula = - Sum("Reservation Entry"."Quantity (Base)" where("Source ID" = FIELD("Source No."),
        //                                                                         "Source Type" = FIELD("Source Type"),
        //                                                                         "Source Subtype" = FIELD("Source Subtype"),
        //                                                                         "Source Ref. No." = FIELD("Source Line No."),
        //                                                                         "Reservation Status" = CONST(Surplus),
        //                                                                         "Lot No." = FILTER(<> '')));
        //         Caption = 'Lot Reserved Qty. (Base)';
        //         Description = 'NRQ#94671';
        //         FieldClass = FlowField;
        //     }
        //     field(2014431; "Return Reason Code"; Code[10])
        //     {
        //         CaptionML = ENU = 'Return Reason Code',
        //                     FRA = 'Code motif retour';
        //         Description = 'DITW17.00.02 DIT-770 #144';
        //         TableRelation = "Return Reason" where(Blocked = CONST(false));

        //         trigger OnValidate();
        //         var
        //             PurchaseLine: Record "Purchase Line";
        //             SalesLine: Record "Sales Line";
        //             TransferLine: Record "Transfer Line";
        //             Direction: Option Outbound,Inbound;
        //         begin
        //             case "Source Type" of
        //                 DATABASE::"Purchase Line":
        //                     begin
        //                         if PurchaseLine.GET("Source Subtype", "Source No.", "Source Line No.") then begin
        //                             PurchaseLine."Return Reason Code" := "Return Reason Code";
        //                             UpdateDocSourceLines(FIELDNAME("Return Reason Code"));
        //                         end;
        //                     end;
        //                 DATABASE::"Sales Line":
        //                     begin
        //                         if SalesLine.GET("Source Subtype", "Source No.", "Source Line No.") then begin
        //                             SalesLine."Return Reason Code" := "Return Reason Code";
        //                             UpdateDocSourceLines(FIELDNAME("Return Reason Code"));
        //                         end;
        //                     end;
        //             end;
        //         end;
        //     }
        //     field(2014440; "Attached to Line No."; Integer)
        //     {
        //         CaptionML = ENU = 'Attached to Line No.',
        //                     FRA = 'Attaché à la ligne n°';
        //         Description = 'DITW16.00.00.40 DIT715 #185';
        //         Editable = false;
        //         TableRelation = "Warehouse Receipt Line"."Line No." where("No." = FIELD("No."),
        //                                                                    "Attached to Line No." = CONST(0));
        //     }
        //     field(2014476; "Packaging Type Code"; Code[10])
        //     {
        //         CaptionML = ENU = 'Packaging Type Code',
        //                     FRA = 'Code Type de Conditionnement';
        //         Description = 'DITW15.00.00.39 #1296';
        //         TableRelation = "Packaging Type";

        //         trigger OnValidate();
        //         begin
        //             // <<DITW15.00.00.39 DDR 12/04/2011 #1296
        //             if (xRec."Packaging Type Code" <> "Packaging Type Code") and ("Packaging Type Code" <> '') then
        //                 TestDocTypeSourceLineEmcs();

        //             if xRec."Packaging Type Code" <> "Packaging Type Code" then
        //                 UpdateDocSourceLines(FIELDNAME("Packaging Type Code"));
        //         end;
        //     }
        //     field(2014482; "Pack Qty. per Unit of Measure"; Decimal)
        //     {
        //         CaptionML = ENU = 'Packaging Qty. per Unit of Measure',
        //                     FRA = 'Quantité conditionnement par unité';
        //         DecimalPlaces = 0 : 5;
        //         Description = 'DITW15.00.00.39 #1296';

        //         trigger OnValidate();
        //         begin
        //             // <<DITW15.00.00.39 DDR 12/04/2011 #1296
        //             if xRec."Pack Qty. per Unit of Measure" <> "Pack Qty. per Unit of Measure" then
        //                 UpdateDocSourceLines(FIELDNAME("Pack Qty. per Unit of Measure"));
        //         end;
        //     }
        //     field(2035090; "No. of Quality Tests"; Integer)
        //     {
        //         CalcFormula = Count("Quality Test Header" where("Document Type" = CONST("Lot/SN Test"),
        //                                                          "Source Type" = FIELD("Source Type"),
        //                                                          "Source Subtype" = FIELD("Source Subtype"),
        //                                                          "Source ID" = FIELD("Source No."),
        //                                                          "Source Ref. No." = FIELD("Source Line No."),
        //                                                          "Item No." = FIELD("Item No.")));
        //         CaptionML = ENU = 'No. of Quality Tests',
        //                     FRA = '<Nbre de Tests Qualité>';
        //         Description = 'QXL9.00.001';
        //         Editable = false;
        //         FieldClass = FlowField;
        //     }
        // BC Upgrade SHUKLP03 << DrinkIT fields are blocked

    }
    keys
    {

        //Unsupported feature: PropertyChange on ""Bin Code","Location Code"(Key)". Please convert manually.

        key(Key50000; "Source Document", "Source No.")
        {
        }
        key(Key50001; "No.", "Source No.")
        {
        }
        key(Key50002; "Unit of Measure Code")
        {
        }
    }


    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger (Variable: lrWhseRcptLine)();
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
    if (Quantity <> "Qty. Outstanding") and ("Qty. Outstanding" <> 0) then
      if not CONFIRM(Text004,false,TABLECAPTION,"Line No.") then
        ERROR(Text003);
    #4..7
      WhseRcptHeader.VALIDATE("Document Status",OrderStatus);
      WhseRcptHeader.MODIFY;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..10

    // <<DITW15.00.00.39 DDR 12/04/2011 #1296
    // <<DITW15.00.00.39 DDR 18/08/2011 #1369
    if "Applies-to AAD Trck. Entry No." = 0 then begin
    // >>DITW15.00.00.39 DDR #1369
      if ("AAD No." <> '') and ("Qty. Outstanding" <> 0) then
        VALIDATE("AAD No.",'');
      if ("ARC No." <> '') and ("Qty. Outstanding" <> 0) then
        VALIDATE("ARC No.",'');
    end;
    // >>DITW15.00.00.39 DDR #1296

    // <<DITW16.00.00.40 DDR 12/12/2011 #1002
    if IsLastSourceSourceDoc() then
      WMSMgt.DeleteLinkWhseRqst("No.","Source Type","Source Subtype","Source No.","Source Line No.",0);
    // >>DITW16.00.00.40 DDR #1002
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW15.00.00.39 DDR 22/08/2011 #1399
    "Posting Error Line" := false;
    // >>DITW15.00.00.39 DDR #1399
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    var
        OldPurchHeader: Record "Purchase Header";
        PurchHeader: Record "Purchase Header";
        lrecPurchLine: Record "Purchase Line";
        OldSalesHeader: Record "Sales Header";
        ReleasePurchDocument: Codeunit "Release Purchase Document";
        ReleaseSalesDocument: Codeunit "Release Sales Document";
        MancoSurplusTolerance: Boolean;
        "_LFINXL7.00.001": Integer;

    var
        lrWhseRcptLine: Record "Warehouse Receipt Line";


    //Unsupported feature: PropertyModification on "Text001(Variable 1022)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot rename a %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot rename a %1.;FRA=Vous ne pouvez pas renommer l'enregistrement %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1021)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=You cannot handle more than the outstanding %1 units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=You cannot handle more than the outstanding %1 units.;FRA=Vous ne pouvez pas traiter plus que les %1 unités restantes.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=Cancelled.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=Cancelled.;FRA=Annulé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=%1 %2 is not completely received.\Do you really want to delete the %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=%1 %2 is not completely received.\Do you really want to delete the %1?;FRA=%1 %2 n'a pas été entièrement réceptionnée.\Souhaitez-vous vraiment supprimer la %1 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=You cannot Cross-Dock  more than the %1 units to be received.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=You cannot Cross-Dock  more than the %1 units to be received.;FRA=Vous ne pouvez pas transborder plus des %1 unités à réceptionner.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=Cross-Docking is disabled for this %1 and/or %2;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=Cross-Docking is disabled for this %1 and/or %2;FRA=Le transbordement est désactivé pour cet %1 et/ou ce %2;
    //Variable type has not been exported.

    var
        HideValidationDialog: Boolean;
        Text000: TextConst ENU = 'must not be the %1 of the %2', FRA = 'ne doit pas être le %1 de %2';

    var
        Customer: Record Customer;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        PurchCommentLine: Record "Purch. Comment Line";
        // rShippingWhseSetup: Record "Shipping-Warehouse Setup"; 
        SalesCommentLine: Record "Sales Comment Line";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        WhseRcptHeader: Record "Warehouse Receipt Header";
        SaveTempWhseRcptLine: Record "Warehouse Receipt Line" temporary;
        // BC Upgrade SHUKLP03 >>DrinkIT variable are blocked

        // TaxChargesMgt: Codeunit "Tax Item Charges Mgt.";
        // DepositChargesMgt: Codeunit "Deposit Item Charges Mgt.";
        // PromotionChargesMgt: Codeunit "Promotion Item Charges Mgt.";
        // TransferChargesMgt: Codeunit "Transfer Document Charges Mgt.";
        // BC Upgrade SHUKLP03 << DrinkIT variable are blocked
        WhseSetup: Record "Warehouse Setup";
        // BackorderMgt: Codeunit "Backorder Mgt.";  // BC Upgrade SHUKLP03  DrinkIT variable  are blocked
        WHSUTILS: Codeunit "WHS-UTILS";
        WMSMgt: Codeunit "WMS Management";
        Text2014067: TextConst ENU = 'NLD=%1 can not been set to %2 for inbound!';
        // BC Upgrade SHUKLP03 >>DrinkIT variable are blocked

        // QualitySetup: Record "Quality Setup";
        // QualityMgt: Codeunit "Quality Management";
        // AADDocMgt: Codeunit "AAD Document Mgt.";

        // BC Upgrade SHUKLP03 <<DrinkIT variable are blocked
        Text2014260: TextConst ENU = 'You must specify %1 in %2 %3.', FRA = 'Vous devez indiquer %1 dans %2 %3.';
        Text2035090: TextConst ENU = 'You cannot change %1 because there are one or more posted %2 quality tests for this line.', FRA = 'Vous ne pouvez pas modifier la valeur %1 car il existe une ou plusieurs tests de qualité validés %2 pour cette ligne.';
        Text2035091: TextConst ENU = 'Pass or Concession', FRA = 'Bon ou Concession';
}

