tableextension 50217 StandardCostWorksheetExtFND extends "Standard Cost Worksheet"
{
    // version NAVW110.0.00.15601,DITW110.00.09,HEI.01
    //       FINXL7.00.001 RBE 20/03/2013: Item description extend from 30 -> 80 chars

    //       DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    //       DITW18.00.06 MSF 16/02/2015 DIT-770 #1185 : Added field 2014410 "Location code"
    //                                                               2014411 "Variant code"
    //                                                   Modify Key "Standard Cost Worksheet Name","Type","No.","Location Code","Variant code"
    //                                                   Added Function GetSKUCost
    //       DITW18.00.06 DDR 06/03/2015 DIT-770 #1186 Bugfix clear "Location Code","Variant Code" on Init()

    //       DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //       DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    //       DITW110.00.09 AKH 31/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9

    //       HEI.01 CHG2157335 HB2876 NORRIQ KOROLA04 04.08.2022
    //         #New field added - Production Bob No., Routing No.

    //   BC Upgrade KUMARS145 Table Ext     
    //   BC Upgrade KUMARS145 Flowfield "Production BOM No.","Routing No." Dependent on "Location Code", "Variant Code" Drinkit fields.

    fields
    {
        modify("Standard Cost Worksheet Name")
        {
            CaptionML = ENU = 'Standard Cost Worksheet Name', FRA = 'Nom feuille coût standard';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            // OptionCaptionML = ENU = 'Item,Work Center,Machine Center,Resource', FRA = 'Article,Centre de charge,Poste de charge,Ressource';
        }
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify(Implemented)
        {
            CaptionML = ENU = 'Implemented', FRA = 'Implémenté';
        }
        modify("Replenishment System")
        {
            CaptionML = ENU = 'Replenishment System', FRA = 'Système réappro.';
            // OptionCaptionML = ENU = 'Purchase,Prod. Order, ,Assembly', FRA = 'Achat,O.F., ,Assemblage';
        }
        modify("Standard Cost")
        {
            CaptionML = ENU = 'Standard Cost', FRA = 'Coût standard';
        }
        modify("New Standard Cost")
        {
            CaptionML = ENU = 'New Standard Cost', FRA = 'Nouveau coût standard';
        }
        modify("Indirect Cost %")
        {
            CaptionML = ENU = 'Indirect Cost %', FRA = '% coût indirect';
        }
        modify("New Indirect Cost %")
        {
            CaptionML = ENU = 'New Indirect Cost %', FRA = 'Nouveau % coût indirect';
        }
        modify("Overhead Rate")
        {
            CaptionML = ENU = 'Overhead Rate', FRA = 'Frais généraux';
        }
        modify("New Overhead Rate")
        {
            CaptionML = ENU = 'New Overhead Rate', FRA = 'Nouveaux frais généraux';
        }
        modify("Single-Lvl Material Cost")
        {
            CaptionML = ENU = 'Single-Lvl Material Cost', FRA = 'Coût matière mono-niveau';
        }
        modify("New Single-Lvl Material Cost")
        {
            CaptionML = ENU = 'New Single-Lvl Material Cost', FRA = 'Nouv. coût matière mono-niv.';
        }
        modify("Single-Lvl Cap. Cost")
        {
            CaptionML = ENU = 'Single-Lvl Cap. Cost', FRA = 'Coût opératoire mono-niv.';
        }
        modify("New Single-Lvl Cap. Cost")
        {
            CaptionML = ENU = 'New Single-Lvl Cap. Cost', FRA = 'Nouv. coût opérat. mono-niv.';
        }
        modify("Single-Lvl Subcontrd Cost")
        {
            CaptionML = ENU = 'Single-Lvl Subcontrd Cost', FRA = 'Coût s/traitance mono-niv.';
        }
        modify("New Single-Lvl Subcontrd Cost")
        {
            CaptionML = ENU = 'New Single-Lvl Subcontrd Cost', FRA = 'Nouv. coût s/trait. mono-niv.';
        }
        modify("Single-Lvl Cap. Ovhd Cost")
        {
            CaptionML = ENU = 'Single-Lvl Cap. Ovhd Cost', FRA = 'Frais gén. opérat. mono-niv.';
        }
        modify("New Single-Lvl Cap. Ovhd Cost")
        {
            CaptionML = ENU = 'New Single-Lvl Cap. Ovhd Cost', FRA = 'Nouv. frais gén. opérat. mono-niv.';
        }
        modify("Single-Lvl Mfg. Ovhd Cost")
        {
            CaptionML = ENU = 'Single-Lvl Mfg. Ovhd Cost', FRA = 'Frais gén. matière mono-niv.';
        }
        modify("New Single-Lvl Mfg. Ovhd Cost")
        {
            CaptionML = ENU = 'New Single-Lvl Mfg. Ovhd Cost', FRA = 'Nouv. frais gén. mat. mono-niv.';
        }
        modify("Rolled-up Material Cost")
        {
            CaptionML = ENU = 'Rolled-up Material Cost', FRA = 'Coût matière multi-niveau';
        }
        modify("New Rolled-up Material Cost")
        {
            CaptionML = ENU = 'New Rolled-up Material Cost', FRA = 'Nouv. coût matière multi-niv.';
        }
        modify("Rolled-up Cap. Cost")
        {
            CaptionML = ENU = 'Rolled-up Cap. Cost', FRA = 'Coût opératoire multi-niv.';
        }
        modify("New Rolled-up Cap. Cost")
        {
            CaptionML = ENU = 'New Rolled-up Cap. Cost', FRA = 'Nouv. coût opérat. multi-niv.';
        }
        modify("Rolled-up Subcontrd Cost")
        {
            CaptionML = ENU = 'Rolled-up Subcontrd Cost', FRA = 'Coût s/traitance multi-niv.';
        }
        modify("New Rolled-up Subcontrd Cost")
        {
            CaptionML = ENU = 'New Rolled-up Subcontrd Cost', FRA = 'Nouv. coût s/trait. multi-niv.';
        }
        modify("Rolled-up Cap. Ovhd Cost")
        {
            CaptionML = ENU = 'Rolled-up Cap. Ovhd Cost', FRA = 'Frais gén. opérat. multi-niv.';
        }
        modify("New Rolled-up Cap. Ovhd Cost")
        {
            CaptionML = ENU = 'New Rolled-up Cap. Ovhd Cost', FRA = 'Nouv. frais gén. opérat. multi-niv.';
        }
        modify("Rolled-up Mfg. Ovhd Cost")
        {
            CaptionML = ENU = 'Rolled-up Mfg. Ovhd Cost', FRA = 'Frais gén. matière multi-niv.';
        }
        modify("New Rolled-up Mfg. Ovhd Cost")
        {
            CaptionML = ENU = 'New Rolled-up Mfg. Ovhd Cost', FRA = 'Nouv. frais gén. mat. multi-niv.';
        }

        //Unsupported feature: CodeModification on ""No."(Field 4).OnValidate". Please convert manually.

        //trigger "(Field 4)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TempStdCostWksh := Rec;
        INIT;
        Type := TempStdCostWksh.Type;
        "No." := TempStdCostWksh."No.";
        "Replenishment System" := "Replenishment System"::" ";
        #6..13
              Description := Item.Description;
              "Replenishment System" := Item."Replenishment System";
              GetItemCosts;
            end;
          Type::"Work Center":
            begin
        #20..33
              GetResCosts;
            end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TempStdCostWksh := Rec;
        INIT;
        // <<DITW18.00.06 DDR 06/03/2015 DIT-770 #1186
        "Location Code" := '';
        "Variant Code" := '';
        // >>DITW18.00.06 DDR DIT-770 #1186
        #3..16
              //<<DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
              if ("Location Code" <> '') or ("Variant Code" <> '') then begin
                if  SKU.GET("Location Code","No.","Variant Code") then begin
                  "Replenishment System" := SKU."Replenishment System";
                  GetSKUCosts;
                end;
              end;
              //>>DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
        #17..36
        */
        //end;
        field(50000; "Production BOM No. FND"; Code[20])
        {
            Caption = 'Production BOM No.';
            // CalcFormula = Lookup("Stockkeeping Unit"."Production BOM No." WHERE("Item No." = FIELD("No."), "Variant Code" = FIELD("Variant Code"), "Location Code" = FIELD("Location Code")));// BC Upgrade KUMARS145 Dependent on "Location Code", "Variant Code" Drinkit fields.
            CalcFormula = Lookup("Stockkeeping Unit"."Production BOM No." WHERE("Item No." = FIELD("No.")));
            Description = 'HEI.01';
            FieldClass = FlowField;
        }
        field(50001; "Routing No. FND"; Code[20])
        {
            Caption = 'Routing No.';
            // CalcFormula = Lookup("Stockkeeping Unit"."Routing No." WHERE("Item No." = FIELD("No."), "Variant Code" = FIELD("Variant Code"), "Location Code" = FIELD("Location Code")));// BC Upgrade KUMARS145 Dependent on "Location Code", "Variant Code" Drinkit fields.
            CalcFormula = Lookup("Stockkeeping Unit"."Routing No." WHERE("Item No." = FIELD("No.")));
            Description = 'HEI.01';
            FieldClass = FlowField;
        }
        // BC Upgrade KUMARS145 Drinkit Fields ...>>
        // field(2014410; "Location Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Location Code',
        //                 FRA = 'Code magasin';
        //     Description = 'DITW18.00.06 MSF 16/02/2015 DIT-770 #1185';
        //     Editable = false;
        //     TableRelation = Location WHERE("Use As In-Transit" = CONST(false));

        //     trigger OnValidate();
        //     begin
        //         //<<DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
        //         if ("Location Code" <> '') or ("Variant Code" <> '') then begin
        //             if SKU.GET("Location Code", "No.", "Variant Code") then begin
        //                 "Replenishment System" := SKU."Replenishment System";
        //                 GetSKUCosts;
        //             end;
        //         end;
        //         //>>DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
        //     end;
        // }
        // field(2014411; "Variant Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Variant Code',
        //                 FRA = 'Code variante';
        //     Description = 'DITW18.00.06 MSF 16/02/2015 DIT-770 #1185';
        //     Editable = false;

        //     trigger OnValidate();
        //     begin
        //         //<<DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
        //         if ("Location Code" <> '') or ("Variant Code" <> '') then begin
        //             if SKU.GET("Location Code", "No.", "Variant Code") then begin
        //                 "Replenishment System" := SKU."Replenishment System";
        //                 GetSKUCosts;
        //             end;
        //         end;
        //         //>>DITW18.00.06 MSF 16/02/2015 DIT-770 #1185
        //     end;
        // }
        // BC Upgrade KUMARS145 Drinkit Fields ...<<

    }
    keys
    {
        //Unsupported feature: Deletion on ""Standard Cost Worksheet Name",Type,"No."(Key)". Please convert manually.
        // key(Key50000; "Standard Cost Worksheet Name", Type, "No.", "Location Code", "Variant Code") { } // BC Upgrade KUMARS145 Dependent on "Location Code", "Variant Code" Drinkit fields. 
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.
    //Unsupported feature: PropertyChange. Please convert manually.
    //Unsupported feature: PropertyChange. Please convert manually.


    var
        SKU: Record "Stockkeeping Unit";
}

