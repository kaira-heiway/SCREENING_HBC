pageextension 54017 FinishProductionOrderExt extends "Finished Production Order"
{
    // version NAVW110.0,MANXL7.00,DITW110.00.12,HEI.06
    //     HEI.01 FDD-PRDGAP039 IBM.HORTOC01 13/07/2017
    //   # Page action ProcessOrderGoodsMovement

    // HEI.02 CHG0270593 - IBM ISYED01 2.15.2019
    //   # Removed Caption Class ('2035140,1') to "Gyle no" to display on the page.

    // HEI.03 CHG2069358 IBM.AK 25.08.20
    //  # new field added on -"Created By"
    // HEI.04 CHG2070663 IBM POENAB02 18.09.2020 Role Centre Production Bottling Role Centre
    //   # Code added in OnClosePage
    // HEI.05 CHG2098891 IBM.LS      19.07.2021
    //   # Added Field - Blocked (Caption: Admin. Completed)
    // HEI.06 CHG2256714 HB3991 IBM VERMAA03 18.07.2024
    //         # Changed DeleteAllowed page property from Yes to No
    // HEI.07 CHG2251257 SHARMP16 11.06.2025 -CC- the amount excluding VAT disappear when we change the VAT INC5132780 - Rollback Q
    //   # Changed DeleteAllowed page property from No to Yes
    // HEI.08 CHG2311960 SHARMP16 22.07.2025 CC incident link to INC5040545 - Development
    //   # Changed DeleteAllowed page property from Yes to No
    //******************************************************************************
    //BC UPGRADE PATHAA02-06.01.26
    //DIT fields and variables commented
    //Action Losses commented-BC UPGRADE PATHAA02-P2035247
    //HEI.01-Done; HEI.02-DIT;HEI.03-"Created By" field added;
    //HEI.04-OnClosePage code added; 
    //HEI.05-Blocked field caption changed to 'Admin. Completed';
    //HEI.06-HEI.08-Property added;

    DeleteAllowed = false; //BC UPGRADE PATHAA02- HEI.06,07,08  

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the production order.', FRA = 'Spécifie le numéro de l''ordre de fabrication.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the description of the production order.', FRA = 'Spécifie la description de l''ordre de fabrication.';
        }
        modify("Description 2")
        {
            ToolTipML = ENU = 'Specifies an additional part of the production order description.', FRA = 'Spécifie un complément à la description de l''ordre de fabrication.';
        }
        modify("Source Type")
        {
            ToolTipML = ENU = 'Specifies the source type of the production order.', FRA = 'Spécifie le type origine de l''ordre de fabrication.';
        }
        modify("Source No.")
        {
            ToolTipML = ENU = 'Specifies the source number of the production order.', FRA = 'Spécifie le numéro origine de l''ordre de fabrication.';
        }
        modify("Search Description")
        {
            ToolTipML = ENU = 'Specifies the search description.', FRA = 'Spécifie la description de recherche.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies how many units of the item or the family to produce (production quantity).', FRA = 'Spécifie le nombre d''unités de l''article ou de la famille produits à produire (quantité de production).';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies the due date of the production order.', FRA = 'Spécifie la date d''échéance de l''ordre de fabrication.';
        }
        modify("Last Date Modified")
        {
            ToolTipML = ENU = 'Specifies when the production order card was last modified.', FRA = 'Indique la date à laquelle la fiche ordre de fabrication a été modifiée pour la dernière fois.';
        }
        modify(Schedule)
        {
            CaptionML = ENU = 'Schedule', FRA = 'Planifié';
        }
        //BC UPGRADE PATHAA02-moved to addafter "Source No.">>      
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
        //BC UPGRADE PATHAA02-moved to addafter "Source No."<<


        modify(Posting)
        {
            CaptionML = ENU = 'Posting', FRA = 'Validation';
        }
        modify("Inventory Posting Group")
        {
            ToolTipML = ENU = 'Specifies the inventory posting group in order to assign the WIP to the correct general ledger account.', FRA = 'Spécifie le groupe comptabilisation stock pour affecter les TEC au compte général qui convient.';
        }
        modify("Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies a product posting group associated with manufactured items in this production order.', FRA = 'Indique un groupe comptabilisation produit auquel appartiennent des articles fabriqués dans cet ordre de fabrication.';
        }
        modify("Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies a business posting group.', FRA = 'Spécifie un groupe comptabilisation marché.';
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

        //Unsupported feature: CodeInsertion on ""Location Code"(Control 42)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
        if "Location Code" <> xRec."Location Code" then
          CurrPage.UPDATE(true);
        // >>DITW18.00.06 MSF DIT-770 #1192
        */
        //end;

        addafter("Source No.")
        {
            // field("Revision No."; Rec."Revision No.") //BC UPGRADE PATHAA02-DIT-F2036312
            // {
            //     Description = 'MANXL7.00.001';
            //     Editable = false;
            // }
            field("Routing No."; Rec."Routing No.")
            {
                Description = 'DITW110.00.12A NRQ#68221';
                ApplicationArea = all;//BC UPGRADE PATHAA02
            }
            //BC UPGRADE PATHAA02>>
            field("Starting Date"; rec."Starting Date")
            {
                ToolTipML = ENU = 'Specifies the starting date of the production order.', FRA = 'Spécifie la date de début de l''ordre de fabrication.';
                ApplicationArea = all;//BC UPGRADE PATHAA02
            }
            field("Ending Time"; rec."Ending Time")
            {
                ToolTipML = ENU = 'Specifies the ending time of the production order.', FRA = 'Spécifie l''heure de fin de l''ordre de fabrication.';
                ApplicationArea = all;//BC UPGRADE PATHAA02
            }
            field("Ending Date"; rec."Ending Date")
            {
                ToolTipML = ENU = 'Specifies the ending date of the production order.', FRA = 'Spécifie la date de fin de l''ordre de fabrication.';
                ApplicationArea = all;//BC UPGRADE PATHAA02
            }
            //BC UPGRADE PATHAA02<<

            // field("Routing Version Code"; Rec."Routing Version Code") //BC UPGRADE PATHAA02-DIT-F2035270
            // {
            // }
            // field("Routing Version Description"; Rec."Routing Version Description") //BC UPGRADE PATHAA02-DIT-F2035271
            // {
            //     Importance = Additional;
            // }
            // field("Production BOM No."; Rec."Production BOM No.")//BC UPGRADE PATHAA02-DIT-F2035272
            // {
            // }
            // field("Production BOM Version Code"; Rec."Production BOM Version Code")//BC UPGRADE PATHAA02-F2035273
            // {
            // }
            // field("Production BOM Version Desc."; Rec."Production BOM Version Desc.")//BC UPGRADE PATHAA02-F2035274
            // {
            //     Importance = Additional;
            // }
        }
        addafter("Search Description")
        {
            // field("Unit of Measure Code"; Rec."Unit of Measure Code")//BC UPGRADE PATHAA02-F2014420
            // {
            // }
        }
        addafter(Quantity)
        {
            // field("Quantity (Base)"; Rec."Quantity (Base)" //BC UPGRADE PATHAA02-F2014422
            // {
            //     Importance = Additional;
            // }
            // field("Quantity HL"; Rec."Quantity HL") //BC UPFRADE PATHAA02-F2014424
            // {
            // }
        }
        addafter("Due Date")
        {
            field(Blocked; Rec.Blocked)
            {
                CaptionML = ENU = 'Admin. Completed',
                            FRA = 'Administratif terminé'; //HEI.05
                ApplicationArea = all;//BC UPGRADE PATHAA02
            }
            //BC Upgrade GUNREM01 >> added DIT field
            field("Gyle No."; Rec."Gyle No. FND")
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Ref No.',
                            FRA = 'Gyle N°';
            }
            //BC Upgrade GUNREM01 << added DIT field
        }
        addafter("Last Date Modified")
        {
            // field("Gyle No."; Rec."Gyle No.") //BC UPGRADE PATHAA02-DIT-F2035172
            // {
            //     CaptionML = ENU = 'Ref No.',
            //                 FRA = 'Gyle N°';
            //     Editable = false;
            // }
            // field("Responsibility Center"; Rec."Responsibility Center")//BC UPGRADE PATHAA02-DIT-F2014410
            // {

            //     trigger OnValidate();
            //     begin
            //         // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
            //         if "Responsibility Center" <> xRec."Responsibility Center" then
            //             CurrPage.UPDATE(true);
            //         // >>DITW18.00.06 MSF DIT-770 #1192
            //     end;
            // }
            // field("Physical Location Group Code"; Rec."Physical Location Group Code") //BC UPGRADE PATHAA02-F2014411
            // {
            //     Importance = Additional;

            //     trigger OnValidate();
            //     begin
            //         // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
            //         if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
            //             CurrPage.UPDATE(true);
            //         // >>DITW18.00.06 MSF DIT-770 #1192
            //     end;
            // }
            field("Created By"; Rec."Created By FND")//HEI.03
            {
                ApplicationArea = all;//BC UPGRADE PATHAA02
            }
        }
        addafter(Posting)
        {
            group(Head)
            {
                CaptionML = ENU = 'Head',
                            FRA = 'En-tête';
                Description = 'MANXL7.00.001';
                // field("Item Category Code"; "Item Category Code")//BC UPGRADE PATHAA02-DIT-F2036301
                // {
                //     Description = 'MANXL7.00.001';
                // }
                // field("Item Product Group Code"; "Item Product Group Code")//BC UPGRADE PATHAA02-DIT-F2036302
                // {
                //     Description = 'MANXL7.00.001';
                // }
                // field("Planning Group"; "Planning Group") //BC UPGRADE PATHAA02-DIT-F2036303
                // {
                //     Description = 'MANXL7.00.001';
                // }
                // field("Production Group"; "Production Group")//BC UPGRADE PATHAA02-DIT-F2036304
                // {
                //     Description = 'MANXL7.00.001';
                // }
            }
            group(Quality)
            {
                CaptionML = ENU = 'Quality',
                            FRA = 'Qualité';
                // field("No. of Lot Tests"; "No. of Lot Tests")//BC UPGRADE PATHAA02-DIT-F2035093
                // {
                // }
                // field("No. of In Process Tests"; "No. of In Process Tests")//BC UPGRADE PATHAA02-F2035094
                // {
                // }
            }
        }
    }
    actions
    {
        modify("O&rder")
        {
            CaptionML = ENU = 'O&rder', FRA = '&Commande';
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
            Promoted = true;
            PromotedCategory = Process;
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
        modify("Registered P&ick Lines")
        {
            CaptionML = ENU = 'Registered P&ick Lines', FRA = '&Lignes prélèvement enreg.';
        }
        modify("<Action2>")
        {
            CaptionML = ENU = 'Registered Invt. M&ovement Lines', FRA = 'Lignes m&ouvement stock enreg.';
            Promoted = true;
            PromotedCategory = Process;
        }
        addafter("<Action2>")
        {
            separator(Separator1100183004)
            {
            }
            // action(Losses)
            // {
            //     CaptionML = ENU = 'Losses',
            //                 FRA = 'Pertes';
            //     Image = GainLossEntries;

            //     trigger OnAction();
            //     var
            //         CapacityLedgerEntry: Record "Capacity Ledger Entry";
            //         BrewingLosses: Page "Brewing Losses"; //BC UPGRADE PATHAA02-P2035247
            //     begin
            //         // <<DITW17.00.01 KCO 18/03/2013 DIT-770 #001
            //         CapacityLedgerEntry.SETRANGE("Order Type", CapacityLedgerEntry."Order Type"::Production);
            //         CapacityLedgerEntry.SETRANGE("Order No.", "No.");
            //         // >>DITW17.00.01 KCO DIT-770 #001
            //         BrewingLosses.SETTABLEVIEW(CapacityLedgerEntry);
            //         BrewingLosses.RUNMODAL;
            //     end;
            // }
            action(ProcessOrderGoodsMovement)
            {
                Caption = 'Process Order Goods Movement';
                Image = "Report";
                Promoted = false;
                ApplicationArea = All;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";

                trigger OnAction();
                var
                    ProductionOrder: Record "Production Order";
                begin
                    //HEI.01>>
                    ProductionOrder.RESET;
                    ProductionOrder.SETRANGE(ProductionOrder.Status, Rec.Status);
                    ProductionOrder.SETRANGE(ProductionOrder."No.", Rec."No.");
                    //REPORT.RUN(50003, true, true, ProductionOrder);//BC UPGRADE PATHAA02
                    REPORT.RUN(Report::"Process Order Goods Movement", true, true, ProductionOrder);//BC UPGRADE PATHAA02
                    //HEI.01<<
                end;
            }
        }
    }

    var
    //UserMgt: Codeunit "User Setup Management";//BC UPGRADE PATHAA02-Not used


    //Unsupported feature: CodeInsertion on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //begin
    /*
    // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
    SETFILTER("Resp. Center Table Filter",UserMgt.GetRespCenterFilter(3,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Phys. Location Table Filter",UserMgt.GetRespPhysLocationFilter(3,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Location Table Filter",UserMgt.GetRespLocationFilter(3,"Responsibility Center","Physical Location Group Code","Location Code"));
    // >>DITW18.00.06 MSF DIT-770 #1192
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnClosePage". Please convert manually.
    //BC UPGRADE PATHAA02>>
    trigger OnClosePage();
    begin
        //HEI.04>>
        Rec.UpdateTileCode;
        Rec.MODIFY;
        //HEI.04<<
    end;
    //BC UPGRADE PATHAA02<<


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //begin
    /*
    // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
    SetSecurityFilterOnRespCenter();
    // >>DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

