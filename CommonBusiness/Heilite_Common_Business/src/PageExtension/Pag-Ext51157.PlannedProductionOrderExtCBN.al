pageextension 51157 PlannedProductionOrderExtCBN extends "Planned Production Order"
{
    // version NAVW110.0,FINXL8.00,MANXL7.00,DITW110.00.12,HEI.01

    // DITW14.00.00.8 PROD: BrewIt & Quality
    // DITW15.00.00.35 PRODW14.00.00.08.14 DDR 18/08/2009
    //                                issue 768 Added to set non-editable fields
    //                                  "Gen. Bus. Posting Group","Gen. Prod. Posting Group","Inventory Posting Group"

    // FINXL8.00.001 BSA 05/06/2015 #182: Added Field "Emergency Order"
    // MANXL7.00.001 DAT 03/03/2014 #10: create Head group for subcontracting
    // MANXL7.00.001 DAT 03/03/2014 #12: Version Management
    // MANXL7.00.001 WSA 11/07/2014 #87: Added code MANXL security
    // MANXL7.00.001 WSA 26/09/2014 : Ovoid Rec Inserted twice
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW18.00.06 MSF 03/03/2015 DIT-770 #1192 Bug Fix
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 MSF 11/11/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 20/10/2015 DIT-770 #805 Renumber CodeUnit ID  2035095 to 2035150
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.12 AKH 21/03/2018 NRQ#64704 Added fields "Unit of Measure Code"
    //                                                     "Quantity (Base)"
    //                                                     "Quantity HL"

    // HEI.01 RFC-CHG0257267 IBM.SS 11.01.2019
    //   # Code added On Refresh production Order action

    //Bc Upgrade YADAVM09 Drink it field and Action commented.
    //Bc Upgrade YADAVM09 base created field "Starting Date-Time" in place of Starting Date,starting time blocked here as field already avaliable in base page
    //Bc Upgrade YADAVM09 base created field "Ending Date-Time" in place of Ending Date,Ending time blocked here as field already avaliable in base page.
    //Bc Upgrade YADAVM09 page action Re&fresh Production Order visible false added Re&fresh Production Order1
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
        modify("Assigned User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user who is responsible for the document.', FRA = 'Spécifie le code de l''utilisateur qui est responsable du document.';
        }
        modify("Last Date Modified")
        {
            ToolTipML = ENU = 'Specifies when the production order card was last modified.', FRA = 'Indique la date à laquelle la fiche ordre de fabrication a été modifiée pour la dernière fois.';
        }
        modify(Schedule)
        {
            CaptionML = ENU = 'Schedule', FRA = 'Planifié';
        }
        /* //Bc Upgarde YADAVM09 Base created 1 field for Starting Date,starting time,Ending date,Ending time>>
        modify("Starting Time")
        {
            ToolTipML = ENU = 'Specifies the starting time of the production order.', FRA = 'Spécifie l''heure de début de l''ordre de fabrication.';
        }
        modify("Starting Date")
        {
            ToolTipML = ENU = 'Specifies the starting date of the production order.', FRA = 'Spécifie la date de début de l''ordre de fabrication.';
        }
        modify("Ending Time")
        {
            ToolTipML = ENU = 'Specifies the ending time of the production order.', FRA = 'Spécifie l''heure de fin de l''ordre de fabrication.';
        }
        modify("Ending Date")
        {
            ToolTipML = ENU = 'Specifies the ending date of the production order.', FRA = 'Spécifie la date de fin de l''ordre de fabrication.';
        }
        */ //Bc Upgarde YADAVM09 Base created 1 field for Starting Date,starting time,Ending date,Ending time<<


        modify(Posting)
        {
            CaptionML = ENU = 'Posting', FRA = 'Validation';
        }
        modify("Inventory Posting Group")
        {
            ToolTipML = ENU = 'Specifies the inventory posting group in order to assign the WIP to the correct general ledger account.', FRA = 'Spécifie le groupe comptabilisation stock pour affecter les TEC au compte général qui convient.';

            //Unsupported feature: Change Editable on ""Inventory Posting Group"(Control 81)". Please convert manually.

        }
        modify("Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies a product posting group associated with manufactured items in this production order.', FRA = 'Indique un groupe comptabilisation produit auquel appartiennent des articles fabriqués dans cet ordre de fabrication.';

            //Unsupported feature: Change Editable on ""Gen. Prod. Posting Group"(Control 83)". Please convert manually.

        }
        modify("Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies a business posting group.', FRA = 'Spécifie un groupe comptabilisation marché.';

            //Unsupported feature: Change Editable on ""Gen. Bus. Posting Group"(Control 85)". Please convert manually.

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
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Specifies a bin to which you want to post the finished items.', FRA = 'Spécifie un emplacement sur lequel vous souhaitez valider les articles terminés.';
        }

        //Unsupported feature: CodeModification on ""Source Type"(Control 4).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if xRec."Source Type" <> "Source Type" then
          "Source No." := '';
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if xRec."Source Type" <> "Source Type" then
          "Source No." := '';
        //<<MANXL7.00.001 WSA 11/07/2014 #87
        if rMANXLSetup.READPERMISSION then begin
        //>>MANXL7.00.001 WSA 11/07/2014 #87
          //<<MANXL7.00.001 DAT 03/03/2014 #10
          blnRevisionNoEnabled:= ("Source Type" = "Source Type"::Item);
          CurrPage.UPDATE;
          //>>MANXL7.00.001 DAT 03/03/2014 #10
        //<<MANXL7.00.001 WSA 11/07/2014 #87
        end;
        //>>MANXL7.00.001 WSA 11/07/2014 #87
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Source No."(Control 8)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        CurrPage.UPDATE;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Location Code"(Control 42)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW18.00.06 MSF 03/03/2015 DIT-770 #1192
        if "Location Code" <> xRec."Location Code" then
          CurrPage.UPDATE(true);
        // >>DITW18.00.06 MSF DIT-770 #1192
        */
        //end;
        /* //Bc Upgrade YADAVM09 Drink it field commented>>
                addafter("Source No.")
                {
                    field("Revision No."; "Revision No.")
                    {
                        Description = 'MANXL7.00.001';
                        Enabled = blnRevisionNoEnabled;
                    }
                    field("Gyle No."; "Gyle No.")
                    {
                        CaptionClass = '2035140,1';
                    }
                }

                addafter("Search Description")
                {
                    field("Unit of Measure Code"; "Unit of Measure Code")
                    {
                    }
                }
                addafter(Quantity)
                {
                    field("Quantity (Base)"; "Quantity (Base)")
                    {
                        Importance = Additional;
                    }
                    field("Quantity HL"; "Quantity HL")
                    {
                    }
                }
                addafter("Last Date Modified")
                {
                    field("Emergency Order"; "Emergency Order")
                    {
                    }
                    field("Certification Status"; "Certification Status")
                    {
                    }
                    field("Certified by"; "Certified by")
                    {
                    }
                }
                addafter("Shortcut Dimension 2 Code")
                {
                    field("Responsibility Center"; "Responsibility Center")
                    {
                        Importance = Promoted;
                        QuickEntry = false;

                        trigger OnValidate();
                        begin
                            // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1190
                            if "Responsibility Center" <> xRec."Responsibility Center" then
                                CurrPage.UPDATE(true);
                            // >>DITW18.00.06 MSF DIT-770 #1190
                        end;
                    }
                    field("Physical Location Group Code"; "Physical Location Group Code")
                    {
                        Importance = Promoted;
                        QuickEntry = false;

                        trigger OnValidate();
                        begin
                            // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
                            if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
                                CurrPage.UPDATE(true);
                            // >>DITW18.00.06 MSF DIT-770 #1192
                        end;
                    }
                }
        */ //Bc Upgrade YADAVM09 Drink it field commented<<
           /* //Bc Upgrade YADAVM09 Drink it field commented>>
                   addafter(Posting)
                   {

                       group(Head)
                       {
                           CaptionML = ENU = 'Head',
                                       FRA = 'Tête';
                           Description = 'MANXL7.00.001';
                           field("Item Category Code"; "Item Category Code")
                           {
                               Description = 'MANXL7.00.001';
                           }
                           field("Item Product Group Code"; "Item Product Group Code")
                           {
                               Description = 'MANXL7.00.001';
                           }
                           field("Planning Group"; "Planning Group")
                           {
                               Description = 'MANXL7.00.001';
                           }
                           field("Production Group"; "Production Group")
                           {
                               Description = 'MANXL7.00.001';
                           }
                       }

                       group(Quality)
                       {
                           CaptionML = ENU = 'Quality',
                                       FRA = 'Qualité';
                           field("No. of Lot Tests"; "No. of Lot Tests")
                           {
                           }
                           field("No. of In Process Tests"; "No. of In Process Tests")
                           {
                           }
                       }
                   }*/ //Bc Upgrade YADAVM09 Drink it field commented<<
    }
    actions
    {

        modify("O&rder")
        {
            CaptionML = ENU = 'O&rder', FRA = '&O.F.';
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
        modify("Plannin&g")
        {
            CaptionML = ENU = 'Plannin&g', FRA = 'Plannin&g';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Re&fresh Production Order")
        {
            Visible = false;//Bc Upgrade YADAVM09
            CaptionML = ENU = 'Re&fresh Production Order', FRA = 'Ac&tualiser O.F.';
        }
        modify("Re&plan")
        {
            CaptionML = ENU = 'Re&plan', FRA = 'Re&planifier';
        }
        modify("Change &Status")
        {
            CaptionML = ENU = 'Change &Status', FRA = 'Changer &statut';
        }
        modify("&Update Unit Cost")
        {
            CaptionML = ENU = '&Update Unit Cost', FRA = '&Mise à jour coût unitaire';
        }
        modify("C&opy Prod. Order Document")
        {
            CaptionML = ENU = 'C&opy Prod. Order Document', FRA = 'Copier &O.F.';
        }
        modify("Subcontractor - Dispatch List")
        {
            CaptionML = ENU = 'Subcontractor - Dispatch List', FRA = 'S/traitant - Liste expédition';
        }
        //Unsupported feature: CodeModification on ""Re&fresh Production Order"(Action 17).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ProdOrder.SETRANGE(Status,Status);
        ProdOrder.SETRANGE("No.","No.");
        REPORT.RUNMODAL(REPORT::"Refresh Production Order",true,true,ProdOrder);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ProdOrder.SETRANGE(Status,Status);
        ProdOrder.SETRANGE("No.","No.");
        //HEI.01 RFC-CHG0257267 IBM.SS 11.01.2019>>
        if Item.GET("Source No.") then begin
          StockKeepingUnit.SETRANGE("Item No.",Item."No.");
          StockKeepingUnit.SETRANGE("Location Code","Location Code");
          if StockKeepingUnit.FINDFIRST then begin
            RoutingNo := StockKeepingUnit."Routing No.";
            BOM := StockKeepingUnit."Production BOM No.";
          end else
            ERROR('There is not any Active Routing / BOM version');
          RoutingVersion.SETRANGE("Routing No.",RoutingNo);
          RoutingVersion.SETRANGE(Active,true);
          if RoutingVersion.FINDFIRST then
            RoutingExist := true
          else
            RoutingExist := false;
          ProductionBOMVersion.SETRANGE("Production BOM No.",BOM);
          ProductionBOMVersion.SETRANGE(Active,true);
          if ProductionBOMVersion.FINDFIRST then
            BOMExist := true
          else
            BOMExist := false;
        end;
        if RoutingExist and BOMExist then
        //HEI.01 RFC-CHG0257267 IBM.SS 11.01.2019<<
          REPORT.RUNMODAL(REPORT::"Refresh Production Order",true,true,ProdOrder)
          //HEI.01 RFC-CHG0257267 IBM.SS 11.01.2019>>
        else
          ERROR('There is not any Active Routing / BOM version');
        //HEI.01 RFC-CHG0257267 IBM.SS 11.01.2019<<``
        */
        //end;
        /* //Bc Upgrade YADAVM09 Drink it field commented>>
        addafter("Re&plan")
        {
            action(Split)
            {
                CaptionML = ENU = 'Split',
                            FRA = 'Eclater';
                Ellipsis = true;
                Image = Split;

                trigger OnAction();
                begin
                    // <<DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008
                    BrewingManagement.SplitProdOrder(Rec);
                    // >>DITW15.00.00.22 PRODW14.00.00.08 DDR
                end;
            }
        }
        */ //Bc Upgrade YADAVM09 Drink it field commented<<
           //Bc Upgrade YADAVM09 Action Added>>
        addafter("F&unctions")
        {
            action("Re&fresh Production Order1")
            {
                ApplicationArea = Manufacturing;
                //Caption = 'Re&fresh Production Order';//Bc upgrade YADAVM09
                CaptionML = ENU = 'Re&fresh Production Order', FRA = 'Ac&tualiser O.F.';
                Ellipsis = true;
                Image = Refresh;
                ToolTip = 'Calculate changes made to the production order header without involving production BOM levels. The function calculates and initiates the values of the component lines and routing lines based on the master data defined in the assigned production BOM and routing, according to the order quantity and due date on the production order''s header.';

                trigger OnAction()
                var
                    ProdOrder: Record "Production Order";
                begin
                    ProdOrder.SetRange(Status, Rec.Status);
                    ProdOrder.SetRange("No.", Rec."No.");
                    //HEI.01 RFC-CHG0257267 IBM.SS 11.01.2019>>
                    IF Item.GET(Rec."Source No.") THEN BEGIN
                        StockKeepingUnit.SETRANGE("Item No.", Item."No.");
                        StockKeepingUnit.SETRANGE("Location Code", Rec."Location Code");
                        IF StockKeepingUnit.FINDFIRST() THEN BEGIN
                            RoutingNo := StockKeepingUnit."Routing No.";
                            BOM := StockKeepingUnit."Production BOM No.";
                        end else
                            ERROR('There is not any Active Routing / BOM version');
                        RoutingVersion.SETRANGE("Routing No.", RoutingNo);
                        RoutingVersion.SETRANGE("Active FND", TRUE);
                        IF RoutingVersion.FINDFIRST() THEN
                            RoutingExist := TRUE
                        else
                            RoutingExist := FALSE;
                        ProductionBOMVersion.SETRANGE("Production BOM No.", BOM);
                        ProductionBOMVersion.SETRANGE("Active FND", TRUE);
                        IF ProductionBOMVersion.FINDFIRST() THEN
                            BOMExist := TRUE
                        else
                            BOMExist := FALSE;
                    end;
                    IF RoutingExist AND BOMExist THEN
                        //HEI.01 RFC-CHG0257267 IBM.SS 11.01.2019<<
                        REPORT.RunModal(REPORT::"Refresh Production Order", true, true, ProdOrder)
                    //HEI.01 RFC-CHG0257267 IBM.SS 11.01.2019>>
                    else
                        ERROR('There is not any Active Routing / BOM version');
                    //HEI.01 RFC-CHG0257267 IBM.SS 11.01.2019<<``
                end;
            }
        }

        //Bc Upgrade YADAVM09 Action Added<<


    }

    var
        //rMANXLSetup: Record "Manufacturing XL Setup";//Bc Upgrade Drink it object
        Item: Record Item;
        //BrewingManagement: Codeunit "Brewing Management";//Bc Up
        ManufacturingSetup: Record "Manufacturing Setup";
        ProductionBOMVersion: Record "Production BOM Version";
        RoutingVersion: Record "Routing Version";
        StockKeepingUnit: Record "Stockkeeping Unit";
        UserMgt: Codeunit "User Setup Management";

        blnRevisionNoEnabled: Boolean;
        BOMExist: Boolean;

        GenBusPostingGroupEditable: Boolean;

        GenProdPostingGroupEditable: Boolean;

        InventoryPostingGroupEditable: Boolean;
        RoutingExist: Boolean;
        BOM: Code[20];
        RoutingNo: Code[20];


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


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW15.00.00.35 PRODW14.00.00.08.14 DDR 18/08/2009
    InventoryPostingGroupEditable := true;
    GenProdPostingGroupEditable := true;
    GenBusPostingGroupEditable := true;
    // >>DITW15.00.00.35 PRODW14.00.00.08.14 DDR
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //begin
    /*
    //<<DITW18.00.06 MSF 04/03/2015 DIT-770 #1192
    "Responsibility Center" := UserMgt.GetProductionFilter;
    //>>DITW18.00.06 MSF 04/03/2015 DIT-770 #1192
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //begin
    /*
    // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
    SetSecurityFilterOnRespCenter();
    // >>DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
    //<<MANXL7.00.001 WSA 11/07/2014 #87
    if rMANXLSetup.READPERMISSION then begin
    //>>MANXL7.00.001 WSA 11/07/2014 #87
      //<<MANXL7.00.001 DAT 03/03/2014 #10
      blnRevisionNoEnabled:= ("Source Type" = "Source Type"::Item);
      //<<MANXL7.00.001 WSA 26/09/2014
      //Currpage.update;
      CurrPage.UPDATE(false);
      //>>MANXL7.00.001 WSA 26/09/2014
      //>>MANXL7.00.001 DAT 03/03/2014 #10
    //<<MANXL7.00.001 WSA 11/07/2014 #87
    end;
    //>>MANXL7.00.001 WSA 11/07/2014 #87

    // <<DITW15.00.00.35 PRODW14.00.00.08.14 DDR 18/08/2009
    if ManufacturingSetup.GET() then begin
      GenBusPostingGroupEditable := ManufacturingSetup."Editable Item Posting Groups";
      GenProdPostingGroupEditable := GenBusPostingGroupEditable;
      InventoryPostingGroupEditable := GenBusPostingGroupEditable;
    end;
    // >>DITW15.00.00.35 PRODW14.00.00.08.14
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

