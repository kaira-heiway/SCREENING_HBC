tableextension 50172 AssemblyHeaderExtFND extends "Assembly Header"
{
    // version NAVW110.0.00.15052,DITW110.00.09,HEI.05
    //HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #added fields Zone Code and validation code

    // HEI.02 FDD-GAPID031 IBM.PATHAA02 17.08.2017
    //   # Description made non-Editable

    // HEI.03 FDD-SLSGAP001 IBM NASTAA02 08.09.2017 # MDM Customer Card
    //   # Increased "Customer DTax Group Code" field length from 10 to 20 characters
    // HEI.04 CHG2174146 SAHAL01 20.02.2023 Assembly Order Outbound and Inbound interfaces HeiLite -- Astro WMS
    //   # Created New Fields: 50001 - Assembly ORDER Interface Astro
    //                         50002 - Parked ORDER Astro
    //                         50003 - Last Parked Date ORDER Astro
    //                         50004 - Last Parked Time ORDER Astro
    //   # Added Code to restrict modification after Parked the Assembly Order for Astro.
    // HEI.05 CHG2174146 SAHAL01 23.02.2023 Assembly Order Outbound and Inbound interfaces HeiLite -- Astro WMS
    //   # Created New Fields: 50007 - Asmbl LINEPICK Interface Astro
    //                         50008 - Parked LINEPICK Astro
    //                         50009 - Last Parked Date LINEPICKAstro
    //                         50010 - Last Parked Time LINEPICKAstro
    //                         50011 - Posted LINEPICK Astro
    //                         50014 - Asmbly OUTPUT Interface Astro
    //                         50015 - Parked OUTPUT Astro
    //                         50016 - Last Parked Date OUTPUT Astro
    //                         50017 - Last Parked Time OUTPUT Astro
    //                         50018 - Posted OUTPUT Astro
    //**********************************************************************************************6*****************
    //BC UPGRADE PATHAA02-07.11.25
    //HEI.04 and HEI.05 are Astro fields-commented
    //HEI.01-Need to add Bin Code-Lookup code of table on page
    //HEI.02-make "Description" non editable-Cannot be changed on Table, need to handle on pages.
    //HEI.03 -DIT-commented
    //**********************************************
    //HEI.06 PATHAA02 01.04.26  #FDD-Unit Volume HL-Assemnly Orders [FDD PID-750, PID-826, PID-76, PID-801, FDD DtW 017, IBM GAP DTW 76]
    //# Added new Field -"Unit Volume HL"
    //# Code written on "Item No."-OnAfterValidate to flow value from Item to this field.

    fields
    {
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            //OptionCaptionML = ENU = 'Quote,Order,,,Blanket Order', FRA = 'Devis,Commande,,,Commande ouverte';
        }
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Description';
            //Editable = false; //BC UPGRADE -HEI>02

            //Unsupported feature: Change Description on "Description(Field 3)". Please convert manually.


            //Unsupported feature: Change Editable on "Description(Field 3)". Please convert manually.

        }
        modify("Search Description")
        {
            CaptionML = ENU = 'Search Description', FRA = 'Description de recherche';
        }
        modify("Description 2")
        {
            CaptionML = ENU = 'Description 2', FRA = 'Description 2';
        }
        modify("Creation Date")
        {
            CaptionML = ENU = 'Creation Date', FRA = 'Date création';
        }
        modify("Last Date Modified")
        {
            CaptionML = ENU = 'Last Date Modified', FRA = 'Date dern. modification';
        }
        modify("Item No.")
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';

            //HEI.06>>
            trigger OnAfterValidate()
            var
                item: Record Item;
            begin
                IF item.get("Item No.") THEN
                    "Unit Volumne HL FND" := Item."Unit Volume";
            end;
            //HEI.06<<

        }
        modify("Variant Code")
        {
            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify("Inventory Posting Group")
        {
            CaptionML = ENU = 'Inventory Posting Group', FRA = 'Groupe compta. stock';
        }
        modify("Gen. Prod. Posting Group")
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group', FRA = 'Groupe compta. produit';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comment', FRA = 'Commentaire';
        }
        modify("Location Code")
        {

            //Unsupported feature: Change TableRelation on ""Location Code"(Field 20)". Please convert manually.

            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';

            //Unsupported feature: Change Description on ""Location Code"(Field 20)". Please convert manually.

        }
        modify("Shortcut Dimension 1 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 2 Code', FRA = 'Code raccourci axe 2';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Due Date")
        {
            CaptionML = ENU = 'Due Date', FRA = 'Date d''échéance';
        }
        modify("Starting Date")
        {
            CaptionML = ENU = 'Starting Date', FRA = 'Date début';
        }
        modify("Ending Date")
        {
            CaptionML = ENU = 'Ending Date', FRA = 'Date fin';
        }
        modify("Bin Code")
        {
            //Unsupported feature: Change TableRelation on ""Bin Code"(Field 33)". Please convert manually.

            CaptionML = ENU = 'Bin Code', FRA = 'Code emplacement';

            //BC UPGRADE PATHAA02-HEI.01>>       Need to add Bin Code-Lookup code of table on page     
            // trigger OnLookup(): Boolean
            // var
            //     myInt: Integer;
            //     Bin: Record Bin;
            //     BinCode: Code[20];
            //     WMSManagement: Codeunit "WMS Management";
            // begin
            //     IF Quantity < 0 THEN
            //         //HEI.01 PRDGAP024 delete BinCode := WMSManagement.BinContentLookUp("Location Code","Item No.","Variant Code",'',"Bin Code")
            //         BinCode := WMSManagement.BinContentLookUp("Location Code", "Item No.", "Variant Code", "Zone Code", "Bin Code")//HEI.01 PRDGAP024 NEW LINE
            //     else
            //         //HEI.01 PRDGAP024 delete BinCode := WMSManagement.BinLookUp("Location Code","Item No.","Variant Code",'');
            //         BinCode := WMSManagement.BinLookUp("Location Code", "Item No.", "Variant Code", "Zone Code");//HEI.01 PRDGAP024 NEW LINE

            //     IF BinCode <> '' THEN
            //         VALIDATE("Bin Code", BinCode);
            // end;
            //BC UPGRADE PATHAA02-HEI.01<<Need to add Bin Code-Lookup code of table on page



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
        modify("Assembled Quantity")
        {
            CaptionML = ENU = 'Assembled Quantity', FRA = 'Quantité assemblée';
        }
        modify("Assembled Quantity (Base)")
        {
            CaptionML = ENU = 'Assembled Quantity (Base)', FRA = 'Quantité assemblée (base)';
        }
        modify("Quantity to Assemble")
        {
            CaptionML = ENU = 'Quantity to Assemble', FRA = 'Quantité à assembler';
        }
        modify("Quantity to Assemble (Base)")
        {
            CaptionML = ENU = 'Quantity to Assemble (Base)', FRA = 'Quantité à assembler (base)';
        }
        modify("Reserved Quantity")
        {
            CaptionML = ENU = 'Reserved Quantity', FRA = 'Quantité réservée';
        }
        modify("Reserved Qty. (Base)")
        {
            CaptionML = ENU = 'Reserved Qty. (Base)', FRA = 'Quantité réservée (base)';
        }
        modify("Planning Flexibility")
        {
            CaptionML = ENU = 'Planning Flexibility', FRA = 'Flexibilité planification';
            //OptionCaptionML = ENU = 'Unlimited,None', FRA = 'Illimitée,Aucune';
        }
        modify("MPS Order")
        {
            CaptionML = ENU = 'MPS Order', FRA = 'Ordre PDP';
        }
        modify("Assemble to Order")
        {
            CaptionML = ENU = 'Assemble to Order', FRA = 'Assemblage à la commande';
        }
        modify("Posting No.")
        {
            CaptionML = ENU = 'Posting No.', FRA = 'N° validation';
        }
        modify("Unit Cost")
        {
            CaptionML = ENU = 'Unit Cost', FRA = 'Coût unitaire';
        }
        modify("Cost Amount")
        {
            CaptionML = ENU = 'Cost Amount', FRA = 'Coût total';
        }
        modify("Rolled-up Assembly Cost")
        {
            CaptionML = ENU = 'Rolled-up Assembly Cost', FRA = 'Coût assemblage multi-niveau';
        }
        modify("Indirect Cost %")
        {
            CaptionML = ENU = 'Indirect Cost %', FRA = '% coût indirect';
        }
        modify("Overhead Rate")
        {
            CaptionML = ENU = 'Overhead Rate', FRA = 'Frais généraux';
        }
        modify("Unit of Measure Code")
        {
            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify("Qty. per Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Unit of Measure', FRA = 'Quantité par unité';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Posting No. Series")
        {
            CaptionML = ENU = 'Posting No. Series', FRA = 'Souches de n° validation';
        }
        modify(Status)
        {
            CaptionML = ENU = 'Status', FRA = 'Statut';
            OptionCaptionML = ENU = 'Open,Released', FRA = 'Ouvert,Lancé';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Assigned User ID")
        {
            CaptionML = ENU = 'Assigned User ID', FRA = 'Code utilisateur affecté';
        }

        //Unsupported feature: CodeInsertion on ""Item No."(Field 10).OnValidate". Please convert manually.

        //trigger (Variable: Location)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Item No."(Field 10).OnValidate". Please convert manually.

        //trigger "(Field 10)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckIsNotAsmToOrder;
        TestStatusOpen;
        SetCurrentFieldNum(FIELDNO("Item No."));
        if "Item No." <> '' then begin
          SetDescriptionsFromItem;
          "Unit Cost" := GetUnitCost;
          "Overhead Rate" := Item."Overhead Rate";
          "Inventory Posting Group" := Item."Inventory Posting Group";
          "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
          "Indirect Cost %" := Item."Indirect Cost %";
          VALIDATE("Unit of Measure Code",Item."Base Unit of Measure");
          SetDim;
          ValidateDates(FIELDNO("Due Date"),true);
          GetDefaultBin;
        end;
        AssemblyLineMgt.UpdateAssemblyLines(Rec,xRec,FIELDNO("Item No."),true,CurrFieldNo,CurrentFieldNum);
        AssemblyHeaderReserve.VerifyChange(Rec,xRec);
        ClearCurrentFieldNum(FIELDNO("Item No."));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckIsNotAsmToOrder;
        TestStatusOpen;
        // <<DITW17.10.05 DDR 05/09/2014 DIT-770 #675
        CLEAR(TaxAssemblyMgt);
        // >>DITW17.10.05 DDR DIT-770 #675
        #3..6
          //"Overhead Rate" := Item."Overhead Rate";   //DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
         //<<DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
          if GetSKU then begin
            "Indirect Cost %" := StockkeepingUnit."Indirect Cost %";
            "Overhead Rate" := StockkeepingUnit."Overhead Rate";
          end else begin
          "Indirect Cost %" := Item."Indirect Cost %";
            "Overhead Rate" := Item."Overhead Rate";
          end;
          //>>DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
          "Inventory Posting Group" := Item."Inventory Posting Group";
          "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
          //"Indirect Cost %" := Item."Indirect Cost %";
          //<<DITW18.00.06 MSF 04/03/2015 DIT-770 #1192
          "Physical Location Group Code" :=UserSetupMgt.GetphysicalLocation(4,'',"Responsibility Center");
          //>>DITW18.00.06 MSF 04/03/2015 DIT-770 #1192
        #11..14
          // <<DITW17.10.05 DDR 05/09/2014 DIT-770 #675
          "Item Charge Value" := "Unit Cost";
          "Unit Volume HL" := Item."Unit Volume HL";
          if Item."Location Code" <> '' then
            "Location Code" := Item."Location Code";
          GetLocation(Location,"Location Code");
          "Item DTax Group Code" := Item."Item DTax Group Code";
          "Unit Volume HL" := Item."Unit Volume HL";
          "Tariff No." := Item."Tariff No.";
          // >>DITW17.10.05 DDR DIT-770 #675
          // << DITW110.00.11 SFI 31/08/2017 BL#30569
          Item.BlockedSKU("Location Code","Variant Code",true);
          // >> DITW110.00.11 SFI BL#30569
        #15..18

        // <<DITW17.10.05 DDR 05/09/2014 DIT-770 #675
        if (CurrFieldNo = FIELDNO("Item No.")) and ("Assembled Quantity" = 0) and ("Item No." <> '') then begin
          if (Quantity <> 0) or (xRec.Quantity <> Quantity) then
            InsertHeaderCharges4(FIELDNO("Item No."))
          else
            DeleteAllHeaderChargeLines(true);
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
        CheckIsNotAsmToOrder;
        TestStatusOpen;
        SetCurrentFieldNum(FIELDNO("Variant Code"));
        #4..12
        AssemblyHeaderReserve.VerifyChange(Rec,xRec);
        GetDefaultBin;
        VALIDATE("Unit Cost",GetUnitCost);
        ClearCurrentFieldNum(FIELDNO("Variant Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..15
         //<<DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
        if GetSKU then begin
          "Indirect Cost %" := StockkeepingUnit."Indirect Cost %";
          "Overhead Rate" := StockkeepingUnit."Overhead Rate";
        end;
        //>>DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
        // << DITW110.00.11 SFI 31/08/2017 BL#30569
        if ("Item No." <> '') then begin
          GetItem();
          Item.BlockedSKU("Location Code","Variant Code",true);
        end;
        // >> DITW110.00.11 SFI BL#30569

        // <<DITW17.10.05 DDR 05/09/2014 DIT-770 #675
        RecalcBackAsmHeaderCost(true);
        // >>DITW17.10.05 DDR DIT-770 #675
        ClearCurrentFieldNum(FIELDNO("Variant Code"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Location Code"(Field 20).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckIsNotAsmToOrder;
        TestStatusOpen;
        SetCurrentFieldNum(FIELDNO("Location Code"));
        ValidateDates(FIELDNO("Due Date"),true);
        AssemblyLineMgt.UpdateAssemblyLines(Rec,xRec,FIELDNO("Location Code"),false,CurrFieldNo,CurrentFieldNum);
        AssemblyHeaderReserve.VerifyChange(Rec,xRec);
        GetDefaultBin;
        VALIDATE("Unit Cost",GetUnitCost);
        ClearCurrentFieldNum(FIELDNO("Location Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckIsNotAsmToOrder;
        TestStatusOpen;

        // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
        if ("Responsibility Center" = xRec."Responsibility Center") and ("Location Code" <> xRec."Location Code") and
          ("Location Code" <> '')
        then begin
          Location.GET("Location Code");
          VALIDATE("Responsibility Center",UserSetupMgt.GetFirstRespCenter(4,Location."Physical Location Group Code","Location Code"));
        end;
        if (("Responsibility Center" = xRec."Responsibility Center") and ("Location Code" <> '')) or
          ("Responsibility Center" <> xRec."Responsibility Center")
        then
          if not UserSetupMgt.CheckLocation(4,"Location Code","Responsibility Center") then
            ERROR(
              Text2014412,
              Location.TABLECAPTION,"Location Code",
              RespCenter.TABLECAPTION,UserSetupMgt.GetAssemblyFilter);
        // >>DITW18.00.06 MSF DIT-770 #1192

        #3..8
        //<<DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
        if GetSKU then begin
          "Indirect Cost %" := StockkeepingUnit."Indirect Cost %";
          "Overhead Rate" := StockkeepingUnit."Overhead Rate";
        end;
        //>>DITW18.00.06 MSF 16/02/2015 DIT-770 #1185

        // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
        if "Location Code" <> '' then begin
          Location.GET("Location Code");
          if Location."Physical Location Group Code" <> "Physical Location Group Code" then
            "Physical Location Group Code" := Location."Physical Location Group Code";
        end else
          if xRec."Physical Location Group Code" = "Physical Location Group Code" then
            "Physical Location Group Code" := '';
        if xRec."Physical Location Group Code" = "Physical Location Group Code" then
          VALIDATE("Physical Location Group Code");
        // >>DITW18.00.06 MSF DIT-770 #1192
        // <<DITW17.10.05 DDR 05/09/2014 DIT-770 #675
        "Item Charge Value" := "Unit Cost";
        // >>DITW17.10.05 DDR DIT-770 #675

        // << DITW110.00.11 SFI 31/08/2017 BL#30569
        if ("Item No." <> '') then begin
          GetItem();
          Item.BlockedSKU("Location Code","Variant Code",true);
        end;
        // >> DITW110.00.11 SFI BL#30569
        ClearCurrentFieldNum(FIELDNO("Location Code"));

        // <<DITW17.10.05 DDR 05/09/2014 DIT-770 #675
        if ("Item No." <> '') and ((Quantity <> 0) or (xRec.Quantity <> Quantity)) then
          InsertHeaderCharges4(FIELDNO("Location Code"));
        // >>DITW17.10.05 DDR DIT-770 #675
        */
        //end;


        //Unsupported feature: CodeModification on ""Bin Code"(Field 33).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if Quantity < 0 then
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
        if Quantity < 0 then
          //HEI.01 PRDGAP024 delete BinCode := WMSManagement.BinContentLookUp("Location Code","Item No.","Variant Code",'',"Bin Code")
          BinCode := WMSManagement.BinContentLookUp("Location Code","Item No.","Variant Code","Zone Code","Bin Code")//HEI.01 PRDGAP024 NEW LINE
        else
          //HEI.01 PRDGAP024 delete BinCode := WMSManagement.BinLookUp("Location Code","Item No.","Variant Code",'');
          BinCode := WMSManagement.BinLookUp("Location Code","Item No.","Variant Code","Zone Code");//HEI.01 PRDGAP024 NEW LINE
        #5..7
        */
        //end;


        //Unsupported feature: CodeModification on "Quantity(Field 40).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckIsNotAsmToOrder;
        TestStatusOpen;

        #4..15
        AssemblyHeaderReserve.VerifyQuantity(Rec,xRec);

        ClearCurrentFieldNum(FIELDNO(Quantity));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..18

        // <<DITW17.10.05 DDR 05/09/2014 DIT-770 #675
        if (Quantity = 0) and (xRec.Quantity <> Quantity) and
          ("Assembled Quantity" = 0) and (CurrFieldNo <> 0)
        then begin
          CLEAR(TaxAssemblyMgt);
          DeleteAllHeaderChargeLines(true);
          if "Item Charge Value" <> "Unit Cost" then
            VALIDATE("Unit Cost","Item Charge Value");
        end;

        "Cost Amount" := ROUND(Quantity * "Unit Cost");

        if (Quantity <> 0) and (xRec.Quantity <> Quantity) then begin
          InsertHeaderCharges4(FIELDNO(Quantity));
        end;
        // >>DITW17.10.05 DDR DIT-770 #675
        */
        //end;


        //Unsupported feature: CodeModification on ""Quantity to Assemble"(Field 46).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SetCurrentFieldNum(FIELDNO("Quantity to Assemble"));
        RoundQty("Quantity to Assemble");
        if "Quantity to Assemble" > "Remaining Quantity" then
        #4..9
        VALIDATE("Quantity to Assemble (Base)",CalcBaseQty("Quantity to Assemble"));
        AssemblyLineMgt.UpdateAssemblyLines(Rec,xRec,FIELDNO("Quantity to Assemble"),false,CurrFieldNo,CurrentFieldNum);
        ClearCurrentFieldNum(FIELDNO("Quantity to Assemble"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..12

        // <<DITW17.10.05 DDR 05/09/2014 DIT-770 #675
        if ("Quantity to Assemble" <> xRec."Quantity to Assemble") and
          (CurrFieldNo <> FIELDNO(Quantity))
        then
          UpdateHeaderCharges(FIELDNO("Quantity to Assemble"),true);
        // >>DITW17.10.05 DDR DIT-770 #675
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit Cost"(Field 65).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if "Item No." <> '' then begin
          GetItem;

        #4..9
                Item.FIELDCAPTION("Costing Method"),
                Item."Costing Method");
          end;
        end;

        "Cost Amount" := ROUND(Quantity * "Unit Cost");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..12

          // <<DITW17.10.05 DDR 05/09/2014 DIT-770 #675
          if CurrFieldNo = FIELDNO("Unit Cost") then begin
            "Item Charge Value" := "Unit Cost";
            CheckInclPriceHeaderCharges(FIELDCAPTION("Unit Cost"));
          end;
          // >>DITW17.10.05 DDR DIT-770 #675
        #13..15

        // <<DITW17.10.05 DDR 05/09/2014 DIT-770 #675
        if ("Item No." <> '') and ("Unit Cost" <> xRec."Unit Cost") then
          UpdateHeaderCharges(FIELDNO("Unit Cost"),true);
        // >>DITW17.10.05 DDR DIT-770 #675
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit of Measure Code"(Field 80).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckIsNotAsmToOrder;
        TESTFIELD("Assembled Quantity",0);
        TestStatusOpen;
        SetCurrentFieldNum(FIELDNO("Unit of Measure Code"));

        GetItem;
        "Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");
        "Unit Cost" := GetUnitCost;
        "Overhead Rate" := RoundUnitAmount(Item."Overhead Rate" * "Qty. per Unit of Measure");

        AssemblyLineMgt.UpdateAssemblyLines(Rec,xRec,FIELDNO("Unit of Measure Code"),ReplaceLinesFromBOM,CurrFieldNo,CurrentFieldNum);
        ClearCurrentFieldNum(FIELDNO("Unit of Measure Code"));

        VALIDATE(Quantity);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..8
        //<<DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
        if GetSKU then
          "Overhead Rate" := RoundUnitAmount(StockkeepingUnit."Overhead Rate" * "Qty. per Unit of Measure")
        else
        //<<DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
          "Overhead Rate" := RoundUnitAmount(Item."Overhead Rate" * "Qty. per Unit of Measure");
        #10..14
        // <<DITW17.10.05 DDR 05/09/2014 DIT-770 #675
        RecalcBackAsmHeaderCost(true);
        if ((Quantity <> 0) or (xRec.Quantity <> Quantity)) then
          InsertHeaderCharges4(FIELDNO("Unit of Measure Code"));
        // >>DITW17.10.05 DDR DIT-770 #675
        */
        //end;
        field(50000; "Zone Code FND"; Code[10])
        {
            Caption = 'Zone Code';
            Description = 'HEI01';
            TableRelation = Zone.Code where("Location Code" = FIELD("Location Code"));

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

        //BC UPGRADE-ASTRO>>
        // field(50001; "Assembly ORDER Interface Astro"; Code[20])
        // {
        //     Caption = 'Assembly ORDER Interface Astro';
        //     Description = 'HEI.04';
        //     TableRelation = "Interface Setup";
        // }
        // field(50002; "Parked ORDER Astro"; Boolean)
        // {
        //     Caption = 'Parked ORDER Astro';
        //     Description = 'HEI.04';
        // }
        // field(50003; "Last Parked Date ORDER Astro"; Date)
        // {
        //     Caption = 'Last Parked Date ORDER Astro';
        //     Description = 'HEI.04';
        // }
        // field(50004; "Last Parked Time ORDER Astro"; Time)
        // {
        //     Caption = 'Last Parked Time ORDER Astro';
        //     Description = 'HEI.04';
        // }

        // field(50007; "Asmbl LINEPICK Interface Astro"; Code[20])
        // {
        //     Caption = 'Assembly LINEPICK Interface Astro';
        //     Description = 'HEI.05';
        //     TableRelation = "Interface Setup";
        // }
        // field(50008; "Parked LINEPICK Astro"; Boolean)
        // {
        //     Caption = 'Parked LINEPICK Astro';
        //     Description = 'HEI.05';
        // }
        // field(50009; "Last Parked Date LINEPICKAstro"; Date)
        // {
        //     Caption = 'Last Parked Date LINEPICK Astro';
        //     Description = 'HEI.05';
        // }
        // field(50010; "Last Parked Time LINEPICKAstro"; Time)
        // {
        //     Caption = 'Last Parked Time LINEPICK Astro';
        //     Description = 'HEI.05';
        // }
        // field(50011; "Posted LINEPICK Astro"; Boolean)
        // {
        //     Caption = 'Posted LINEPICK Astro';
        //     Description = 'HEI.05';
        // }
        // field(50014; "Asmbly OUTPUT Interface Astro"; Code[20])
        // {
        //     Caption = 'Assembly OUTPUT Interface Astro';
        //     Description = 'HEI.05';
        //     TableRelation = "Interface Setup";
        // }
        // field(50015; "Parked OUTPUT Astro"; Boolean)
        // {
        //     Caption = 'Parked OUTPUT Astro';
        //     Description = 'HEI.05';
        // }
        // field(50016; "Last Parked Date OUTPUT Astro"; Date)
        // {
        //     Caption = 'Last Parked Date OUTPUT Astro';
        //     Description = 'HEI.05';
        // }
        // field(50017; "Last Parked Time OUTPUT Astro"; Time)
        // {
        //     Caption = 'Last Parked Time OUTPUT Astro';
        //     Description = 'HEI.05';
        // }
        // field(50018; "Posted OUTPUT Astro"; Boolean)
        // {
        //     Caption = 'Posted OUTPUT Astro';
        //     Description = 'HEI.05';
        // }
        //BC UPGRADE-ASTRO<<

        //HEI.06>>
        field(50019; "Unit Volumne HL FND"; Decimal)
        {
            Caption = 'Unit Volume HL';
            Description = 'HEI.06';
        }
        //HEI.06<<



        //BC UPGRADE DIT>>
        // field(2013661; "Item Charge Value"; Decimal)
        // {
        //     AutoFormatType = 2;
        //     CaptionML = ENU = 'Item Charge Value',
        //                 FRA = 'Valeur frais annexes';
        //     Description = 'DITW17.10.05 DIT-770 #675';
        // }
        // field(2013666; "Customer DTax Group Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Customer Tax Group Code',
        //                 FRA = 'Code groupe taxe client';
        //     Description = 'DITW17.10.05 DIT-770 #675,HEI.03';
        //     TableRelation = "Drink Tax Group".Code where("Source Type" = CONST(Customer));
        // }
        // field(2013667; "Item DTax Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Charge Tax Group Code',
        //                 FRA = 'Code groupe frais annexes taxe';
        //     Description = 'DITW17.10.05 DIT-770 #675';
        //     TableRelation = "Drink Tax Group".Code where("Source Type" = CONST(Item));
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
        // field(2013733; "Tax Date"; Date)
        // {
        //     CaptionML = ENU = 'Tax Date',
        //                 FRA = 'Date taxe';
        //     Description = 'DITW17.10.05 DIT-770 #765';

        //     trigger OnValidate();
        //     var
        //         AssemblyLineTax: Record "Assembly Line";
        //         ATOLink: Record "Assemble-to-Order Link";
        //         SalesHeader: Record "Sales Header";
        //     begin
        //         if ATOLink.GET("Document Type", "No.") and (CurrFieldNo = FIELDNO("Tax Date")) then
        //             if SalesHeader.GET(ATOLink."Document Type", ATOLink."Document No.") and ("Tax Date" > SalesHeader."Tax Date") then
        //                 ERROR(Text2013670, "No.", SalesHeader."No.");

        //         //IF "Document Type" = "Document Type"::Order THEN
        //         //  TestIfEmcsSalesLinesExist(FIELDCAPTION("Tax Date"));
        //         if "Tax Date" <> xRec."Tax Date" then begin
        //             RecreateChargeAssemblyLines(FIELDCAPTION("Tax Date"));
        //             // <<DITW17.10.05 DDR 05/09/2014 DIT-770 #675
        //             InsertHeaderCharges4(FIELDNO("Tax Date"));
        //             // >>DITW17.10.05 DDR DIT-770 #675
        //         end;
        //     end;
        // }
        // field(2013767; "Unit Volume HL"; Decimal)
        // {
        //     CaptionClass = GetUomCaptionClass(FIELDNO("Unit Volume HL"));
        //     CaptionML = ENU = 'Unit Volume',
        //                 FRA = 'Volume unitaire';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW17.10.05 DIT-770 #675';
        //     MinValue = 0;
        // }
        // field(2014271; "Company Tax Warehouse Ref."; Text[20])
        // {
        //     CaptionML = ENU = 'Company Tax Warehouse Reference',
        //                 FRA = 'Entrepôt fiscal de référence société';
        //     Description = 'DITW17.10.05 DIT-770 #675';
        // }
        // field(2014410; "Responsibility Center"; Code[10])
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
        //         TestStatusOpen;
        //         if not UserSetupMgt.CheckRespCenter(4, "Responsibility Center") then
        //             ERROR(
        //               Text2014415,
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
        //         //<<DITW18.00.06 MSF 04/03/2015 DIT-770 #1192
        //         SetDim;
        //         //>>DITW18.00.06 MSF 04/03/2015 DIT-770 #1192
        //     end;
        // }
        // field(2014411; "Physical Location Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Physical Location Group Code',
        //                 FRA = 'Code groupe magasin réel';
        //     Description = 'DITW18.00.06 MSF 26/02/2015 DIT-770 #1192';
        //     TableRelation = "Physical Location Group" where(Code = FIELD("Phys. Location Table Filter"));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
        //         TestStatusOpen;
        //         if ("Responsibility Center" = xRec."Responsibility Center") and
        //           ("Physical Location Group Code" <> xRec."Physical Location Group Code") and
        //           ("Physical Location Group Code" <> '')
        //         then
        //             VALIDATE("Responsibility Center", UserSetupMgt.GetFirstRespCenter(4, "Physical Location Group Code", ''));

        //         if not UserSetupMgt.CheckPhysLocation(4, "Physical Location Group Code", "Responsibility Center") then
        //             ERROR(
        //               Text2014412,
        //               PhysLocationGr.TABLECAPTION, "Physical Location Group Code",
        //               RespCenter.TABLECAPTION, UserSetupMgt.GetAssemblyFilter);

        //         if (xRec."Physical Location Group Code" <> "Physical Location Group Code") then begin
        //             CLEAR(Location);
        //             if "Location Code" <> '' then
        //                 Location.GET("Location Code");
        //             if (Location."Physical Location Group Code" <> "Physical Location Group Code") then begin
        //                 if ((CurrFieldNo <> FIELDNO("Location Code")) and (xRec."Responsibility Center" = "Responsibility Center")) then
        //                     VALIDATE("Location Code", '')
        //                 else
        //                     "Location Code" := '';
        //             end;
        //         end;
        //         // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
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
        // field(2014500; "Has Header Item Charge"; Boolean)
        // {
        //     CalcFormula = Exist("Assembly Header Line" where("Document Type" = FIELD("Document Type"),
        //                                                       "Document No." = FIELD("No.")));
        //     CaptionML = ENU = 'Has Header Item Charge',
        //                 FRA = 'A frais annexes entête';
        //     Description = 'DITW17.10.05 DIT-770 #675';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }

        //BC UPGRADE DIT<<
    }


    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger (Variable: AssemblyHeaderLine)();
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
    CheckIsNotAsmToOrder;

    AssemblyHeaderReserve.DeleteLine(Rec);
    CALCFIELDS("Reserved Qty. (Base)");
    TESTFIELD("Reserved Qty. (Base)",0);

    DeleteAssemblyLines;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7

    // <<DITW17.10.05 DDR 05/09/2014 DIT-770 #675
    AssemblyHeaderLine.SETRANGE("Document Type","Document Type");
    AssemblyHeaderLine.SETRANGE("Document No.","No.");
    AssemblyHeaderLine.DELETEALL(true);
    // >>DITW17.10.05 DDR DIT-770 #675
    */
    //end;


    //Unsupported feature: CodeModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    AssemblyHeaderReserve.VerifyChange(Rec,xRec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    AssemblyHeaderReserve.VerifyChange(Rec,xRec);

    //HEI.04>>
    ValidateAstroAssemblyOrderModification;
    //HEI.04<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
    //Location: Record Location; //BC UPGRADE PATHAA02

    var
    //AssemblyHeaderLine: Record "Assembly Header Line";//BC UPGRADE PATHAA02


    //Unsupported feature: PropertyModification on "Text001(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : @@@="%1 = Document Type, %2 = No.";ENU=%1 %2 cannot be created, because it already exists or has been posted.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : @@@="%1 = Document Type, %2 = No.";ENU=%1 %2 cannot be created, because it already exists or has been posted.;FRA=Impossible de créer %1 %2 car il existe déjà ou a été validé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=%1 cannot be lower than the %2, which is %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=%1 cannot be lower than the %2, which is %3.;FRA=%1 ne peut pas être inférieur à %2, qui est %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1009)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=%1 cannot be higher than the %2, which is %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=%1 cannot be higher than the %2, which is %3.;FRA=%1 ne peut pas être supérieur à %2, qui est %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=Changing %1 or %2 is not allowed when %3 is %4.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=Changing %1 or %2 is not allowed when %3 is %4.;FRA=Vous n'êtes pas autorisé à modifier %1 ou %2 lorsque %3 est %4.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=Nothing to handle.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=Nothing to handle.;FRA=Il n'y a rien à traiter.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text009(Variable 1017)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text009 : ENU=You cannot rename an %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text009 : ENU=You cannot rename an %1.;FRA=Vous ne pouvez pas renommer un(e) %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text010(Variable 1012)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text010 : ENU=You have modified %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text010 : ENU=You have modified %1.;FRA=Vous avez modifié %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text011(Variable 1014)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text011 : ENU=the %1 from %2 to %3;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text011 : ENU=the %1 from %2 to %3;FRA=%1 par %2 dans %3;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text012(Variable 1021)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text012 : @@@={Locked};ENU=%1 %2;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text012 : @@@={Locked};ENU=%1 %2;FRA=%1 %2;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text013(Variable 1020)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text013 : ENU=Do you want to update %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text013 : ENU=Do you want to update %1?;FRA=Souhaitez-vous mettre à jour %1 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text014(Variable 1018)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text014 : ENU=%1 and %2;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text014 : ENU=%1 and %2;FRA=%1 et %2;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text015(Variable 1019)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text015 : @@@="%1 and %3 = Date Captions, %2 and %4 = Date Values";ENU=%1 %2 is before %3 %4.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text015 : @@@="%1 and %3 = Date Captions, %2 and %4 = Date Values";ENU=%1 %2 is before %3 %4.;FRA=%1 %2 est avant %3 %4.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "PostingDateLaterErr(Variable 1022)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //PostingDateLaterErr : ENU=Posting Date on Assembly Order %1 must not be later than the Posting Date on Sales Order %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PostingDateLaterErr : ENU=Posting Date on Assembly Order %1 must not be later than the Posting Date on Sales Order %2.;FRA=La date de comptabilisation figurant l'ordre d'assemblage %1 ne doit pas être postérieure à celle figurant sur la commande vente %2.;
    //Variable type has not been exported.

    var
        Text020: TextConst ENU = 'A "%1" Assembly Order cannot be modified.', FRA = 'Un O.F. terminé ne peut pas être modifié.';

    var
        //Text2014415: TextConst ENU = 'Your identification is set up to process from %1 %2 only.', FRA = 'Le paramétrage de votre code utilisateur ne vous permet de travailler que sur %1 %2.';
        //PhysLocationGr: Record "Physical Location Group";//BC UPGRADE
        //Text2013660: TextConst ENU = 'You have modified the %1 field. Note that the recalculation may cause penny differences, so you must check the amounts afterwards. ', FRA = 'Vous avez modifié le champ %1. Le recalcul va provoquer de petites différences. Veuillez vérifier les montants. ';
        //Text2013661: TextConst ENU = 'You must specify %1 in %2 or %3 or %4 when %5 %6.', FRA = 'Vous devez spécifier %1 dans %2 ou %3 ou %4 quand %5 %6.';
        //Text2013662: TextConst ENU = 'If you change %1, the existing assembly tax charge lines will be deleted and new assembly tax charge lines based on the new information on the header will be created.\\', FRA = 'Si vous changez %1, les lignes existantes de frais annexes d''assemblage seront supprimés et de nouvelles lignes sur la base de nouvelles informations sur l''en-tête seront créés. \\';
        //Text2013663: TextConst ENU = 'You cannot change %1 because the value is automatically calculated with %2.', FRA = 'Vous ne pouvez pas modifier %1 car la valeur est calculé automatiquement avec %2.';
        //Text2013670: TextConst ENU = 'Tax Date on Assembly Order %1 must not be later than the Tax Date on Sales Order %2.', FRA = 'Date de la taxe sur ordre d''assemblage %1 ne doit pas être postérieure à la date de la taxe sur les ventes Ordre %2.';
        //Text2014410: TextConst ENU = 'If you change %1, all existing assembly charge lines will be deleted and new assembly charge lines based on the new information on the header will be created.\\', FRA = 'Si vous changez %1, toutes les lignes de frais annexes d''assemblage existantes seront supprimées et de nouvelles lignes sur la base de nouvelles informations sur l''en-tête seront créés. \\';
        //Text2014411: TextConst ENU = 'You must delete the existing assembly lines before you can change %1.', FRA = 'Vous devez supprimer les lignes d''assemblage existantes avant de pouvoir modifier %1.';
        InvSetup: Record "Inventory Setup";
        //Text2014412: TextConst ENU = 'You cannot use the %1 %2 because your identification is set up to process from %3 %4 only.', FRA = 'Vous ne pouvez pas utiliser le %1 %2 parce que votre identification est mis en place pour traiter de %3 %4 seulement.';
        //Text2014413: TextConst ENU = 'If you change %1, all existing will be updated and all sales charge lines will be deleted and new sales charge lines based on the new information on the header will be created.\\', FRA = 'Si vous changez %1, tous les existants seront mis à jour et toutes les lignes de frais de souscription seront supprimés et de nouvelles lignes de frais d''acquisition sur la base de nouvelles informations sur l''en-tête seront créés \\.';
        //UserSetupMgt: Codeunit "User Setup Management"; //BC UPGRADE
        Location: Record Location;
        RespCenter: Record "Responsibility Center";
        //BC UPGRADE PATHAA02>>
        // TaxAssemblyMgt: Codeunit "Tax Assembly Charges Mgt.";
        // CommonItemChrgMgt: Codeunit "Common Item Charges Mgt.";
        // LocationGr: Record "Location Group";
        // ItemDrinkTaxGr: Record "Drink Tax Group";
        // Text2013664: TextConst ENU = 'At least one item charge tax line must exist with the %1 %2.', FRA = 'Il doit exister au moins une ligne de type taxe avec le %1 %2.';
        // //CustDrinkTaxGr: Record "Drink Tax Group"; 
        //BC UPGRADE PATHAA02<<
        WHSUTILS: Codeunit "WHS-UTILS";
}

