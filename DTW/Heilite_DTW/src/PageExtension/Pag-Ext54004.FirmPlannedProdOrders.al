pageextension 54004 FirmPlannedProdOrdersExt extends "Firm Planned Prod. Orders"
{
    // version NAVW110.0,DITW110.00.12A,HEI.10
    // DITW18.00.06 MSF 26/02/2015 DIT-770 #1192 Added fields 2014410 "Responsibility Center"
    //                                                     2014411 "Physical Location Group Code"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.12 AKH 21/03/2018 NRQ#64704 Added fields "Unit of Measure Code"
    //                                                 "Quantity (Base)"
    //                                                 "Quantity HL"
    // DITW110.00.12A HBA 18/06/2018 NRQ#68221 Added fields "Routing Version Code"
    //                                                     "Routing Version Description"
    //                                                     "Production BOM No."
    //                                                     "Production BOM Version Code"
    //                                                     "Production BOM Version Desc."
    // HEI.01 FDD-PRDGAP034 IBM HORTOC01 22.06.2017
    // # add new action - importfirmprodorder
    // HEI.02 FDD-PRDGAP024 IBM SOICAD01 25.07.2017 #Zone code development without whs advanced mgmt
    // #new fields Zone Code
    // HEI.03 CHG2069358 IBM.AK 25.08.20
    // # new field added on -"Created By"
    // HEI.04 CHG2070663 IBM POENAB02 18.09.2020 Role Centre Production Bottling Role Centre
    // # Code added in OnOpenPage
    // HEI.05 CHG2129985 IBM.LS      21.02.2022
    // # Added New Field - Item Category Code => BC Upgrade SHUKLP03 << Item Category Code is DrinkIT field. 

    // HEI.06 CHG2149734 SAHAL01 07.09.2022 => BC Upgrade SHUKLP03 << Astro fields are blocked. 
    // # Added New Fields - Prod. ORDER Interface Astro
    //                     - Parked ORDER Astro
    //                     - Last Parked Date ORDER Astro
    //                     - Last Parked Time ORDER Astro
    // # Added Code to visible Astro Fields => BC Upgrade SHUKLP03 << blocked

    // HEI.07 CHG2154370 SAHAL01 05.09.2022 => BC Upgrade SHUKLP03 << Astro fields are blocked. 
    // # Added New Fields - Prod. CLOSE Interface Astro
    //                     - Last Parked Date CLOSE Astro
    //                     - Last Parked Time CLOSE Astro
    // # Added Code to visible Astro Fields => BC Upgrade SHUKLP03 << blocked

    // HEI.08 CHG2154367 SAHAL01 08.09.2022 => BC Upgrade SHUKLP03 << Astro fields are blocked. 
    // # Added New Fields - Prod. OUTPUT Interface Astro
    //                     - Parked OUTPUT Astro
    //                     - Last Parked Date OUTPUT Astro
    //                     - Last Parked Time OUTPUT Astro
    // # Added Code to visible Astro Fields => BC Upgrade SHUKLP03 << blocked

    // HEI.09 CHG2154364 SAHAL01 20.10.2022 => BC Upgrade SHUKLP03 << Astro fields are blocked. 
    // # Added New Fields - Prod. LINEPICK Interface Astro
    //                     - Parked LINEPICK Astro
    //                     - Last Parked Date LINEPICKAstro
    //                     - Last Parked Time LINEPICKAstro
    // # Added Code to visible Astro Fields => BC Upgrade SHUKLP03 << blocked

    // HEI.10 Astro - I/F Inventory Management - BalanceChange => BC Upgrade SHUKLP03 << Astro fields are blocked. 
    // # Added New Fields - OUTPUT Revers Interface Astro
    //                     - Parked OUTPUT Revers Astro
    //                     - Last Parked Date OUTPUTR Astro
    //                     - Last Parked Time OUTPUTR Astro
    // # added Code to visible Astro Fields => BC Upgrade SHUKLP03 << blocked

    layout
    {
        addafter("Last Date Modified")
        {
            field("Zone Code"; Rec."Zone Code FND")
            {
                ApplicationArea = All;
            }
            field("Created By"; Rec."Created By FND")
            {
                ApplicationArea = All;
            }
        }
        addafter("Bin Code")
        {
             //BC Upgrade Kamnay01>>field added
            field("Unit of Measure Code"; Rec."Unit of Measure Code FND")
            {
                ApplicationArea = All;
                ToolTipML = ENU = 'Specifies the unit of measure used for production. This field is used to calculate the quantity of components needed for production based on the production quantity and the unit of measure conversion.', FRA = 'Spécifie l''unité de mesure utilisée pour la production. Ce champ est utilisé pour calculer la quantité de composants nécessaires à la production en fonction de la quantité de production et de la conversion d''unité de mesure.';
            }
             //BC Upgrade Kamnay01<< field added
            //BC Upgrade GUNREM01 >> Added DIT fields
            field("Gyle No."; Rec."Gyle No. FND")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Ref No.',
                            FRA = 'Gyle N°';
            }
            //BC Upgrade GUNREM01 <<Added DIT fields
        }


        // BC Upgrade SHUKLP03 >> DrinkIT fields are blocked.
        // addafter("Source No.")
        // {
        //     field("Item Category Code"; Rec."Item Category Code")
        //     {
        //     }
        // }
        // addafter("Routing No.")
        // {
        //     field("Routing Version Code"; "Routing Version Code")
        //     {
        //         Visible = false;
        //     }
        //     field("Routing Version Description"; "Routing Version Description")
        //     {
        //         Visible = false;
        //     }
        //     field("Production BOM No."; "Production BOM No.")
        //     {
        //         Visible = false;
        //     }
        //     field("Production BOM Version Code"; "Production BOM Version Code")
        //     {
        //         Visible = false;
        //     }
        //     field("Production BOM Version Desc."; "Production BOM Version Desc.")
        //     {
        //         Visible = false;
        //     }
        // }
        // addafter(Quantity)
        // {
        //     field("Unit of Measure Code"; "Unit of Measure Code")
        //     {
        //     }
        //     field("Quantity (Base)"; "Quantity (Base)")
        //     {
        //     }
        //     field("Quantity HL"; "Quantity HL")
        //     {
        //     }
        // }
        // addafter("Last Date Modified")
        // {
        //     field("Zone Code"; "Zone Code")
        //     {
        //     }
        // }
        // addafter("Bin Code")
        // {
        //     field("Responsibility Center"; "Responsibility Center")
        //     {
        //         Importance = Additional;
        //         QuickEntry = false;
        //     }
        //     field("Physical Location Group Code"; "Physical Location Group Code")
        //     {
        //         Importance = Additional;
        //         QuickEntry = false;
        //     }
        // BC Upgrade SHUKLP03 << DrinkIT fields are blocked.

        // BC Upgrade SHUKLP03 >> Astro fields are blocked.
        //     field("Prod. ORDER Interface Astro"; "Prod. ORDER Interface Astro")
        //     {
        //         Visible = VisibleAstro;
        //     }
        //     field("Parked ORDER Astro"; "Parked ORDER Astro")
        //     {
        //         Visible = VisibleAstro;
        //     }
        //     field("Last Parked Date ORDER Astro"; "Last Parked Date ORDER Astro")
        //     {
        //         Visible = VisibleAstro;
        //     }
        //     field("Last Parked Time ORDER Astro"; "Last Parked Time ORDER Astro")
        //     {
        //         Visible = VisibleAstro;
        //     }
        //     field("Prod. LINEPICK Interface Astro"; "Prod. LINEPICK Interface Astro")
        //     {
        //         Visible = VisibleAstroLinePick;
        //     }
        //     field("Parked LINEPICK Astro"; "Parked LINEPICK Astro")
        //     {
        //         Visible = VisibleAstroLinePick;
        //     }
        //     field("Last Parked Date LINEPICKAstro"; "Last Parked Date LINEPICKAstro")
        //     {
        //         Visible = VisibleAstroLinePick;
        //     }
        //     field("Last Parked Time LINEPICKAstro"; "Last Parked Time LINEPICKAstro")
        //     {
        //         Visible = VisibleAstroLinePick;
        //     }
        //     field("Prod. OUTPUT Interface Astro"; "Prod. OUTPUT Interface Astro")
        //     {
        //         Visible = VisibleAstroOutput;
        //     }
        //     field("Parked OUTPUT Astro"; "Parked OUTPUT Astro")
        //     {
        //         Visible = VisibleAstroOutput;
        //     }
        //     field("Last Parked Date OUTPUT Astro"; "Last Parked Date OUTPUT Astro")
        //     {
        //         Visible = VisibleAstroOutput;
        //     }
        //     field("Last Parked Time OUTPUT Astro"; "Last Parked Time OUTPUT Astro")
        //     {
        //         Visible = VisibleAstroOutput;
        //     }
        //     field("OUTPUT Revers Interface Astro"; "OUTPUT Revers Interface Astro")
        //     {
        //         Visible = VisibleAstroOutputReversal;
        //     }
        //     field("Parked OUTPUT Revers Astro"; "Parked OUTPUT Revers Astro")
        //     {
        //         Visible = VisibleAstroOutputReversal;
        //     }
        //     field("Last Parked Date OUTPUTR Astro"; "Last Parked Date OUTPUTR Astro")
        //     {
        //         Visible = VisibleAstroOutputReversal;
        //     }
        //     field("Last Parked Time OUTPUTR Astro"; "Last Parked Time OUTPUTR Astro")
        //     {
        //         Visible = VisibleAstroOutputReversal;
        //     }
        //     field("Prod. CLOSE Interface Astro"; "Prod. CLOSE Interface Astro")
        //     {
        //         Visible = VisibleAstroClose;
        //     }
        //     field("Last Parked Date CLOSE Astro"; "Last Parked Date CLOSE Astro")
        //     {
        //         Visible = VisibleAstroClose;
        //     }
        //     field("Last Parked Time CLOSE Astro"; "Last Parked Time CLOSE Astro")
        //     {
        //         Visible = VisibleAstroClose;
        //     }
        // }
        // BC Upgrade SHUKLP03 << Astro fields are blocked.
    }
    actions
    {
        modify("Pro&d. Order")
        {
            CaptionML = ENU = 'Pro&d. Order', FRA = '&O.F.';
        }
        modify("E&ntries")
        {
            CaptionML = ENU = 'E&ntries', FRA = 'É&critures';
        }
        modify("Item Ledger E&ntries")
        {
            CaptionML = ENU = 'Item Ledger E&ntries', FRA = 'É&critures comptables article';
        }
        modify("Capacity Ledger Entries")
        {
            CaptionML = ENU = 'Capacity Ledger Entries', FRA = 'Écritures comptables capacité';
        }
        modify("Value Entries")
        {
            CaptionML = ENU = 'Value Entries', FRA = 'Écritures valeur';
        }
        modify("&Warehouse Entries")
        {
            CaptionML = ENU = '&Warehouse Entries', FRA = 'Écritures &entrepôt';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Change &Status")
        {
            CaptionML = ENU = 'Change &Status', FRA = 'Changer &statut';
        }
        modify("&Update Unit Cost")
        {
            CaptionML = ENU = '&Update Unit Cost', FRA = '&Mise à jour coût unitaire';
        }
        modify("Prod. Order - Detail Calc.")
        {
            CaptionML = ENU = 'Prod. Order - Detail Calc.', FRA = 'O. F. - Calc. détail';
        }
        modify("Prod. Order - Precalc. Time")
        {
            CaptionML = ENU = 'Prod. Order - Precalc. Time', FRA = 'O.F. - Temps théoriques';
        }
        modify("Production Order - Comp. and Routing")
        {
            CaptionML = ENU = 'Production Order - Comp. and Routing', FRA = 'Ordre de fabrication - Composant et gamme';
        }
        modify(ProdOrderJobCard)
        {
            CaptionML = ENU = 'Production Order Job Card', FRA = 'Ordre de fabrication - fiche suiveuse';
        }
        modify(ProdOrderMaterialRequisition)
        {
            CaptionML = ENU = 'Production Order - Material Requisition', FRA = 'Ordre de fabrication - Besoin matière';
        }
        modify("Production Order List")
        {
            CaptionML = ENU = 'Production Order List', FRA = 'Liste des O.F.';
        }
        modify(ProdOrderShortageList)
        {
            CaptionML = ENU = 'Production Order - Shortage List', FRA = 'Ordre de fabrication - Liste des ruptures';
        }
        modify("Production Order Statistics")
        {
            CaptionML = ENU = 'Production Order Statistics', FRA = 'Statistiques O.F.';
        }
        addafter("&Update Unit Cost")
        {
            action(ImportFirmProdOrder)
            {
                Caption = 'Import Firm Prod. Order';
                Description = 'HEI.01';
                Image = Import;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Import Firm. Prod. Orders";
                ApplicationArea = All;
            }
        }
    }

    trigger OnOpenPage()
    var
    begin
        //HEI.04>>
        TileRespCenterFilter := Rec.GETFILTER("Role Centre Tile Code FND");
        IF TileRespCenterFilter <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETFILTER("Role Centre Tile Code FND", TileRespCenterFilter);
            Rec.FILTERGROUP(0);
        END;
        //HEI.04<<

        // BC Upgrade SHUKLP03 >> Astro code is blocked.
        // //HEI.06>>
        // CLEAR(VisibleAstro);
        // //HEI.07>>
        // CLEAR(VisibleAstroClose);
        // //HEI.07<<
        // //HEI.08>>
        // CLEAR(VisibleAstroOutput);
        // //HEI.08<<
        // //HEI.09>>
        // CLEAR(VisibleAstroLinePick);
        // //HEI.09<<
        // //HEI.10>>
        // CLEAR(VisibleAstroOutputReversal);
        // //HEI.10<<
        // IF AstroInterfaceSetupL.GET AND AstroInterfaceSetupL."Enabled Astro Integration" THEN BEGIN
        //     IF AstroInterfaceSetupL."Activate Prod. Order" THEN BEGIN
        //         IF AstroInterfaceSetupL."Prod. Order Interface" <> '' THEN BEGIN
        //             IF InterfaceSetupL.GET(AstroInterfaceSetupL."Prod. Order Interface") THEN
        //                 VisibleAstro := TRUE;
        //         END;
        //         //HEI.07>>
        //         CLEAR(InterfaceSetupL);
        //         IF AstroInterfaceSetupL."Prod. Order Close Interface" <> '' THEN BEGIN
        //             IF InterfaceSetupL.GET(AstroInterfaceSetupL."Prod. Order Close Interface") THEN
        //                 VisibleAstroClose := TRUE;
        //         END;
        //         //HEI.07<<
        //         //HEI.08>>
        //         CLEAR(InterfaceSetupL);
        //         IF AstroInterfaceSetupL."Prod. Order Output Interface" <> '' THEN BEGIN
        //             IF InterfaceSetupL.GET(AstroInterfaceSetupL."Prod. Order Output Interface") THEN
        //                 VisibleAstroOutput := TRUE;
        //         END;
        //         //HEI.08<<
        //         //HEI.09>>
        //         CLEAR(InterfaceSetupL);
        //         IF AstroInterfaceSetupL."Prod. Order LinePick Interface" <> '' THEN BEGIN
        //             IF InterfaceSetupL.GET(AstroInterfaceSetupL."Prod. Order LinePick Interface") THEN
        //                 VisibleAstroLinePick := TRUE;
        //         END;
        //         //HEI.09<<
        //     END;
        //     //HEI.10>>
        //     CLEAR(InterfaceSetupL);
        //     IF AstroInterfaceSetupL."Activate Inventory Balance" THEN BEGIN
        //         IF AstroInterfaceSetupL."Balance Change Interface" <> '' THEN BEGIN
        //             IF InterfaceSetupL.GET(AstroInterfaceSetupL."Balance Change Interface") THEN BEGIN
        //                 IF (AstroInterfaceSetupL."Output Revers Journal Template" <> '') AND
        //                     (AstroInterfaceSetupL."Output Revers Journal Batch" <> '') THEN
        //                     VisibleAstroOutputReversal := TRUE;
        //             END;
        //         END;
        //     END;
        //     //HEI.10<<
        // END;
        // //HEI.06<<
        // BC Upgrade SHUKLP03 << Astro code is blocked.
    end;

    var
        UserMgt: Codeunit "User Setup Management";
        TileRespCenterFilter: Text;
        VisibleAstro: Boolean;
        VisibleAstroClose: Boolean;
        VisibleAstroOutput: Boolean;
        VisibleAstroLinePick: Boolean;
        VisibleAstroOutputReversal: Boolean;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    var
    // AstroInterfaceSetupL: Record "Astro Interface Setup";
    // InterfaceSetupL: Record "Interface Setup";
    //begin
    /*
    // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
    SetSecurityFilterOnRespCenter();
    // >>DITW18.00.06 MSF 26/02/2015 DIT-770 #1192

    //HEI.04>>
    TileRespCenterFilter := GETFILTER("Role Centre Tile Code");
    if TileRespCenterFilter <>'' then
      begin
        FILTERGROUP(2);
        SETFILTER("Role Centre Tile Code",TileRespCenterFilter);
        FILTERGROUP(0);
      end;
    //HEI.04<<

    //HEI.06>>
    CLEAR(VisibleAstro);
    //HEI.07>>
    CLEAR(VisibleAstroClose);
    //HEI.07<<
    //HEI.08>>
    CLEAR(VisibleAstroOutput);
    //HEI.08<<
    //HEI.09>>
    CLEAR(VisibleAstroLinePick);
    //HEI.09<<
    //HEI.10>>
    CLEAR(VisibleAstroOutputReversal);
    //HEI.10<<
    if AstroInterfaceSetupL.GET and AstroInterfaceSetupL."Enabled Astro Integration" then begin
      if AstroInterfaceSetupL."Activate Prod. Order" then begin
        if AstroInterfaceSetupL."Prod. Order Interface" <> '' then begin
          if InterfaceSetupL.GET(AstroInterfaceSetupL."Prod. Order Interface") then
            VisibleAstro := true;
        end;
        //HEI.07>>
        CLEAR(InterfaceSetupL);
        if AstroInterfaceSetupL."Prod. Order Close Interface" <> '' then begin
          if InterfaceSetupL.GET(AstroInterfaceSetupL."Prod. Order Close Interface") then
            VisibleAstroClose := true;
        end;
        //HEI.07<<
        //HEI.08>>
        CLEAR(InterfaceSetupL);
        if AstroInterfaceSetupL."Prod. Order Output Interface" <> '' then begin
          if InterfaceSetupL.GET(AstroInterfaceSetupL."Prod. Order Output Interface") then
            VisibleAstroOutput := true;
        end;
        //HEI.08<<
        //HEI.09>>
        CLEAR(InterfaceSetupL);
        if AstroInterfaceSetupL."Prod. Order LinePick Interface" <> '' then begin
          if InterfaceSetupL.GET(AstroInterfaceSetupL."Prod. Order LinePick Interface") then
            VisibleAstroLinePick := true;
        end;
        //HEI.09<<
      end;
      //HEI.10>>
      CLEAR(InterfaceSetupL);
      if AstroInterfaceSetupL."Activate Inventory Balance" then begin
        if AstroInterfaceSetupL."Balance Change Interface" <> '' then begin
          if InterfaceSetupL.GET(AstroInterfaceSetupL."Balance Change Interface") then begin
            if (AstroInterfaceSetupL."Output Revers Journal Template" <> '') and
              (AstroInterfaceSetupL."Output Revers Journal Batch" <> '') then
                VisibleAstroOutputReversal := true;
          end;
        end;
      end;
      //HEI.10<<
    end;
    //HEI.06<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

