pageextension 51139 AssemblyOrdersExtCBN extends "Assembly Orders"
{
    // version NAVW110.0.00.16177,DITW110.00.08,HEI.02
    //     DITW18.00.06 MSF 26/02/2015 DIT-770 #1192 Added fields 2014410 "Responsibility Center"
    //                                                        2014411 "Physical Location Group Code"
    // DITW18.00.06 MSF 03/03/2015 DIT-770 #1192 Bug Fix

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // HEI.01 CHG2174146 SAHAL01 20.02.2023 Assembly Order Outbound and Inbound interfaces HeiLite -- Astro WMS
    //   # Added New Fields - Assembly ORDER Interface Astro
    //                      - Parked ORDER Astro
    //                      - Last Parked Date ORDER Astro
    //                      - Last Parked Time ORDER Astro
    //   # Added Code to visible Astro Fields
    // HEI.02 CHG2174146 SAHAL01 23.02.2023 Assembly Order Outbound and Inbound interfaces HeiLite -- Astro WMS
    //   # Added New Fields - Asmbl LINEPICK Interface Astro
    //                      - Parked LINEPICK Astro
    //                      - Last Parked Date LINEPICKAstro
    //                      - Last Parked Time LINEPICKAstro
    //                      - Posted LINEPICK Astro
    //                      - Asmbly OUTPUT Interface Astro
    //                      - Parked OUTPUT Astro
    //                      - Last Parked Date OUTPUT Astro
    //                      - Last Parked Time OUTPUT Astro
    //                      - Posted OUTPUT Astro
    //   # Added Code to visible Astro Fields
    //***********************************************************************************
    //BC UPGRADE PATHAA02 19.11.25
    //1. Made "Description" field non editable as it can't be handled on Table 900-Assembly Header
    //2. Astro related-HEI.01 and HEI.02 -commented
    //3. DrinkIT commented
    //4. Code added on "Bin Code"-Onlookup-->from Table900-"Bin Code"-Onlookup as this cannot be handled on Table Extension.
    //BC Upgrade KAPOOV01 25.11.2025 #Created new action-Post as we have created a new codeunit- "Custom_Assembly-Post(Y/N)CBN" for CD-901-Assembly-Post (Yes/No) to add HEI customization and this new codeunit function is called inside this action.
    //BC Upgrade KAPOOV01 25.11.2025 #Hide standard P&ost action as we have created new Custom "Post".

    layout
    {
        modify("Document Type")
        {
            ToolTipML = ENU = 'Specifies the type of assembly document the record represents in assemble-to-order scenarios.', FRA = 'Spécifie le type de document d''assemblage que l''enregistrement représente dans les scénarios d''assemblage à la commande.';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number assigned to the assembly order from the number series that you set up in the Assembly Setup window.', FRA = 'Spécifie le numéro affecté à l''ordre d''assemblage à partir de la souche de numéro configurée dans la fenêtre Paramètres d''assemblage.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the description of the assembly item.', FRA = 'Spécifie la description de l''article d''assemblage.';
            Editable = false;//BC UPGRADE PATHAA02
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies the date when the assembled item is due to be available for use.', FRA = 'Spécifie la date à laquelle l''article assemblé doit être disponible.';
        }
        modify("Starting Date")
        {
            ToolTipML = ENU = 'Specifies the date when the assembly order is expected to start.', FRA = 'Spécifie la date à laquelle l''ordre d''assemblage doit démarrer.';
        }
        modify("Ending Date")
        {
            ToolTipML = ENU = 'Specifies the date when the assembly order is expected to finish.', FRA = 'Spécifie la date à laquelle l''ordre d''assemblage doit se terminer.';
        }
        modify("Assemble to Order")
        {
            ToolTipML = ENU = 'Specifies if the assembly order is linked to a sales order, which indicates that the item is assembled to order.', FRA = 'Indique si l''ordre d''assemblage est lié à une commande vente, ce qui indique que l''article est assemblé pour commande.';
        }
        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item that is being assembled with the assembly order.', FRA = 'Indique le numéro de l''article qui est assemblé avec l''ordre d''assemblage.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies how many units of the assembly item that you expect to assemble with the assembly order.', FRA = 'Spécifie le nombre d''unités de l''article d''assemblage que vous prévoyez d''assembler avec cet ordre d''assemblage.';
        }
        modify("Unit Cost")
        {
            ToolTipML = ENU = 'Specifies the unit cost of the assembly item.', FRA = 'Spécifie le coût unitaire de l''article d''assemblage.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location to which you want to post output of the assembly item.', FRA = 'Indique le magasin vers lequel vous souhaitez valider la production de l''article d''assemblage.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the code of the item variant of the item that is being assembled.', FRA = 'Indique le code de la variante article de l''article qui est assemblé.';
        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Specifies the bin the assembly item is posted to as output and from where it is taken to storage or shipped if it is assembled to a sales order.', FRA = 'Spécifie l''emplacement dans lequel l''article d''assemblage est validé en tant que production et d''où il est prélevé pour le stockage ou l''expédition s''il est assemblé pour une commande.';
            trigger OnLookup(var Text: Text): Boolean
            var
                WMSManagement: Codeunit "WMS Management";
                Bincode: code[20];
                myInt: Integer;
            begin
                //BC UPGRADE PATHAA02-Code added from Table900-Onlookup as this cannot be handled on Table Ext>>
                IF Rec.Quantity < 0 THEN
                    //HEI.01 PRDGAP024 delete BinCode := WMSManagement.BinContentLookUp("Location Code","Item No.","Variant Code",'',"Bin Code")
                    BinCode := WMSManagement.BinContentLookUp(Rec."Location Code", Rec."Item No.", Rec."Variant Code", Rec."Zone Code FND", Rec."Bin Code")//HEI.01 PRDGAP024 NEW LINE
                else
                    //HEI.01 PRDGAP024 delete BinCode := WMSManagement.BinLookUp("Location Code","Item No.","Variant Code",'');
                    BinCode := WMSManagement.BinLookUp(Rec."Location Code", Rec."Item No.", Rec."Variant Code", Rec."Zone Code FND");//HEI.01 PRDGAP024 NEW LINE
                IF BinCode <> '' THEN
                    Rec.VALIDATE("Bin Code", BinCode);
                //BC UPGRADE PATHAA02-Code added from Table900-Onlookup as this cannot be handled on Table Ext<<
            end;

        }
        modify("Remaining Quantity")
        {
            ToolTipML = ENU = 'Specifies how many units of the assembly item remain to be posted as assembled output.', FRA = 'Spécifie le nombre d''unités de l''article d''assemblage qui doivent encore être validées comme production d''assemblage.';
        }
        modify(RecordLinks)
        {
            CaptionML = ENU = 'RecordLinks', FRA = 'RecordLinks';
        }
        //BC UPGRADE PATHAA02-DIT>>
        // addafter("Unit Cost")
        // {
        //     field("Responsibility Center"; "Responsibility Center")
        //     {
        //     }
        //     field("Physical Location Group Code"; "Physical Location Group Code")
        //     {
        //     }
        // }
        //BC UPGRADE PATHAA02-DIT<<

        //BC UPGRADE PATHAA02-ASTRO>>
        // addafter("Remaining Quantity")
        // {
        //     field("Assembly ORDER Interface Astro"; "Assembly ORDER Interface Astro")
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
        //     field("Asmbl LINEPICK Interface Astro"; "Asmbl LINEPICK Interface Astro")
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
        //     field("Posted LINEPICK Astro"; "Posted LINEPICK Astro")
        //     {
        //         Visible = VisibleAstroLinePick;
        //     }
        //     field("Asmbly OUTPUT Interface Astro"; "Asmbly OUTPUT Interface Astro")
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
        //     field("Posted OUTPUT Astro"; "Posted OUTPUT Astro")
        //     {
        //         Visible = VisibleAstroOutput;
        //     }
        // }
        //BC UPGRADE PATHAA02-ASTRO<<
    }
    actions
    {
        modify(Line)
        {
            CaptionML = ENU = 'Line', FRA = 'Ligne';
        }
        modify(Entries)
        {
            CaptionML = ENU = 'Entries', FRA = 'Écritures';
        }
        modify("Item Ledger Entries")
        {
            CaptionML = ENU = 'Item Ledger E&ntries', FRA = 'É&critures comptables article';
        }
        modify("Capacity Ledger Entries")
        {
            CaptionML = ENU = 'Capacity Ledger Entries', FRA = 'Écritures comptables capacité';
        }
        modify("Resource Ledger Entries")
        {
            CaptionML = ENU = 'Resource Ledger Entries', FRA = 'Écritures comptables ressource';
        }
        modify("Value Entries")
        {
            CaptionML = ENU = 'Value Entries', FRA = 'Écritures valeur';
        }
        modify("Warehouse Entries")
        {
            CaptionML = ENU = '&Warehouse Entries', FRA = 'É&critures entrepôt';
        }
        modify("Show Order")
        {
            CaptionML = ENU = 'Show Order', FRA = 'Afficher commande';
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
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Assembly BOM")
        {
            CaptionML = ENU = 'Assembly BOM', FRA = 'Nomenclature d''assemblage';
        }
        modify(Comments)
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(Release)
        {
            CaptionML = ENU = 'Re&lease', FRA = 'La&ncer';
        }
        modify(Reopen)
        {
            CaptionML = ENU = 'Re&open', FRA = 'R&ouvrir';
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
        }
        modify("P&ost")
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
            Visible = false;  //BC Upgrade KAPOOV01 Hide standard P&ost action as we created new Custom "Post" action as we created a new codeunit- "Assembly-Post (Yes/No)_Ext" for CD-901-Assembly-Post (Yes/No) and this new codeunit function is called in this action.
        }
        modify("Post &Batch")
        {
            CaptionML = ENU = 'Post &Batch', FRA = 'Valider par l&ot';
        }


        //BC Upgrade KAPOOV01 Created new action-Post as we have created a new codeunit- "Assembly-Post (Yes/No)_Ext" for CD-901-Assembly-Post (Yes/No) to add HEI customization and this new codeunit function is called inside this action.>>
        addfirst("P&osting")
        {
            action("Post")
            {
                ApplicationArea = Assembly;
                Caption = 'P&ost';
                Ellipsis = true;
                Image = PostOrder;
                ShortCutKey = 'F9';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                trigger OnAction()
                begin
                    CODEUNIT.Run(CODEUNIT::"Custom_Assembly-Post(Y/N)CBN", Rec);
                end;
            }
            //BC Upgrade KAPOOV01 Created new action-Post as we have created a new codeunit- "Assembly-Post (Yes/No)_Ext" for CD-901-Assembly-Post (Yes/No) to add HEI customization and this new codeunit function is called inside this action.<<
        }
    }

    //BC UPGRADE PATHAA02-Astro<<
    // var
    //     // UserMgt: Codeunit "User Setup Management"; 
    //     VisibleAstro: Boolean;
    //     VisibleAstroLinePick: Boolean;
    //     VisibleAstroOutput: Boolean;
    //BC UPGRADE PATHAA02-Astro<<


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //BC UPGRADE PATHAA02 -Astro>>
    /*
    var
        AstroInterfaceSetupL: Record "Astro Interface Setup";
        InterfaceSetupL: Record "Interface Setup";
    */
    //BC UPGRADE PATHAA02 -Astro<<
    //begin
    /*
    //<<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
    SetSecurityFilterOnRespCenter();
    //>>DITW18.00.06 MSF 26/02/2015 DIT-770 #1192

    //HEI.01>>
    CLEAR(VisibleAstro);
    //HEI.02>>
    CLEAR(VisibleAstroLinePick);
    CLEAR(VisibleAstroOutput);
    //HEI.02<<
    if AstroInterfaceSetupL.GET and AstroInterfaceSetupL."Enabled Astro Integration" then begin
      if AstroInterfaceSetupL."Activate Assembly Order" then begin
        if AstroInterfaceSetupL."Assembly Order Interface" <> '' then begin
          if InterfaceSetupL.GET(AstroInterfaceSetupL."Assembly Order Interface") then
            VisibleAstro := true;
        end;
        //HEI.02>>
        CLEAR(InterfaceSetupL);
        if AstroInterfaceSetupL."Asmbl Order LinePick Interface" <> '' then begin
          if InterfaceSetupL.GET(AstroInterfaceSetupL."Asmbl Order LinePick Interface") then
            VisibleAstroLinePick := true;
        end;
        CLEAR(InterfaceSetupL);
        if AstroInterfaceSetupL."Asmbly Order Output Interface" <> '' then begin
          if InterfaceSetupL.GET(AstroInterfaceSetupL."Asmbly Order Output Interface") then
            VisibleAstroOutput := true;
        end;
        //HEI.02<<
      end;
    end;
    //HEI.01<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



}

