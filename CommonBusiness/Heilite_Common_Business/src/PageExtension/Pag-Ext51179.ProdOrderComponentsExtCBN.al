pageextension 51179 ProdOrderComponentsExtCBN extends "Prod. Order Components"
{
    // version NAVW110.0.00.16177,MANXL7.00,DITW110.00.08,HEI.01

    //     DITW14.00.00.8 PROD: BrewIt & Quality

    // MANXL7.00.001 DAT 26/02/2014 #5: Manufacturing XL Autoreserve + Annulation for Prod. Order Comp
    // MANXL7.00.001 DAT 03/03/2014 #12: Version Management
    // MANXL7.00.001 DAT 04/03/2014 #13: Prod. Order KPI's in overview screen
    // MANXL7.00.001 DAT 04/03/2014 #14: Production components availability
    // MANXL7.00.001 WSA 11/07/2014 #87: Added code MANXL security

    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    //       DITW110.00.12A HBA 07/06/2018 NRQ#51782 Added field Production jnl. flushing 2035266
    // HEI.01 FDD PRDGAPID003 & PRDGAP027 IBM.NAIKH01 25.07.2017
    //   # Added a new field "Lot No.".
    // HEI.02 FDD-PRDGAP024 IBM SOICAD01 25.07.2017 #Zone code development without whs advanced mgmt
    //   #new fields Zone Code
    // HEI.03 FDD PRDGAPID003 IBM.NAIKH01 14.08.2017
    //   # Changed the "SourceTableView : = sorting(Item No.,Variant Code,Location Code,Status,Due Date) ORDER(Ascending)" in the page property

    // Bc Upgrade YADAVM09 Drink it Fields and action commented.
    //Bc Upgrade YADAVM09 base page action Item tracking line visible false and add Action Item tracking line2
    //Bc Upgrade YADAVM09 Source table view property handled on on open page trigger.
    //*************************************************************************
    //HEI.04 BC UPGRADE PATHAA02 11.03.26 FDD-DTW002 # Functionality- "Production jnl. flushing" 
    //Field "Production jnl. flushing" added after Flushing method.
    layout
    {
        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item that is a component in the production order component list.', FRA = 'Spécifie le numéro de l''article qui est un composant de la liste de composants de l''ordre de fabrication.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the variant code when you calculate the production order.', FRA = 'Spécifie le code variante lors du calcul de l''ordre de fabrication.';
        }
        modify("Due Date-Time")
        {
            ToolTipML = ENU = 'Specifies the due date and the due time, which are combined in a format called "due date-time".', FRA = 'Spécifie la date et l''heure d''échéance combinées au format « date/heure d''échéance ».';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Copies the date from the Starting Date on the production order line associated with the component.', FRA = 'Copie la date à partir de la date de début sur la ligne d''ordre de fabrication associée au composant.';
        }
        modify(Description)
        {
            Editable = false;//BC Upgrade YADAVM09
            ToolTipML = ENU = 'Copies the description from the corresponding field in the production BOM when you calculate the production order.', FRA = 'Copie la description à partir du champ correspondant de la nomenclature production lorsque vous calculez l''ordre de fabrication.';
        }
        modify("Scrap %")
        {
            ToolTipML = ENU = 'Specifies the scrap percentage when you calculate the production order.', FRA = 'Spécifie le taux de rebut lors du calcul de l''ordre de fabrication.';
        }
        modify("Calculation Formula")
        {
            ToolTipML = ENU = 'Copies the calculation formula from the corresponding field in the production BOM when you calculate the production order.', FRA = 'Copie la formule de calcul du champ correspondant de la nomenclature production lorsque vous calculez l''ordre de fabrication.';
        }
        modify(Length)
        {
            ToolTipML = ENU = 'Copies the value in this field from the corresponding field in the production BOM when you calculate the production order.', FRA = 'Copie la valeur de ce champ à partir du champ correspondant de la fiche nomenclature de production lorsque vous calculez l''ordre de fabrication.';
        }
        modify(Width)
        {
            ToolTipML = ENU = 'Copies the value in this field from the corresponding field in the production BOM when you calculate the production order.', FRA = 'Copie la valeur de ce champ à partir du champ correspondant de la fiche nomenclature de production lorsque vous calculez l''ordre de fabrication.';
        }
        modify(Weight)
        {
            ToolTipML = ENU = 'Copies the value in this field from the corresponding field in the production BOM when you calculate the production order.', FRA = 'Copie la valeur de ce champ à partir du champ correspondant de la fiche nomenclature de production lorsque vous calculez l''ordre de fabrication.';
        }
        modify(Depth)
        {
            ToolTipML = ENU = 'Copies the value in this field from the corresponding field in the production BOM when you calculate the production order.', FRA = 'Copie la valeur de ce champ à partir du champ correspondant de la fiche nomenclature de production lorsque vous calculez l''ordre de fabrication.';
        }
        modify("Quantity per")
        {
            ToolTipML = ENU = 'Copies the value in this field from the corresponding field in the production BOM when you calculate the production order.', FRA = 'Copie la valeur de ce champ à partir du champ correspondant de la fiche nomenclature de production lorsque vous calculez l''ordre de fabrication.';
        }
        modify("Reserved Quantity")
        {
            ToolTipML = ENU = 'Specifies how many units of this item have been reserved.', FRA = 'Spécifie le nombre d''unités de cet article qui ont été réservées.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Copies the code from the corresponding field in the production BOM when you calculate the production order.', FRA = 'Copie le code de calcul du champ correspondant de la nomenclature production lorsque vous calculez l''ordre de fabrication.';
        }
        modify("Flushing Method")
        {
            ToolTipML = ENU = 'Specifies how consumption of the component is manually or automatically posted (flushed).', FRA = 'Spécifie la manière dont la consommation du composant est validée manuellement ou automatiquement (consommée).';
        }
        modify("Expected Quantity")
        {
            ToolTipML = ENU = 'Specifies the quantity of the component expected to be consumed during the production of the quantity on this line.', FRA = 'Spécifie la quantité du composant que vous vous attendez à consommer pendant la production de la quantité de cette ligne.';
        }
        modify("Remaining Quantity")
        {
            ToolTipML = ENU = 'Specifies the remaining quantity of the component to be consumed during the production of the quantity on the production order line.', FRA = 'Spécifie la quantité restante du composant que vous vous attendez à consommer pendant la production de la quantité de la ligne d''ordre de fabrication.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Copies the dimension value code from the corresponding field in the production BOM when you calculate the production order.', FRA = 'Copie le code section analytique à partir du champ correspondant de la nomenclature production lorsque vous calculez l''ordre de fabrication.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Copies the dimension value code from the corresponding field in the production BOM when you calculate the production order.', FRA = 'Copie le code section analytique à partir du champ correspondant de la nomenclature production lorsque vous calculez l''ordre de fabrication.';
        }
        modify("Routing Link Code")
        {
            ToolTipML = ENU = 'Specifies the routing link code when you calculate the production order.', FRA = 'Spécifie le code lien gamme lors du calcul de l''ordre de fabrication.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Copies the location code from the corresponding field on the production order line.', FRA = 'Copie le code magasin à partir du champ correspondant de la ligne d''ordre de fabrication.';
        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Specifies the bin in which the component is to be placed before it is consumed.', FRA = 'Spécifie l''emplacement dans lequel le composant doit être placé pour être consommé.';
        }
        modify("Unit Cost")
        {
            ToolTipML = ENU = 'Copies the amount from the corresponding field on the component''s item card.', FRA = 'Copie le montant à partir du champ correspondant de la fiche article du composant.';
        }
        modify("Cost Amount")
        {
            ToolTipML = ENU = 'Calculates the amount as the Unit Cost multiplied by the Quantity.', FRA = 'Calcule le montant en multipliant le coût unitaire par la quantité.';
        }
        modify(Position)
        {
            ToolTipML = ENU = 'Copies the position code from the production BOM when you calculate the production order.', FRA = 'Copie le code position à partir de la nomenclature de production lorsque vous calculez l''ordre de fabrication.';
        }
        modify("Position 2")
        {
            ToolTipML = ENU = 'Copies the position code from the production BOM when you calculate the production order.', FRA = 'Copie le code position à partir de la nomenclature de production lorsque vous calculez l''ordre de fabrication.';
        }
        modify("Position 3")
        {
            ToolTipML = ENU = 'Copies the position code from the production BOM when you calculate the production order.', FRA = 'Copie le code position à partir de la nomenclature de production lorsque vous calculez l''ordre de fabrication.';
        }
        modify("Lead-Time Offset")
        {
            ToolTipML = ENU = 'Copies the lead-time offset from the corresponding field in the production BOM when you calculate the production order.', FRA = 'Copie le décalage du délai à partir du champ correspondant de la nomenclature production lorsque vous calculez l''ordre de fabrication.';
        }
        modify("Qty. Picked")
        {
            ToolTipML = ENU = 'Specifies the quantity of the item you have picked for the component line.', FRA = 'Spécifie la quantité d''article déjà prélevée pour la ligne composant.';
        }
        modify("Qty. Picked (Base)")
        {
            ToolTipML = ENU = 'Specifies the quantity of the item you have picked for the component line.', FRA = 'Spécifie la quantité d''article déjà prélevée pour la ligne composant.';
        }
        modify("Substitution Available")
        {
            ToolTipML = ENU = 'Specifies if an item substitute is available for the production order component.', FRA = 'Indique si un article de substitution est disponible pour le composant O.F.';
        }
        /* Bc Upgrade YADAVM09>>
                addafter("Variant Code")
                {
                    field("Revision No."; "Revision No.")
                    {
                        Description = 'MANXL7.00.001';
                        Visible = false;
                    }
                }
                addafter("Due Date")
                {
                    field(tbxReplenishmentStatus; txtReplenishmentStatus)
                    {
                        CaptionML = ENU = 'Replenishment Status',
                                    FRA = 'Etat Réapprovisionnement';
                        Description = 'MANXL7.00.001';
                        Editable = false;
                        Style = Attention;
                        StyleExpr = blnNoStock;

                        trigger OnAssistEdit();
                        var
                            lpgeOrderTracking: Page "Order Tracking";
                        begin
                            //<<MANXL7.00.001 WSA 11/07/2014 #87
                            if rMANXLSetup.READPERMISSION then begin
                                //>>MANXL7.00.001 WSA 11/07/2014 #87
                                //<<MANXL7.00.001 DAT 04/03/2014 #14
                                lpgeOrderTracking.SetProdOrderComponent(Rec);
                                lpgeOrderTracking.RUNMODAL;
                                //>>MANXL7.00.001 DAT 04/03/2014 #14
                                //<<MANXL7.00.001 WSA 11/07/2014 #87
                            end;
                            //>>MANXL7.00.001 WSA 11/07/2014 #87
                        end;
                    }
                }
                

        addafter("Flushing Method")
        {
           
           field("Production jnl. flushing"; "Production jnl. flushing")
           {
           }
          
        }
          */ //Bc Upgrade YADAVM09 Drink it field<<

        addafter("Flushing Method")
        {
            field("Production jnl. flushing"; Rec."Production jnl. flushing FND")
            {
                ApplicationArea = All;
                Description = 'HEI.04';
            }

        }
        addafter("Location Code")
        {
            field("Zone Code"; Rec."Zone Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zone Code field.';
            }
        }
        addafter("Substitution Available")
        {
            /* //Bc Upgrade YADAVM09>>
           field(Critical; Critical)
           {
               Description = 'MANXL7.00.001';
           }
           */ //Bc Upgrade YADAVM09<<
            field("Lot No."; Rec."Lot No. FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Lot No. field.';
            }
        }

    }
    actions
    {
        //Bc Upgrade YADAVM09>>
        addafter(Dimensions)
        {
            action("Item &Tracking Lines2")
            {
                ApplicationArea = ItemTracking;
                // Caption = 'Item &Tracking Lines';
                Image = ItemTrackingLines;
                ShortCutKey = 'Ctrl+Alt+I';
                ToolTip = 'View or edit serial, lot and package numbers that are assigned to the item on the document or journal line.';
                CaptionML = ENU = 'Item &Tracking Lines', FRA = '&Lignes traçabilité';
                trigger OnAction()
                begin
                    Rec.OpenItemTrackingLines2();
                end;
            }
        }
        //Bc Upgrade YADAVM09<<
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify("Item Availability by")
        {
            CaptionML = ENU = 'Item Availability by', FRA = 'Disponibilité article par';
        }
        modify("Event")
        {
            CaptionML = ENU = 'Event', FRA = 'Événement';
        }
        modify(Period)
        {
            CaptionML = ENU = 'Period', FRA = 'Période';
        }
        modify(Variant)
        {
            CaptionML = ENU = 'Variant', FRA = 'Variante';
        }
        modify(Location)
        {
            CaptionML = ENU = 'Location', FRA = 'Magasin';
        }
        modify("BOM Level")
        {
            CaptionML = ENU = 'BOM Level', FRA = 'Niveau nomenclature';
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
        modify(ItemTrackingLines)
        {
            Visible = false;//Bc Upgrade MYADAV09
            CaptionML = ENU = 'Item &Tracking Lines', FRA = '&Lignes traçabilité';
        }
        modify("Bin Contents")
        {
            CaptionML = ENU = 'Bin Contents', FRA = 'Contenu emplacement';
            Promoted = true;
            PromotedCategory = Process;
        }
        modify(SelectItemSubstitution)
        {
            CaptionML = ENU = '&Select Item Substitution', FRA = '&Sélectionner article de substitution';
        }
        modify("Put-away/Pick Lines/Movement Lines")
        {
            CaptionML = ENU = 'Put-away/Pick Lines/Movement Lines', FRA = 'Lignes rangement/prélèvement/mouvement';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(Reserve)
        {
            CaptionML = ENU = '&Reserve', FRA = '&Réserver';
        }
        modify(OrderTracking)
        {
            CaptionML = ENU = 'Order &Tracking', FRA = '&Chaînage';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
        }
        /* //Bc Upgrade YADAVM09 Drink it action commented>>
        addafter(Reserve)
        {
            
            action("Auto Reserve")
            {
                CaptionML = ENU = 'Auto Reserve',
                            FRA = 'Réservation Automatique';
                Description = 'MANXL7.00.001';
                Image = AutoReserve;

                trigger OnAction();
                begin
                    //<<MANXL7.00.001 DAT 26/02/2014 #5
                    if FINDSET then
                        repeat
                            AutoReserve2;
                        until NEXT = 0;
                    //>>MANXL7.00.001 DAT 26/02/2014 #5
                end;
            }
            /* //Bc Upgrade YADAVM09>>
            action("Cancel Reservations")
            {
                CaptionML = ENU = 'Cancel Reservations',
                            FRA = 'Annuler Réservation';
                Description = 'MANXL7.00.001';

                trigger OnAction();
                begin
                    //<<MANXL7.00.001 DAT 26/02/2014 #4
                    if FINDSET then
                        repeat
                            CancelReserve2;
                        until NEXT = 0;
                    //>>MANXL7.00.001 DAT 26/02/2014 #4
                end;
            }
            

        }*/ //Bc Upgrade YADAVM09 Drink it action commented<<


    }


    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You cannot reserve components with status %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You cannot reserve components with status %1.;FRA=Vous ne pouvez pas réserver de composants qui ont le statut %1.;
    //Variable type has not been exported.
    //Bc Upgrade YADAVM09>>
    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("Item No.", "Variant Code", "Location Code", Status, "Due Date");
        Rec.Ascending(true);
    end;
    //Bc Upgrade YADAVM09<<

    var
        cduOrderTrackingMgmt: Codeunit OrderTrackingManagement;

        blnNoStock: Boolean;
        txtReplenishmentStatus: Text[80];
        txt2036301: TextConst ENU = 'No information available', FRA = 'Pas d''inv.';
    //rMANXLSetup: Record "Manufacturing XL Setup"; //Bc Upgrade YADAVM09


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ShowShortcutDimCode(ShortcutDimCode);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ShowShortcutDimCode(ShortcutDimCode);
    //<<MANXL7.00.001 WSA 11/07/2014 #87
    if rMANXLSetup.READPERMISSION then begin
    //>>MANXL7.00.001 WSA 11/07/2014 #87
      //<<MANXL7.00.001 DAT 04/03/2014 #14
      txtReplenishmentStatus:= '';
      CLEAR(cduOrderTrackingMgmt);
      txtReplenishmentStatus:= cduOrderTrackingMgmt.CalculateStatusString(cduOrderTrackingMgmt.CalculateProdCompStatus(Rec));
      blnNoStock:= (STRPOS(txtReplenishmentStatus,txt2036301) <> 0);
      //>>MANXL7.00.001 DAT 04/03/2014 #14
    //<<MANXL7.00.001 WSA 11/07/2014 #87
    end;
    //>>MANXL7.00.001 WSA 11/07/2014 #87
    */
    //end;


    //Unsupported feature: CodeModification on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CLEAR(ShortcutDimCode);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CLEAR(ShortcutDimCode);
    //<<MANXL7.00.001 WSA 11/07/2014 #87
    if rMANXLSetup.READPERMISSION then begin
    //>>MANXL7.00.001 WSA 11/07/2014 #87
      //<<MANXL7.00.001 DAT 04/03/2014 #14
      txtReplenishmentStatus:= '';
      blnNoStock:= false;
      //>>MANXL7.00.001 DAT 04/03/2014 #14
    //<<MANXL7.00.001 WSA 11/07/2014 #87
    end;
    //>>MANXL7.00.001 WSA 11/07/2014 #87
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



}

