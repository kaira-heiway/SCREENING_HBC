pageextension 54012 FinishedProductionOrdersDTWExt extends "Finished Production Orders"
{
    // version NAVW110.0,DITW110.00.12A,HEI.06
    // DITW18.00.06 MSF 26/02/2015 DIT-770 #1192 Added fields 2014410 "Responsibility Center"
    //                                                          2014411 "Physical Location Group Code"

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.12 AKH 21/03/2018 NRQ#64704 Added fields "Unit of Measure Code"
    //                                                       "Quantity (Base)"
    //                                                       "Quantity HL"
    //   DITW110.00.12A HBA 18/06/2018 NRQ#68221 Added fields "Routing Version Code"
    //                                                        "Routing Version Description"
    //                                                        "Production BOM No."
    //                                                        "Production BOM Version Code"
    //                                                        "Production BOM Version Desc."
    //   DITW111.00.13 ISL 13/09/2018 NRQ#84282 Added code to display finished quantity
    //                                          Added column decFinishedQty

    //   HEI.01 FDD-PRDGAP039 IBM.HORTOC01 13/07/2017
    //     # Page action ProcessOrderGoodsMovement
    //   HEI.02 CHG0270593 - IBM ISYED01 2.15.2019
    //     # When more than one Lot No is found for the same one line/ 1 Prod. Order description ÃMultipleÄ should be displayed
    //     # added Gyle no to the page
    //   HEI.03 CHG2069358 IBM.AK 25.08.20
    //    # new field added on -"Created By"
    //   HEI.04 CHG2070663 IBM POENAB02 18.09.2020 Role Centre Production Bottling Role Centre
    //     # Code added in OnOpenPage
    //   HEI.05 CHG2098891 IBM.LS      19.07.2021
    //     # Added Field - Blocked (Caption: Admin. Completed)
    //     # Moved Field - Blocked after No.
    //   HEI.06 CHG2256714 HB3991 IBM VERMAA03 18.07.2024
    //     # Changed DeleteAllowed page property from Yes to No

    // BC Upgrade MISHRS14>> Added HEI Tag only no change in code as delete allowed property is already false in code
    // HEI.08 CHG2311960 SHARMP16 22.07.2025 CC incident link to INC5040545 - Development
    // # Changed DeleteAllowed page property from Yes to No
    // BC Upgrade MISHRS14 <<

    DeleteAllowed = false; //HEI.06 //BC Upgrade GUNREM01 added 

    layout
    {

        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the production order.', FRA = 'Spécifie le numéro de l''ordre de fabrication.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the description of the production order.', FRA = 'Spécifie la description de l''ordre de fabrication.';
        }
        modify("Source No.")
        {
            ToolTipML = ENU = 'Specifies the source number of the production order.', FRA = 'Spécifie le numéro origine de l''ordre de fabrication.';
        }
        modify("Routing No.")
        {
            ToolTipML = ENU = 'Specifies the routing number used for this production order.', FRA = 'Spécifie le numéro gamme utilisé pour cet ordre de fabrication.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies how many units of the item or the family to produce (production quantity).', FRA = 'Spécifie le nombre d''unités de l''article ou de la famille produits à produire (quantité de production).';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for the dimension associated with the production order.', FRA = 'Spécifie le code de la section analytique associée à l''ordre de fabrication.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for the dimension associated with the production order.', FRA = 'Spécifie le code de la section analytique associée à l''ordre de fabrication.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location code to which you want to post the finished product from this production order.', FRA = 'Spécifie le code magasin sur lequel le produit fini doit être validé à partir de cet ordre de fabrication.';
        }
        //BC Upgrade GUNREM >> In BC these fields names change as "Starting Date-Time"  and  "Ending Date-Time"
        // modify("Starting Time")
        // {
        //     ToolTipML = ENU = 'Specifies the starting time of the production order.', FRA = 'Spécifie l''heure de début de l''ordre de fabrication.';
        // }
        // modify("Starting Date")
        // {
        //     ToolTipML = ENU = 'Specifies the starting date of the production order.', FRA = 'Spécifie la date de début de l''ordre de fabrication.';
        // }
        // modify("Ending Time")
        // {
        //     ToolTipML = ENU = 'Specifies the ending time of the production order.', FRA = 'Spécifie l''heure de fin de l''ordre de fabrication.';
        // }
        // modify("Ending Date")
        // {
        //     ToolTipML = ENU = 'Specifies the ending date of the production order.', FRA = 'Spécifie la date de fin de l''ordre de fabrication.';
        // }

        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies the due date of the production order.', FRA = 'Spécifie la date d''échéance de l''ordre de fabrication.';
        }
        modify("Assigned User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user who is responsible for the document.', FRA = 'Spécifie le code de l''utilisateur qui est responsable du document.';
        }
        modify("Finished Date")
        {
            ToolTipML = ENU = 'Specifies the actual finishing date of a finished production order.', FRA = 'Spécifie la date de réalisation réelle d''un ordre de fabrication terminé.';
        }
        modify(Status)
        {
            ToolTipML = ENU = 'Specifies the status of the production order.', FRA = 'Spécifie le statut de l''ordre de fabrication.';
        }
        modify("Search Description")
        {
            ToolTipML = ENU = 'Specifies the search description.', FRA = 'Spécifie la description de recherche.';
        }
        modify("Last Date Modified")
        {
            ToolTipML = ENU = 'Specifies when the production order card was last modified.', FRA = 'Indique la date à laquelle la fiche ordre de fabrication a été modifiée pour la dernière fois.';
        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Specifies a bin to which you want to post the finished items.', FRA = 'Spécifie un emplacement sur lequel vous souhaitez valider les articles terminés.';
        }
        addafter("No.")
        {
            //BC Upgrade Kamnay01>>field added

            field("Unit of Measure Code"; Rec."Unit of Measure Code FND")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Unit of Measure Code',
                            FRA = 'Code de l''unité de mesure';
            }
            //BC Upgrade Kamnay01>>field added

            field(Blocked; Rec.Blocked)
            {
                ApplicationArea = All;
                Caption = 'Admin. Completed'; //HEI.05
            }
            //  BC upgrade GUNREM01 >> unCommented DIT Field >>
            field("Gyle No."; Rec."Gyle No. FND")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Ref No.',
                            FRA = 'Gyle N°';
            }
            //  BC upgrade GUNREM01 >> unCommented DIT Field <<
            //BC Upgrade GUNREM01 >> added field in page level
            field("Starting Date"; Rec."Starting Date")
            {
                ApplicationArea = all;
            }
            field("Starting Time"; Rec."Starting Time")
            {
                ApplicationArea = all;
            }
            field("Ending Date"; Rec."Ending Date")
            {
                ApplicationArea = all;
            }
            field("Ending Time"; Rec."Ending Time")
            {
                ApplicationArea = all;
            }
            //BC Upgrade GUNREM01 << added field in page level
            //BC upgrade GUNREM01 >> Commented Drink-IT code
            // field("Gyle No."; "Gyle No.")
            // {
            //     CaptionML = ENU = 'Ref No.',
            //                 FRA = 'Gyle N°';
            // }
            //BC upgrade GUNREM01 >> Commented Drink-IT code
        }
        //BC upgrade GUNREM01 >> Commented Drink-IT code
        /*   addafter("Routing No.")
           {
               field("Routing Version Code"; "Routing Version Code")
               {
                   Visible = false;
               }
               field("Routing Version Description"; "Routing Version Description")
               {
                   Visible = false;
               }
               field("Production BOM No."; "Production BOM No.")
               {
                   Visible = false;
               }
               field("Production BOM Version Code"; "Production BOM Version Code")
               {
                   Visible = false;
               }
               field("Production BOM Version Desc."; "Production BOM Version Desc.")
               {
                   Visible = false;
               }
           }
           
        addafter(Quantity)
        {
            field("Unit of Measure Code"; "Unit of Measure Code")
            {
            }
            field("Quantity (Base)"; "Quantity (Base)")
            {
            }
            field("Quantity HL"; "Quantity HL")
            {
            }
        }
        */ //BC upgrade GUNREM01 << Commented Drink-IT code
        addafter("Bin Code")
        {
            //BC upgrade GUNREM01 >> Commented Drink-IT code
            // field("Responsibility Center"; "Responsibility Center")
            // {
            //     Importance = Additional;
            //     QuickEntry = false;
            // }
            // field("Physical Location Group Code"; "Physical Location Group Code")
            // {
            //     Importance = Additional;
            //     QuickEntry = false;
            // }

            // field("<decFinishedQty>"; decFinishedQty)
            // {
            //     Caption = 'Finished Quantity';
            //     DecimalPlaces = 0 : 5;
            //     Description = 'NRQ#84282';
            //     Editable = false;
            //     ApplicationArea = All;
            // }
            //BC upgrade GUNREM01 << Commented Drink-IT code
            field("Lot No"; LotNo)
            {
                ApplicationArea = All;
            }
            field("Created By"; Rec."Created By FND")
            {
                ApplicationArea = All;
            }
        }
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
        modify("Production Order - Picking List")
        {
            CaptionML = ENU = 'Production Order - Picking List', FRA = 'Ordre de fabrication - Liste des prélèvements';
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
        addafter("Production Order Statistics")
        {
            action(ProcessOrderGoodsMovement)
            {
                Caption = 'Process Order Goods Movement';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                ApplicationArea = All;

                trigger OnAction();
                var
                    ProductionOrder: Record "Production Order";
                begin
                    //HEI.01>>
                    ProductionOrder.RESET();
                    ProductionOrder.SETRANGE(ProductionOrder.Status, Rec.Status);
                    ProductionOrder.SETRANGE(ProductionOrder."No.", Rec."No.");
                    //  REPORT.RUN(50003, true, true, ProductionOrder); //BC upgrade GUNREM01 commented
                    Report.Run(Report::"Process Order Goods Movement", true, true, ProductionOrder); // BC upgrade GUNREM01
                    //HEI.01<<
                end;
            }
        }
    }

    //BC Upgrade GUNREM01 >> code added 
    trigger OnOpenPage()
    begin
        //HEI.04>>
        TileRespCenterFilter := Rec.GETFILTER("Role Centre Tile Code FND");
        if TileRespCenterFilter <> '' then begin
            Rec.FILTERGROUP(2);
            Rec.SETFILTER("Role Centre Tile Code FND", TileRespCenterFilter);
            Rec.FILTERGROUP(0);
        end;
        //HEI.04<<s
    end;

    trigger OnAfterGetRecord()
    begin
        //HEI.02>>
        LotNo := HeinekenGlobal.GetLotItemTracking(Rec."No.");
        //HEI.02<<
    end;

    //BC Upgrade GUNREM01 << code added 
    var
        UserMgt: Codeunit "User Setup Management";
        decFinishedQty: Decimal;
        LotNo: Text[50];
        HeinekenGlobal: Codeunit "Heineken Global";
        TileRespCenterFilter: Text;


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //begin
    /*
    //HEI.02>>
    LotNo := HeinekenGlobal.GetLotItemTracking(Rec."No.");
    //HEI.02<<

    //<< DITW111.00.13 ISL 13/09/2018 NRQ#84282
    decFinishedQty := fctCalcQuantityFinished();
    //>> DITW111.00.13 ISL NRQ#84282
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //begin
    /*

    //<< DITW111.00.13 ISL 13/09/2018 NRQ#84282
    decFinishedQty := 0;
    //>> DITW111.00.13 ISL NRQ#84282
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
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
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

