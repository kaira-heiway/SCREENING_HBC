tableextension 50170 AssemblyLineExtFND extends "Assembly Line"
{
    // version NAVW110.0,FINXL10.00,DITW110.00.10,HEI.04

    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #added fields Zone Code and validation
    // HEI.02 FDD-GAPID031 IBM.PATHAA02 17.08.2017
    //   # Description made non-Editable
    //   # changed to default -09.11.2017
    // HEI.03 FDD-SLSGAP001 IBM NASTAA02 08.09.2017 # MDM Customer Card
    //   # Increased "Customer DTax Group Code" field length from 10 to 20 characters
    // HEI.04 CHG2174146 SAHAL01 20.02.2023 Assembly Order Outbound and Inbound interfaces HeiLite -- Astro WMS
    //   # Added Code to restrict modification after Parked the Assembly Order for Astro.
    //**********************************************************************************
    // BC UPGRADE PATHAA02-10.11.25
    //1. HEI.01-Done
    //2. HEI.02-Cannot make a std field-"Description" non-editable on Table Ext, needs to be handled on pages
    //3. HEI.03 is commented-DIT, HEI.04 is commented-Astro
    //*************************************************************************************
    //HEI.05 #FDD-Unit Volume-Assembly Orders[FDD PID-750, PID-826, PID-76, PID-801, FDD DtW 017, IBM GAP DTW 76] IBM PATHAA02 01.04.26 
    //# Added new field "Unit Volume HL" to Assembly Line
    //# Code written on "No.".-OnAfterValidate" to flow value from Item to this field.



    fields
    {
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            //OptionCaptionML = ENU = 'Quote,Order,,,Blanket Order', FRA = 'Devis,Commande,,,Commande ouverte';
        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';

        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            //OptionCaptionML = ENU = ' ,Item,Resource,Charge (Item)', FRA = ' ,Article,Ressource,Frais annexe';

            //Unsupported feature: Change OptionString on "Type(Field 10)". Please convert manually.

        }

        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
            trigger OnAfterValidate()
            var
                item: Record Item;
            begin
                //HEI.05>>
                IF item.get("No.") THEN
                    "Unit Volume HL FND" := Item."Unit Volume";
                //HEI.05<<
            end;

        }

        modify("Variant Code")
        {
            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Description';


            //Unsupported feature: Change Description on "Description(Field 13)". Please convert manually.

        }
        modify("Description 2")
        {
            CaptionML = ENU = 'Description 2', FRA = 'Description 2';
        }
        modify("Lead-Time Offset")
        {
            CaptionML = ENU = 'Lead-Time Offset', FRA = 'Décalage du délai';
        }
        modify("Resource Usage Type")
        {
            CaptionML = ENU = 'Resource Usage Type', FRA = 'Type d''utilisation des ressources';
            OptionCaptionML = ENU = ' ,Direct,Fixed', FRA = ' ,Direct,Fixe';
        }
        modify("Location Code")
        {

            //Unsupported feature: Change TableRelation on ""Location Code"(Field 20)". Please convert manually.

            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';

            //Unsupported feature: Change ValidateTableRelation on ""Location Code"(Field 20)". Please convert manually.

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

            //Unsupported feature: Change TableRelation on ""Bin Code"(Field 23)". Please convert manually.

            CaptionML = ENU = 'Bin Code', FRA = 'Code emplacement';
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
        modify("Appl.-to Item Entry")
        {
            CaptionML = ENU = 'Appl.-to Item Entry', FRA = 'Écr. article à lettrer';
        }
        modify("Appl.-from Item Entry")
        {
            CaptionML = ENU = 'Appl.-from Item Entry', FRA = 'Écriture article à lettrer';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Quantity (Base)")
        {
            CaptionML = ENU = 'Quantity (Base)', FRA = 'Quantité (base)';
        }
        modify("Remaining Quantity")
        {
            CaptionML = ENU = 'Remaining Quantity', FRA = 'Quantité restante';
        }
        modify("Remaining Quantity (Base)")
        {
            CaptionML = ENU = 'Remaining Quantity (Base)', FRA = 'Quantité restante (base)';
        }
        modify("Consumed Quantity")
        {
            CaptionML = ENU = 'Consumed Quantity', FRA = 'Quantité consommée';
        }
        modify("Consumed Quantity (Base)")
        {
            CaptionML = ENU = 'Consumed Quantity (Base)', FRA = 'Quantité consommée (base)';
        }
        modify("Quantity to Consume")
        {
            CaptionML = ENU = 'Quantity to Consume', FRA = 'Quantité à consommer';
        }
        modify("Quantity to Consume (Base)")
        {
            CaptionML = ENU = 'Quantity to Consume (Base)', FRA = 'Quantité à consommer (base)';
        }
        modify("Reserved Quantity")
        {
            CaptionML = ENU = 'Reserved Quantity', FRA = 'Quantité réservée';
        }
        modify("Reserved Qty. (Base)")
        {
            CaptionML = ENU = 'Reserved Qty. (Base)', FRA = 'Quantité réservée (base)';
        }
        modify("Avail. Warning")
        {
            CaptionML = ENU = 'Avail. Warning', FRA = 'Avertissement dispo';
        }
        modify("Substitution Available")
        {
            CaptionML = ENU = 'Substitution Available', FRA = 'Substitut disponible';
        }
        modify("Due Date")
        {
            CaptionML = ENU = 'Due Date', FRA = 'Date d''échéance';
        }
        modify(Reserve)
        {
            CaptionML = ENU = 'Reserve', FRA = 'Réserver';
            //OptionCaptionML = ENU = 'Never,Optional,Always', FRA = 'Jamais,Manuel,Toujours';
        }
        modify("Quantity per")
        {
            CaptionML = ENU = 'Quantity per', FRA = 'Quantité par';
        }
        modify("Qty. per Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Unit of Measure', FRA = 'Quantité par unité';
        }
        modify("Inventory Posting Group")
        {
            CaptionML = ENU = 'Inventory Posting Group', FRA = 'Groupe compta. stock';
        }
        modify("Gen. Prod. Posting Group")
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group', FRA = 'Groupe compta. produit';
        }
        modify("Unit Cost")
        {
            CaptionML = ENU = 'Unit Cost', FRA = 'Coût unitaire';
        }
        modify("Cost Amount")
        {
            CaptionML = ENU = 'Cost Amount', FRA = 'Coût total';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify("Unit of Measure Code")
        {
            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Pick Qty.")
        {
            CaptionML = ENU = 'Pick Qty.', FRA = 'Prélever qté';
        }
        modify("Pick Qty. (Base)")
        {
            CaptionML = ENU = 'Pick Qty. (Base)', FRA = 'Prélever qté (base)';
        }
        modify("Qty. Picked")
        {
            CaptionML = ENU = 'Qty. Picked', FRA = 'Qté prélevée';
        }
        modify("Qty. Picked (Base)")
        {
            CaptionML = ENU = 'Qty. Picked (Base)', FRA = 'Qté prélevée (base)';
        }

        //Unsupported feature: CodeModification on "Type(Field 10).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Consumed Quantity",0);
        VerifyReservationChange(Rec,xRec);
        TestStatusOpen;

        "No." := '';
        "Variant Code" := '';
        "Location Code" := '';
        "Bin Code" := '';
        InitResourceUsageType;
        "Inventory Posting Group" := '';
        "Gen. Prod. Posting Group" := '';
        CLEAR("Lead-Time Offset");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        // <<DITW17.10.05 DDR 21/08/2014 DIT-770 #675
        if (Type = Type::"Charge (Item)") and (CurrFieldNo = FIELDNO(Type)) then
          FIELDERROR(Type);

        if (Type <> xRec.Type) and (CurrFieldNo <> 0) and (xRec.Type = xRec.Type::Item) then begin
          CLEAR(TaxAssemblyMgt);
          xRec.DeleteAllChargeLines(true);
        end;
        // >>DITW17.10.05 DDR DIT-770 #675

        #5..12
        */
        //end;


        //Unsupported feature: CodeInsertion on ""No."(Field 11).OnValidate". Please convert manually.

        //trigger (Variable: TempCurrFieldNo)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""No."(Field 11).OnValidate". Please convert manually.

        //trigger "(Field 11)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Consumed Quantity",0);
        CALCFIELDS("Reserved Quantity");
        WhseValidateSourceLine.AssemblyLineVerifyChange(Rec,xRec);
        #4..10
          InitResourceUsageType;
        end;

        if "No." = '' then
          INIT
        else begin
          GetHeader;
          "Due Date" := AssemblyHeader."Starting Date";
          case Type of
            Type::Item:
              begin
                "Location Code" := AssemblyHeader."Location Code";
                GetItemResource;
                Item.TESTFIELD("Inventory Posting Group");
                "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
                "Inventory Posting Group" := Item."Inventory Posting Group";
                GetDefaultBin;
                Description := Item.Description;
                "Description 2" := Item."Description 2";
                "Unit Cost" := GetUnitCost;
                VALIDATE("Unit of Measure Code",Item."Base Unit of Measure");
                CreateDim(DATABASE::Item,"No.",AssemblyHeader."Dimension Set ID");
                Reserve := Item.Reserve;
                VALIDATE(Quantity);
                VALIDATE("Quantity to Consume",
                  MinValue(MaxQtyToConsume,CalcQuantity("Quantity per",AssemblyHeader."Quantity to Assemble")));
              end;
            Type::Resource:
              begin
        #40..43
                Description := Resource.Name;
                "Description 2" := Resource."Name 2";
                "Unit Cost" := GetUnitCost;
                VALIDATE("Unit of Measure Code",Resource."Base Unit of Measure");
                CreateDim(DATABASE::Resource,"No.",AssemblyHeader."Dimension Set ID");
                VALIDATE(Quantity);
                VALIDATE("Quantity to Consume",
                  MinValue(MaxQtyToConsume,CalcQuantity("Quantity per",AssemblyHeader."Quantity to Assemble")));
              end;
          end
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..13
        // <<DITW17.10.05 DDR 21/08/2014 DIT-770 #675
        CLEAR(TaxAssemblyMgt);
        // >>DITW17.10.05 DDR DIT-770 #675

        //HEI.04>>
        if CurrFieldNo <> 0 then begin
          ValidateAstroAssemblyOrderLineModification;
        end;
        //HEI.04<<

        #14..17
          // <<DITW17.10.05 DDR 21/08/2014 05/09/2014 DIT-770 #675
          "Customer DTax Group Code" := AssemblyHeader."Customer DTax Group Code";
          // >>DITW17.10.05 DDR DIT-770 #675

        #18..21
                //<<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192 -04/03/2015 DIT-770 #1192
                "Responsibility Center" :=AssemblyHeader."Responsibility Center";
                "Physical Location Group Code" := AssemblyHeader."Physical Location Group Code";
                //>>DITW18.00.06 MSF 26/02/2015 DIT-770 #1192 -04/03/2015 DIT-770 #1192
                "Location Code" := AssemblyHeader."Location Code";
                 //<<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
                 //Code to Review For Release 5
                 // ItemLocationCode := UserSetupMgt.GetLocation(0,Item."Location Code","Responsibility Center");
                 // IF ItemLocationCode <> '' THEN
                 //   "Location Code" := ItemLocationCode;
                 //IF NOT UserSetupMgt.CheckLocation(0,"Location Code","Responsibility Center") THEN
                 //  ERROR(
                 //    Text2014414,
                 //    Location.TABLECAPTION,"Location Code",
                 //    RespCenter.TABLECAPTION,UserSetupMgt.GetSalesFilter);
                 //IF "Location Code" <> xRec."Location Code" THEN
                 //  VALIDATE("Location Code");
                 //IF Location.Code <> '' THEN
                 // "Physical Location Group Code" := Location."Physical Location Group Code";
                 //>>DITW18.00.06 MSF 04/04/2015 DIT-770 #1192

                GetItemResource;
                Item.TESTFIELD("Inventory Posting Group");
                // << DITW110.00.11 SFI 31/08/2017 BL#30569
                Item.BlockedSKU("Location Code","Variant Code",true);
                // >> DITW110.00.11 SFI BL#30569
        #25..30
                // <<DITW17.10.05 DDR 21/08/2014 DIT-770 #675
                "Item Charge Value" := "Unit Cost";
                "Unit Volume HL" := Item."Unit Volume HL";

                if Item."Location Code" <> '' then
                  "Location Code" := Item."Location Code";
                GetLocation(Location,"Location Code");
                "Physical Location Group Code" := Location."Physical Location Group Code";
                "Location Group Code" := Location."Location Group Code";
                "Item DTax Group Code" := Item."Item DTax Group Code";
                "Customer DTax Group Code" := GetCustTaxGroupCode("Customer DTax Group Code","Item DTax Group Code");
                //IF ("Customer DTax Group Code" <> '') AND ("Customer DTax Group Code" <> SalesHeader."Customer DTax Group Code") THEN
                //  TestCustTaxRegHeader();
                "Unit Volume HL" := Item."Unit Volume HL";
                "Tariff No." := Item."Tariff No.";
                // >>DITW17.10.05 DDR DIT-770 #675

                VALIDATE("Unit of Measure Code",Item."Base Unit of Measure");
                //<<DITW18.00.06 AKH 04/03/2015 DIT-770 #1197
                //CreateDim(DATABASE::Item,"No.",AssemblyHeader."Dimension Set ID");
                CreateDim(DATABASE::Item,"No.",DATABASE::"Responsibility Center","Responsibility Center",AssemblyHeader."Dimension Set ID");
                //>>DITW18.00.06 AKH 04/03/2015 DIT-770 #1197
        #33..36

              //<<FINXL8.00.001 BSA 02/06/2015 #178
              if recFinXLSetup.READPERMISSION then
                fctValidateCrossReference;
              //>>FINXL8.00.001 BSA 02/06/2015 #178

        #37..46
                // <<DITW18.00.06 DDR 05/11/2015 DIT-770 #1499
                "Item Charge Value" := "Unit Cost";
                // >>DITW18.00.06 DDR DIT-770 #1499
                VALIDATE("Unit of Measure Code",Resource."Base Unit of Measure");

                //<<DITW18.00.06 AKH 04/03/2015 DIT-770 #1197
                //CreateDim(DATABASE::Resource,"No.",AssemblyHeader."Dimension Set ID");
                CreateDim(DATABASE::Resource,"No.",DATABASE::"Responsibility Center","Responsibility Center",AssemblyHeader."Dimension Set ID");
                //>>DITW18.00.06 AKH 04/03/2015 DIT-770 #1197

        #49..52
            // <<DITW17.10.05 DDR 21/08/2014 DIT-770 #675
            Type::"Charge (Item)":
              begin
                ItemCharge.GET("No.");
                if (CurrFieldNo <> 0) and (ItemCharge."Item Charge Type" <> "Item Charge Type"::" ") then
                  ItemCharge.FIELDERROR("Item Charge Type");
                Description := ItemCharge.Description;
                "Gen. Prod. Posting Group" := ItemCharge."Gen. Prod. Posting Group";
                //"VAT Prod. Posting Group" := ItemCharge."VAT Prod. Posting Group";
                //"Tax Group Code" := ItemCharge."Tax Group Code";
                "Item Charge Type" := ItemCharge."Item Charge Type";
                //"Gen. Prod. Posting Free Group" := ItemCharge."Gen. Prod. Posting Free Group";
                //<<DITW18.00.06 AKH 04/03/2015 DIT-770 #1197
                //CreateDim(CreateDim(DATABASE::"Item Charge","No.",AssemblyHeader."Dimension Set ID");
                CreateDim(DATABASE::"Item Charge","No.",DATABASE::"Responsibility Center","Responsibility Center",AssemblyHeader."Dimension Set ID");
                //>>DITW18.00.06 AKH 04/03/2015 DIT-770 #1197
                VALIDATE(Quantity);
                //$$calc from attached line item
                VALIDATE("Quantity to Consume",
                  MinValue(MaxQtyToConsume,CalcQuantity("Quantity per",AssemblyHeader."Quantity to Assemble")));
              end;
            // >>DITW17.10.05 DDR DIT-770 #675
          end
        end;

        // <<DITW17.10.05 DDR 21/08/2014 DIT-770 #675
        if (CurrFieldNo = FIELDNO("No.")) and ("Consumed Quantity" = 0) and
           (Type = Type::Item)  and ("Line No." <> 0)
        then begin
          CLEAR(TaxAssemblyMgt);
          if (Quantity <> 0) or (xRec.Quantity <> Quantity) then
            InsertCharges4(FIELDNO("No."))
          else
            DeleteAllChargeLines(true);
        end;
        // >>DITW17.10.05 DDR DIT-770 #675
        */
        //end;


        //Unsupported feature: CodeModification on ""Variant Code"(Field 12).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Type,Type::Item);
        TESTFIELD("Consumed Quantity",0);
        CALCFIELDS("Reserved Quantity");
        #4..16
          "Description 2" := ItemVariant."Description 2";
        end;

        GetDefaultBin;
        "Unit Cost" := GetUnitCost;
        "Cost Amount" := CalcCostAmount(Quantity,"Unit Cost");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..19
        // << DITW110.00.11 SFI 31/08/2017 BL#30569
        if (Type = Type::Item) then begin
          GetItem();
          Item.BlockedSKU("Location Code","Variant Code",true);
        end;
        // >> DITW110.00.11 SFI BL#30569
        GetDefaultBin;
        "Unit Cost" := GetUnitCost;
        // <<DITW18.00.06 DDR 05/11/2015 DIT-770 #1499
        "Item Charge Value" := "Unit Cost";
        // >>DITW18.00.06 DDR DIT-770 #1499
        "Cost Amount" := CalcCostAmount(Quantity,"Unit Cost");
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Location Code"(Field 20).OnValidate". Please convert manually.

        //trigger (Variable: Location)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Location Code"(Field 20).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Type,Type::Item);
        WhseValidateSourceLine.AssemblyLineVerifyChange(Rec,xRec);
        CheckItemAvailable(FIELDNO("Location Code"));
        VerifyReservationChange(Rec,xRec);
        TestStatusOpen;

        GetDefaultBin;

        "Unit Cost" := GetUnitCost;
        "Cost Amount" := CalcCostAmount(Quantity,"Unit Cost");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..5
        // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192

        if ("Responsibility Center" = xRec."Responsibility Center") and ("Location Code" <> xRec."Location Code") and
          ("Location Code" <> '')
        then begin
          GetLocation(Location,"Location Code");
          VALIDATE("Responsibility Center",UserSetupMgt.GetFirstRespCenter(4,Location."Physical Location Group Code","Location Code"));
        end;
        if (("Responsibility Center" = xRec."Responsibility Center") and ("Location Code" <> '')) or
          ("Responsibility Center" <> xRec."Responsibility Center") then
          if not UserSetupMgt.CheckLocation(4,"Location Code","Responsibility Center") then
            ERROR(
              Text2014414,
              Location.TABLECAPTION,"Location Code",
              RespCenter.TABLECAPTION,UserSetupMgt.GetAssemblyFilter);

        GetHeader;
        if "Location Code" <> '' then begin
          Location.GET("Location Code");
          if Location."Physical Location Group Code" <> "Physical Location Group Code" then
            "Physical Location Group Code" := Location."Physical Location Group Code";
        end else
          if xRec."Physical Location Group Code" = "Physical Location Group Code" then

            "Physical Location Group Code" := AssemblyHeader."Physical Location Group Code";
        if xRec."Physical Location Group Code" = "Physical Location Group Code" then
          VALIDATE("Physical Location Group Code");

        // >>DITW18.00.06 MSF DIT-770 #1192
        "Zone Code" := '';//HEI.01 PRDGAP024 single
        #7..9
        // <<DITW18.00.06 DDR 05/11/2015 DIT-770 #1499
        "Item Charge Value" := "Unit Cost";
        // >>DITW18.00.06 DDR DIT-770 #1499
        "Cost Amount" := CalcCostAmount(Quantity,"Unit Cost");

        // << DITW110.00.11 SFI 31/08/2017 BL#30569
        if (Type = Type::Item) then begin
          GetItem();
          Item.BlockedSKU("Location Code","Variant Code",true);
        end;
        // >> DITW110.00.11 SFI BL#30569
        // <<DITW17.10.05 DDR 21/08/2014 DIT-770 #675
        if Type = Type::Item then begin
          GetLocation(Location,"Location Code");
          if Location.Code <> '' then begin
            "Physical Location Group Code" := Location."Physical Location Group Code";
            "Location Group Code" := Location."Location Group Code";
          end else begin
            "Location Group Code" := '';
          end;
        end else begin
          "Physical Location Group Code" := '';
          "Location Group Code" := '';
        end;

        if (Type = Type::Item) and ((Quantity <> 0) or (xRec.Quantity <> Quantity)) then
          InsertCharges4(FIELDNO("Location Code"));
        // >>DITW17.10.05 DDR DIT-770 #675
        */
        //end;


        //Unsupported feature: CodeModification on ""Bin Code"(Field 23).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Type,Type::Item);
        if Quantity > 0 then
          BinCode := WMSManagement.BinContentLookUp("Location Code","No.","Variant Code",'',"Bin Code")
        else
          BinCode := WMSManagement.BinLookUp("Location Code","No.","Variant Code",'');

        if BinCode <> '' then
          VALIDATE("Bin Code",BinCode);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Type,Type::Item);
        if Quantity > 0 then
          //HEI.01 PRDGAP024 delete BinCode := WMSManagement.BinContentLookUp("Location Code","No.","Variant Code",'',"Bin Code")
          BinCode := WMSManagement.BinContentLookUp("Location Code","No.","Variant Code","Zone Code","Bin Code")//HEI.01 PRDGAP024 NEW LINE
        else
          //HEI.01 PRDGAP024 delete BinCode := WMSManagement.BinLookUp("Location Code","No.","Variant Code",'');
          BinCode := WMSManagement.BinLookUp("Location Code","No.","Variant Code","Zone Code");//HEI.01 PRDGAP024 NEW LINE
        if BinCode <> '' then
          VALIDATE("Bin Code",BinCode);
        */
        //end;


        //Unsupported feature: CodeModification on ""Bin Code"(Field 23).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        TESTFIELD(Type,Type::Item);
        if "Bin Code" <> '' then begin
        #4..8
            "Bin Code",0);
          CheckBin;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..11

        // <<DITW17.10.05 DDR 21/08/2014 DIT-770 #675
        if (Type = Type::Item) and ((Quantity <> 0) or (xRec.Quantity <> Quantity)) then
          UpdateCharges(FIELDNO("Bin Code"));
        // >>DITW17.10.05 DDR DIT-770 #675
        */
        //end;


        //Unsupported feature: CodeInsertion on "Quantity(Field 40).OnValidate". Please convert manually.

        //trigger (Variable: AssemblyLineItem)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on "Quantity(Field 40).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WhseValidateSourceLine.AssemblyLineVerifyChange(Rec,xRec);

        RoundQty(Quantity);
        "Quantity (Base)" := CalcBaseQty(Quantity);
        InitRemainingQty;
        InitQtyToConsume;

        CheckItemAvailable(FIELDNO(Quantity));
        VerifyReservationQuantity(Rec,xRec);

        "Cost Amount" := CalcCostAmount(Quantity,"Unit Cost");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4

        // <<DITW17.10.05 DDR 21/08/2014 DIT-770 #675
        if (Quantity <> 1) and (CurrFieldNo <> 0) then
          case "Extra Charge Type" of
            "Extra Charge Type"::"Fixed Amount":
              TESTFIELD(Quantity, 1);
            "Extra Charge Type"::VolumeHL:
              begin
                if "Attached to Line No." <> 0 then begin
                  AssemblyLineItem.GET("Document Type","Document No.","Attached to Line No.");
                  AssemblyLineItem.TESTFIELD("Unit Volume HL");
                  TESTFIELD(Quantity, AssemblyLineItem."Unit Volume HL");
                end;
              end;
          end;

        if (CurrFieldNo = FIELDNO(Quantity)) and
           (xRec.Quantity <> Quantity) and
           (Quantity <> 0) and
           ("Extra Charge Type" <> "Extra Charge Type"::" ")
        then begin
          if "Extra Charge Type" <> "Extra Charge Type"::"Fixed Amount" then
            TESTFIELD(Quantity, xRec.Quantity);
        end;
        // >>DITW17.10.05 DDR DIT-770 #675

        #5..7
        // <<DITW17.10.05 DDR 21/08/2014 DIT-770 #675
        if Type <> Type::"Charge (Item)" then begin
        // >>DITW17.10.05 DDR DIT-770 #675
          CheckItemAvailable(FIELDNO(Quantity));
          VerifyReservationQuantity(Rec,xRec);
        end;

        // <<DITW17.10.05 DDR 21/08/2014 DIT-770 #675
        if (Type = Type::Item) and (Quantity = 0) and (xRec.Quantity <> Quantity) and
          ("Consumed Quantity" = 0) and ("Qty. Picked" = 0) and
          ("Appl.-to Item Entry" = 0) and ("Appl.-from Item Entry" = 0) and
          (CurrFieldNo <> 0) and ("Line No." <> 0)
        then begin
          CLEAR(TaxAssemblyMgt);
          DeleteAllChargeLines(true);
          if "Item Charge Value" <> "Unit Cost" then
            VALIDATE("Unit Cost","Item Charge Value");
        end;
        // >>DITW17.10.05 DDR DIT-770 #675

        "Cost Amount" := CalcCostAmount(Quantity,"Unit Cost");

        // <<DITW17.10.05 DDR 21/08/2014 DIT-770 #675
        if (Type = Type::Item) and (Quantity <> 0) and (xRec.Quantity <> Quantity) and
          ("Item Charge Type" = "Item Charge Type"::" ")
        then begin
          if CurrFieldNo = FIELDNO("Quantity per") then
            InsertCharges4(FIELDNO("Quantity per"))
          else
            InsertCharges4(FIELDNO(Quantity));
        end;
        // >>DITW17.10.05 DDR DIT-770 #675
        */
        //end;


        //Unsupported feature: CodeModification on ""Quantity to Consume"(Field 46).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WhseValidateSourceLine.AssemblyLineVerifyChange(Rec,xRec);
        RoundQty("Quantity to Consume");
        RoundQty("Remaining Quantity");
        if "Quantity to Consume" > "Remaining Quantity" then
          ERROR(Text003,
            FIELDCAPTION("Quantity to Consume"),FIELDCAPTION("Remaining Quantity"),"Remaining Quantity");

        VALIDATE("Quantity to Consume (Base)",CalcBaseQty("Quantity to Consume"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..8

        // <<DITW17.10.05 DDR 21/08/2014 DIT-770 #675
        if (Type = Type::Item) and ("Quantity to Consume" <> xRec."Quantity to Consume") and
          (CurrFieldNo <> FIELDNO(Quantity))
        then
          UpdateCharges(FIELDNO("Quantity to Consume"));
        // >>DITW17.10.05 DDR DIT-770 #675
        */
        //end;


        //Unsupported feature: CodeModification on ""Gen. Prod. Posting Group"(Field 63).OnValidate". Please convert manually.

        //trigger  Prod();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        // <<DITW18.00.07 DDR 28/02/2016 DIT-770 #1836
        UpdateCharges(FIELDNO("Gen. Prod. Posting Group"));
        // >>DITW18.00.07 DDR DIT-770 #1836
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit Cost"(Field 65).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("No.");
        GetItemResource;
        if Type = Type::Item then begin
          SkuItemUnitCost := GetUnitCost;
        #5..9
        end;

        "Cost Amount" := CalcCostAmount(Quantity,"Unit Cost");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("No.");

        // <<DITW17.10.05 DDR 21/08/2014 DIT-770 #675
        if ("Extra Charge Type" <> "Extra Charge Type"::Amount) and
           ("Extra Charge Type" <> "Extra Charge Type"::"Fixed Amount") and
           ("Extra Charge Type" <> "Extra Charge Type"::VolumeHL) and
           ("Extra Charge Type" <> "Extra Charge Type"::"Price Item") and
           (CurrFieldNo = FIELDNO("Unit Cost")) and
           "Is Item Charge"
        then
          FIELDERROR("Extra Charge Type");

        if CurrFieldNo = FIELDNO("Unit Cost") then begin
          if not "Is Item Charge" then
            "Item Charge Value" := "Unit Cost"
          else
            UpdateItemChargeValue();

          CheckNoItemChargeInclPrice(FIELDCAPTION("Unit Cost"));
        end;
        // >>DITW17.10.05 DDR DIT-770 #675

        #2..12

        // <<DITW17.10.05 DDR 21/08/2014 DIT-770 #675
        if (Type = Type::Item) and ("Unit Cost" <> xRec."Unit Cost") then
          UpdateCharges(FIELDNO("Unit Cost"));

        if ("Item Charge Type" = "Item Charge Type"::Tax) and ("Unit Cost" <> xRec."Unit Cost") then
          CalcBackUnitPriceItem();
        // >>DITW17.10.05 DDR DIT-770 #675
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit of Measure Code"(Field 80).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WhseValidateSourceLine.AssemblyLineVerifyChange(Rec,xRec);
        TestStatusOpen;

        GetItemResource;
        case Type of
          Type::Item:
            "Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");
          Type::Resource:
            "Qty. per Unit of Measure" := UOMMgt.GetResQtyPerUnitOfMeasure(Resource,"Unit of Measure Code");
          else
            "Qty. per Unit of Measure" := 1;
        end;

        CheckItemAvailable(FIELDNO("Unit of Measure Code"));
        "Unit Cost" := GetUnitCost;
        VALIDATE(Quantity);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        // <<DITW17.10.05 DDR 21/08/2014 DIT-770 #675
        if (Type = Type::"Charge (Item)") and not HideValidationDialog then
          ERROR(Text2013662,FIELDCAPTION("Unit of Measure Code"),FIELDCAPTION("Item Charge Type"));
        // >>DITW17.10.05 DDR DIT-770 #675

        #4..6
            begin
              "Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");
              // <<DITW17.10.05 DDR 21/08/2014 DIT-770 #675
              "Unit Volume HL" := Item."Unit Volume HL" * "Qty. per Unit of Measure";
              // >>DITW17.10.05 DDR DIT-770 #675
            end;
          Type::Resource:
            "Qty. per Unit of Measure" := UOMMgt.GetResQtyPerUnitOfMeasure(Resource,"Unit of Measure Code");
          // <<DITW17.10.05 DDR 21/08/2014 DIT-770 #675
          Type::"Charge (Item)":
            "Qty. per Unit of Measure" := 1;
          // >>DITW17.10.05 DDR DIT-770 #675
        #10..15
        // <<DITW18.00.06 DDR 05/11/2015 DIT-770 #1499
        "Item Charge Value" := "Unit Cost";
        // >>DITW18.00.06 DDR DIT-770 #1499
        VALIDATE(Quantity);

        // <<DITW17.10.05 DDR 21/08/2014 DIT-770 #675
        if (Type = Type::Item) and ((Quantity <> 0) or (xRec.Quantity <> Quantity)) then
          InsertCharges4(FIELDNO("Unit of Measure Code"));
        // >>DITW17.10.05 DDR DIT-770 #675
        */
        //end;
        field(50000; "Zone Code FND"; Code[10])
        {
            Caption = 'Zone Code';
            Description = 'PRDGAP024';
            TableRelation = Zone.Code where("Location Code" = FIELD("Location Code"));

            trigger OnValidate();
            begin
                //HEI.01 PRDGAP024>>
                VALIDATE("Bin Code", '');
                if "Zone Code FND" <> '' then begin
                    WHSUTILS.CheckUserAuthorizedinZone("Location Code", "Zone Code FND");

                end;
                //HEI.01 PRDGAP024<<
            end;
        }
        //HEI.05>>
        field(50001; "Unit Volume HL FND"; Decimal)
        {
            Caption = 'Unit Volume HL';
            Description = 'HEI.05';
        }
        //HEI.05<<

        //BC UPGRADE PATHAA02>>
        // field(2013660; "Extra Charge Type"; Option)
        // {
        //     CaptionML = ENU = 'Extra Charge Type',
        //                 FRA = 'Type frais extra';
        //     Description = 'DITW17.10.05 DIT-770 #675';
        //     OptionCaptionML = ENU = ' ,Amount,Price %,Amount %,Fixed Amount,Volume /Unit,Weight,Cubage,Distance,Price Item',
        //                       FRA = ' ,Montant,Prix %,Montant %,Montant Fixe,Volume /Unit,Poids,Cubage,Distance,Prix Article';
        //     OptionMembers = " ",Amount,"Price %","Amount %","Fixed Amount",VolumeHL,Weight,Cubage,Distance,"Price Item";
        // }
        // field(2013661; "Item Charge Value"; Decimal)
        // {
        //     AutoFormatExpression = GetAutoformatRoundingType('');
        //     AutoFormatType = 2;
        //     CaptionML = ENU = 'Item Charge Value',
        //                 FRA = 'Valeur frais annexes';
        //     Description = 'DITW17.10.05 DIT-770 #675';
        // }
        // field(2013662; "Is Item Charge"; Boolean)
        // {
        //     CaptionML = ENU = 'Is Item Charge',
        //                 FRA = 'Est frais annexes';
        //     Description = 'DITW17.10.05 DIT-770 #675';
        // }
        // field(2013663; "Item Charge Incl. Price"; Boolean)
        // {
        //     CaptionML = ENU = 'Item Charge Incl. Price',
        //                 FRA = 'Frais annexe inclus prix';
        //     Description = 'DITW17.10.05 DIT-770 #675';
        // }
        // field(2013666; "Customer DTax Group Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Customer Tax Group Code',
        //                 FRA = 'Code groupe taxe client';
        //     Description = 'DITW17.10.05 DIT-770 #675,HEI.03';
        //     TableRelation = "Drink Tax Group".Code where("Source Type" = CONST(Customer));

        //     trigger OnValidate();
        //     begin
        //         //UpdateAADInfo();
        //     end;
        // }
        // field(2013667; "Item DTax Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Charge Tax Group Code',
        //                 FRA = 'Code groupe frais annexes taxe';
        //     Description = 'DITW17.10.05 DIT-770 #675';
        //     TableRelation = "Drink Tax Group".Code where("Source Type" = CONST(Item));
        // }
        // field(2013694; "Opposite Amount Sign"; Boolean)
        // {
        //     CaptionML = ENU = 'Opposite Amount Sign',
        //                 FRA = 'Signe opposé montant';
        //     Description = 'DITW17.10.05 DIT-770 #675';
        // }
        // field(2013695; "Item Charge Type"; Option)
        // {
        //     CaptionML = ENU = 'Item Charge Type',
        //                 FRA = 'Type frais annexes';
        //     Description = 'DITW17.10.05 DIT-770 #675';
        //     OptionCaptionML = ENU = ' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
        //                       FRA = ' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
        //     OptionMembers = " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        // }
        // field(2013696; "Location Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Location Tax Group Code',
        //                 FRA = 'Code groupe magasin taxe';
        //     Description = 'DITW17.10.05 DIT-770 #675';
        //     TableRelation = "Location Group";
        // }
        // field(2013708; "Due Tax"; Boolean)
        // {
        //     CaptionML = ENU = 'Due Tax',
        //                 FRA = 'Taxe due';
        //     Description = 'DITW17.10.05 DIT-770 #675';

        //     trigger OnValidate();
        //     begin
        //         TESTFIELD("Item Charge Type", "Item Charge Type"::Tax);
        //         TestDutySuspendMandatory();
        //         // <<DITW17.10.05 MSF 20/11/2014 DIT-770 #701
        //         TestTaxDueMandatory
        //         // >>DITW17.10.05 MSF 20/11/2014 DIT-770 #701
        //     end;
        // }
        // field(2013711; "Initial Entry Due Date"; Date)
        // {
        //     CaptionML = ENU = 'Initial Entry Due Date',
        //                 FRA = 'Date d''échéance écr. initiale';
        //     Description = 'DITW17.10.05 DIT-770 #675';
        // }
        // field(2013715; "Tax Formula"; Code[80])
        // {
        //     CaptionML = ENU = 'Tax Formula',
        //                 FRA = 'Formule taxe';
        //     Description = 'DITW17.10.05 DIT-770 #675';
        // }
        // field(2013722; "Duty Suspended"; Boolean)
        // {
        //     CaptionML = ENU = 'Duty Suspended',
        //                 FRA = 'Taxe en suspension';
        //     Description = 'DITW17.10.05 DIT-770 #675';

        //     trigger OnValidate();
        //     begin
        //         TESTFIELD("Item Charge Type", "Item Charge Type"::Tax);
        //         TestDutySuspendMandatory();
        //     end;
        // }
        // field(2013726; "Company Tax Registration No."; Text[20])
        // {
        //     CaptionML = ENU = 'Company Tax Registration No.',
        //                 FRA = 'N° identif. accise société';
        //     Description = 'DITW17.10.05 DIT-770 #675';
        // }
        // field(2013729; "Tariff No."; Code[10])
        // {
        //     CaptionML = ENU = 'Tariff No.',
        //                 FRA = 'Nomenclature produits';
        //     Description = 'DITW17.10.05 DIT-770 #675';
        //     TableRelation = "Tariff Number";
        // }
        // field(2013767; "Unit Volume HL"; Decimal)
        // {
        //     CaptionClass = GetUomCaptionClass(FIELDNO("Unit Volume HL"));
        //     CaptionML = ENU = 'Unit Volume',
        //                 FRA = 'Volume unitaire';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW17.10.05 DIT-770 #675';
        //     MinValue = 0;

        //     trigger OnValidate();
        //     begin
        //         UpdateCharges(FIELDNO("Unit Volume HL"));
        //     end;
        // }
        // field(2014094; "Physical Location Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Physical Location Group Code',
        //                 FRA = 'Code groupe magasin réel';
        //     Description = 'DITW17.10.05 DIT-770 #675';
        //     TableRelation = "Physical Location Group" where(Code = FIELD("Phys. Location Table Filter"));

        //     trigger OnValidate();
        //     var
        //         Location: Record Location;
        //     begin
        //         InvSetup.GET;

        //         if xRec."Physical Location Group Code" <> "Physical Location Group Code" then begin
        //             TESTFIELD("No.");
        //             if "Physical Location Group Code" <> '' then
        //                 if InvSetup."Location Mandatory" then
        //                     TESTFIELD("Location Code");
        //         end;
        //         // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
        //         if ("Responsibility Center" = xRec."Responsibility Center") and
        //           ("Physical Location Group Code" <> xRec."Physical Location Group Code") and
        //           ("Physical Location Group Code" <> '')
        //         then
        //             VALIDATE("Responsibility Center", UserSetupMgt.GetFirstRespCenter(4, "Physical Location Group Code", ''));

        //         if xRec."Physical Location Group Code" <> "Physical Location Group Code" then
        //             if not UserSetupMgt.CheckPhysLocation(4, "Physical Location Group Code", "Responsibility Center") then
        //                 ERROR(
        //                   Text2014414,
        //                   PhysLocationGr.TABLECAPTION, "Physical Location Group Code",
        //                   RespCenter.TABLECAPTION, UserSetupMgt.GetAssemblyFilter);
        //         if (xRec."Physical Location Group Code" <> "Physical Location Group Code") or (CurrFieldNo = 0) then begin
        //             GetLocation(Location, "Location Code");
        //             if (Location."Physical Location Group Code" <> "Physical Location Group Code") then begin
        //                 if ((CurrFieldNo <> FIELDNO("Location Code")) and (xRec."Responsibility Center" = "Responsibility Center")) then
        //                     VALIDATE("Location Code", '')
        //                 else
        //                     "Location Code" := '';
        //             end;
        //         end;
        //         //GetLocation(Location,"Location Code");
        //         // <<DITW17.10.05 DDR 21/08/2014 DIT-770 #675
        //         //IF Location."Physical Location Group Code" <> "Physical Location Group Code" THEN
        //         // VALIDATE("Location Code",'');
        //         // >>DITW17.10.05 DDR DIT-770 #675
        //         // >>DITW18.00.06 DDR DIT-770 #1192
        //     end;
        // }
        // field(2014271; "Company Tax Warehouse Ref."; Text[20])
        // {
        //     CaptionML = ENU = 'Company Tax Warehouse Reference',
        //                 FRA = 'Entrepôt fiscal de référence société';
        //     Description = 'DITW17.10.05 DIT-770 #675';
        // }
        // field(2014410; Collapse; Boolean)
        // {
        //     CaptionML = ENU = 'Collapse',
        //                 FRA = 'Réduire';
        //     Description = 'DITW17.10.05 DIT-770 #675';

        //     trigger OnValidate();
        //     begin
        //         if Collapse and
        //           ("Attached to Line No." = 0)
        //         then
        //             TESTFIELD(Collapse, false);
        //     end;
        // }
        // field(2014412; "Resp. Center Table Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Resp. Center Table Filter',
        //                 FRA = 'Filtre Centre de gestion (table)';
        //     Description = 'DITW18.00.06 MSF 26/02/2015 DIT-770 #1192';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Responsibility Center";
        // }
        // field(2014413; "Phys. Location Table Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Phys. Location Table Filter',
        //                 FRA = 'Filtre groupe magasin réel (table)';
        //     Description = 'DITW18.00.06 MSF 26/02/2015 DIT-770 #1192';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Physical Location Group";
        // }
        // field(2014414; "Location Table Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Location Table Filter',
        //                 FRA = 'Filtre Magasin (table)';
        //     Description = 'DITW18.00.06 MSF 26/02/2015 DIT-770 #1192';
        //     FieldClass = FlowFilter;
        //     TableRelation = Location;
        // }
        // field(2014415; "Responsibility Center"; Code[10])
        // {
        //     CaptionML = ENU = 'Responsibility Center',
        //                 FRA = 'Centre de gestion';
        //     Description = 'DITW18.00.06 MSF 26/02/2015 DIT-770 #1192';
        //     TableRelation = "Responsibility Center" where(Code = FIELD("Resp. Center Table Filter"));

        //     trigger OnValidate();
        //     var
        //         LocationCode: Code[20];
        //     begin
        //         // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
        //         if not UserSetupMgt.CheckRespCenter(4, "Responsibility Center") then
        //             ERROR(
        //               Text2014410,
        //               RespCenter.TABLECAPTION, UserSetupMgt.GetAssemblyFilter);

        //         if (CurrFieldNo <> FIELDNO("Location Code")) and
        //           (CurrFieldNo <> FIELDNO("Physical Location Group Code")) and
        //           (xRec."Physical Location Group Code" = "Physical Location Group Code") and
        //           (xRec."Location Code" = "Location Code")
        //         then begin
        //             SETRANGE("Phys. Location Table Filter");
        //             SETRANGE("Location Table Filter");
        //             VALIDATE("Physical Location Group Code", UserSetupMgt.GetphysicalLocation(4, '', "Responsibility Center"));
        //             LocationCode := UserSetupMgt.GetLocation(4, '', "Responsibility Center");
        //             if (LocationCode <> '') or ("Physical Location Group Code" = '') then
        //                 VALIDATE("Location Code", LocationCode);
        //         end;
        //         GetHeader;
        //         //<<DITW18.00.06 AKH 04/03/2015 DIT-770 #1197
        //         //CreateDim(DATABASE::Item,"No.",AssemblyHeader."Dimension Set ID");
        //         CreateDim(DATABASE::Item, "No.", DATABASE::"Responsibility Center", "Responsibility Center", AssemblyHeader."Dimension Set ID");
        //         //>>DITW18.00.06 AKH 04/03/2015 DIT-770 #1197
        //         // >>DITW18.00.06 MSF DIT-770 #1192
        //     end;
        // }
        // field(2014440; "Attached to Line No."; Integer)
        // {
        //     CaptionML = ENU = 'Attached to Line No.',
        //                 FRA = 'Attaché à la ligne n°';
        //     Description = 'DITW17.10.05 DIT-770 #675';
        //     Editable = false;
        //     TableRelation = "Assembly Line"."Line No." where("Document Type" = FIELD("Document Type"),
        //                                                       "Document No." = FIELD("Document No."));
        // }
        // field(2014444; "Last Price Calculated Date"; Date)
        // {
        //     CaptionML = ENU = 'Last Price Calculated Date',
        //                 FRA = 'Dernière date prix calculé';
        //     Description = 'DITW17.10.05 DIT-770 #675';
        // }
        // field(2014500; "Has Item Charge"; Boolean)
        // {
        //     CalcFormula = Exist("Assembly Line" where("Document Type" = FIELD("Document Type"),
        //                                                "Document No." = FIELD("Document No."),
        //                                                "Attached to Line No." = FIELD("Line No.")));
        //     CaptionML = ENU = 'Has Item Charge',
        //                 FRA = 'A des Frais Annexes';
        //     Description = 'DITW17.10.05 DIT-770 #675';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2029610; "Cross-Reference No."; Code[20])
        // {
        //     CaptionML = ENU = 'Cross-Reference No.',
        //                 FRA = 'Référence externe';
        //     Description = 'FINXL8.00.001';

        //     trigger OnLookup();
        //     begin
        //         //<<FINXL8.00.001 BSA 02/06/2015 #178
        //         if recFinXLSetup.READPERMISSION then
        //             fctLookupCrossReference();
        //         //>>FINXL8.00.001 BSA 02/06/2015 #178
        //     end;

        //     trigger OnValidate();
        //     begin
        //         //<<FINXL8.00.001 BSA 02/06/2015 #178
        //         if recFinXLSetup.READPERMISSION then
        //             fctValidateCrossReference;
        //         //>>FINXL8.00.001 BSA 02/06/2015 #178
        //     end;
        // }
        //BC UPGRADE PATHAA02<<
    }
    keys
    {
        //BC UPGRADE PATHAA02-DIT Field>>
        // key(Key1; "Document Type", "Document No.", "Attached to Line No.")
        // {
        // }     
        //BC UPGRADE PATHAA02-DIT<<
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TestStatusOpen;
    WhseValidateSourceLine.AssemblyLineDelete(Rec);
    WhseAssemblyRelease.DeleteLine(Rec);
    AssemblyLineReserve.DeleteLine(Rec);
    CALCFIELDS("Reserved Qty. (Base)");
    TESTFIELD("Reserved Qty. (Base)",0);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    // <<DITW17.10.05 DDR 21/08/2014 DIT-770 #675
    DeleteAllChargeLines(true);
    // >>DITW17.10.05 DDR DIT-770 #675
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        AssemblyLineItem: Record "Assembly Line";
        Bin2: Record Bin;
        Location: Record Location;
        //CommonITemChrgMgt: Codeunit "Common Item Charges Mgt."; //BC UPGRADE PATHAA02-DIT
        Zone: Record Zone;
        TempCurrFieldNo: Integer;


    //Unsupported feature: PropertyModification on "Text001(Variable 1055)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=Automatic reservation is not possible.\Do you want to reserve items manually?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=Automatic reservation is not possible.\Do you want to reserve items manually?;FRA=La réservation automatique n'est pas possible.\Souhaitez-vous réserver les articles manuellement ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1017)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=You cannot rename an %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=You cannot rename an %1.;FRA=Vous ne pouvez pas renommer un(e) %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1012)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=%1 cannot be higher than the %2, which is %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=%1 cannot be higher than the %2, which is %3.;FRA=%1 ne peut pas être supérieur à %2, qui est %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text029(Variable 1010)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text029 : @@@=starts with "Quantity";ENU=must be positive;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text029 : @@@=starts with "Quantity";ENU=must be positive;FRA=doit être de signe positif;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text042(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text042 : ENU=When posting the Applied to Ledger Entry, %1 will be opened first.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text042 : ENU=When posting the Applied to Ledger Entry, %1 will be opened first.;FRA=Lors de la validation, l'écriture comptable lettrée %1 s'ouvre d'abord.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text99000002(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text99000002 : ENU=You cannot change %1 when %2 is '%3'.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text99000002 : ENU=You cannot change %1 when %2 is '%3'.;FRA=Vous ne pouvez pas modifier %1 si %2 est « %3 ».;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text049(Variable 1019)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text049 : ENU=%1 cannot be later than %2 because the %3 is set to %4.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text049 : ENU=%1 cannot be later than %2 because the %3 is set to %4.;FRA=%1 ne peut pas être postérieur à %2 car le %3 est défini sur %4.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text050(Variable 1020)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text050 : ENU=Due Date %1 is before work date %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text050 : ENU=Due Date %1 is before work date %2.;FRA=La date d'échéance %1 est antérieure à la date de travail %2.;
    //Variable type has not been exported.

    var
        Text020: TextConst ENU = 'A "%1" Assembly Order cannot be modified.', FRA = 'Un O.F. terminé ne peut pas être modifié.';

    var
        ATOLink: Record "Assemble-to-Order Link";
        Currency: Record Currency;
        SaveCurrency: Record Currency;
        InvSetup: Record "Inventory Setup";
        ItemCharge: Record "Item Charge";
        //UserSetupMgt: Codeunit "User Setup Management"; 
        RespCenter: Record "Responsibility Center";
        SalesSetup: Record "Sales & Receivables Setup";
        //TaxAssemblyMgt: Codeunit "Tax Assembly Charges Mgt."; //BC UPGRADE PATHAA02-DIT
        //CustDrinkTaxGr: Record "Drink Tax Group";//BC UPGRADE PATHAA02-DIT
        //ItemDrinkTaxGr: Record "Drink Tax Group";//BC UPGRADE PATHAA02-DIT
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        //recFinXLSetup: Record "Finance XL Setup"; //BC UPGRADE PATHAA02-DIT
        WHSUTILS: Codeunit "WHS-UTILS";
        blnValidateCrossRef: Boolean;
        //LocationGr: Record "Location Group";//BC UPGRADE PATHAA02 DIT
        HideValidationDialog: Boolean;

        // PhysLocationGr: Record "Physical Location Group"; //BC UPGRADE PATHAA02-DIT
        ItemLocationCode: Code[20];
        //CommonItemChrgMgt: Codeunit "Common Item Charges Mgt."; //BC UPGRADE PATHAA02-DIT
        NewBinCode: Code[20];
        Text2013660: TextConst ENU = 'cannot ne greater than %1.', FRA = 'Ne peut pas être supérieure à %1';
        Text2013661: TextConst ENU = 'cannot be lower than %1.', FRA = 'Ne peut pas être inferieur à %1';
        Text2013662: TextConst ENU = 'You cannot change %1 because the value is automatically calculated with %2.', FRA = 'Vous ne pouvez pas modifier %1 car la valeur est calculé automatiquement avec %2.';
        Text2013663: TextConst ENU = 'At least one item charge tax line must exist with the %1 %2.', FRA = 'Il doit exister au moins une ligne de type taxe avec le %1 %2.';
        Text2013664: TextConst ENU = 'You must specify %1 in %2 or %3 or %4 when %5 %6.', FRA = 'Vous devez spécifier %1 dans %2 ou %3 ou %4 quand %5 %6.';
        Text2014410: TextConst ENU = 'The %1 combination ''%2'' ''%3'' does not exist for %4 %5.', FRA = 'La %1 combinaison %2 %3 n''existe pas pour %4 %5.';
        Text2014411: TextConst ENU = 'Do you want to insert the item charges for all lines?', FRA = 'Souhaitez-vous insérer les frais annexes pour toutes les lignes?';
        Text2014412: TextConst ENU = 'Do you want to replace the existing %1 %2 using the item selection?', FRA = 'Souhaitez-vous remplacer l''actuel %1 %2 par les articles sélectionnés?';
        Text2014413: TextConst ENU = 'Your identification is set up to process from %1 %2 only.', FRA = 'Le paramétrage de votre code utilisateur ne vous permet de travailler que sur %1 %2.';
        Text2014414: TextConst ENU = 'You cannot use the %1 %2 because your identification is set up to process from %3 %4 only.', FRA = 'Vous ne pouvez pas utiliser le %1 %2 parce que votre identification est configurée pour traiter de %3 %4 seulement.';
}

