pageextension 51138 AssemblyOrderExtCBN extends "Assembly Order"
{
    // version NAVW110.0,DITW110.00.08,HEI.03,HEI.02

    //     DITW18.00.06 MSF 26/02/2015 DIT-770 #1192 Added fields 2014410 "Responsibility Center"
    //                                                        2014411 "Physical Location Group Code"
    // DITW17.10.05 DDR 03/09/2014 DIT-770 #675 Added Tax Assembly Orders functionality
    //                                          Added fields "Tax Date"
    // DITW17.10.05 DDR 05/09/2014 DIT-770 #675 Added fields "Has Header Item Charge"
    //                                          Added action to show header tax lines
    //                                          Added action to calculate header tax lines

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #Zone code development without whs advanced mgmt
    //   #new fields Zone Code
    // HEI.02 CHG2174146 SAHAL01 09.03.2023 Assembly Order Outbound and Inbound interfaces HeiLite -- Astro WMS
    //   # Added New Tab - Astro
    //   # Added New Group - Outbound - Assembly Order Sync Info.
    //   # Added New Fields - Assembly ORDER Interface Astro
    //                      - Parked ORDER Astro
    //                      - Last Parked Date ORDER Astro
    //                      - Last Parked Time ORDER Astro
    //   # Added Code to visible Astro Tab
    //   # Added New Action - Send For Astro
    //   # Added Code to call function
    // HEI.03 CHG2174146 SAHAL01 23.02.2023 Assembly Order Outbound and Inbound interfaces HeiLite -- Astro WMS
    //   # Added New Groups - Inbound - Assembly Order Line Pick Info.
    //                      - Inbound - Assembly Order Output Info.
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


    //Bc Upgrade YADAVM09 make Description Editable false to handle Assembly Header description field property
    //BC Upgrade KAPOOV01 25.11.2025 #Created new action-Post as we have created a new codeunit- "Custom_Assembly-Post(Y/N)CBN" for CD-901-Assembly-Post (Yes/No) to add HEI customization and this new codeunit function is called inside this action.
    //BC Upgrade KAPOOV01 25.11.2025 #Hide standard P&ost action as we have created new Custom "Post".

    layout
    {

        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number assigned to the assembly order from the number series that you set up in the Assembly Setup window.', FRA = 'Spécifie le numéro affecté à l''ordre d''assemblage à partir de la souche de numéro configurée dans la fenêtre Paramètres d''assemblage.';
        }
        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item that is being assembled with the assembly order.', FRA = 'Indique le numéro de l''article qui est assemblé avec l''ordre d''assemblage.';
        }
        modify(Description)
        {
            Editable = false;//Bc Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies the description of the assembly item.', FRA = 'Spécifie la description de l''article d''assemblage.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies how many units of the assembly item that you expect to assemble with the assembly order.', FRA = 'Spécifie le nombre d''unités de l''article d''assemblage que vous prévoyez d''assembler avec cet ordre d''assemblage.';
        }
        modify("Quantity to Assemble")
        {
            ToolTipML = ENU = 'Specifies how many of the assembly item units you want to partially post. To post the full quantity on the assembly order, leave the field unchanged.', FRA = 'Spécifie le nombre d''unités de l''article d''assemblage que vous souhaitez valider partiellement. Pour valider la quantité entière sur l''ordre d''assemblage, ne modifiez pas ce champ.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code of the assembly item.', FRA = 'Spécifie le code unité de l''article d''assemblage.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the date on which the assembly order is posted.', FRA = 'Spécifie la date comptabilisation de l''ordre d''assemblage.';
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
        modify("Remaining Quantity")
        {
            ToolTipML = ENU = 'Specifies how many units of the assembly item remain to be posted as assembled output.', FRA = 'Spécifie le nombre d''unités de l''article d''assemblage qui doivent encore être validées comme production d''assemblage.';
        }
        modify("Assembled Quantity")
        {
            ToolTipML = ENU = 'Specifies how many units of the assembly item are posted as assembled output.', FRA = 'Spécifie le nombre d''unités de l''article d''assemblage qui sont validées comme production d''assemblage.';
        }
        modify("Reserved Quantity")
        {
            ToolTipML = ENU = 'Specifies how many units of the assembly item are reserved for this assembly order header.', FRA = 'Spécifie le nombre d''unités de l''article d''assemblage qui sont réservées pour cet en-tête d''ordre d''assemblage.';
        }
        modify("Assemble to Order")
        {
            ToolTipML = ENU = 'Specifies if the assembly order is linked to a sales order, which indicates that the item is assembled to order.', FRA = 'Indique si l''ordre d''assemblage est lié à une commande vente, ce qui indique que l''article est assemblé pour commande.';
        }
        modify(Status)
        {
            ToolTipML = ENU = 'Specifies if the document is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.', FRA = 'Spécifie si le document est ouvert, est en attente d''approbation, a été facturé pour acompte ou a été lancé pour l''étape suivante du traitement.';
        }
        modify(Lines)
        {
            CaptionML = ENU = 'Lines', FRA = 'Lignes';
        }
        modify(Posting)
        {
            CaptionML = ENU = 'Posting', FRA = 'Validation';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the code of the item variant of the item that is being assembled.', FRA = 'Indique le code de la variante article de l''article qui est assemblé.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location to which you want to post output of the assembly item.', FRA = 'Indique le magasin vers lequel vous souhaitez valider la production de l''article d''assemblage.';
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
        modify("Indirect Cost %")
        {
            ToolTipML = ENU = 'Specifies the percentage of the assembly item''s direct unit cost that makes up indirect costs, such as freight and warehouse handling, associated with the assembly.', FRA = 'Spécifie le pourcentage du coût unitaire direct de l''article d''assemblage qui constitue les coûts indirects, comme la gestion du fret et des entrepôts associés à l''assemblage.';
        }
        modify("Overhead Rate")
        {
            ToolTipML = ENU = 'Specifies the indirect cost of the assembly item as an absolute amount.', FRA = 'Spécifie le coût indirect de l''article d''assemblage en tant que montant absolu.';
        }
        modify("Unit Cost")
        {
            ToolTipML = ENU = 'Specifies the unit cost of the assembly item.', FRA = 'Spécifie le coût unitaire de l''article d''assemblage.';
        }
        modify("Cost Amount")
        {
            ToolTipML = ENU = 'Specifies the total unit cost of the assembly order.', FRA = 'Spécifie le coût unitaire total de l''ordre d''assemblage.';
        }
        modify("Assigned User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user who is responsible for the document.', FRA = 'Spécifie le code de l''utilisateur qui est responsable du document.';
        }

        //Unsupported feature: CodeModification on "Quantity(Control 6).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW17.10.05 DDR 05/09/2014 DIT-770 #675
        //CurrPage.SAVERECORD;
        CurrPage.UPDATE(true);
        // >>DITW17.10.05 DDR DIT-770 #675
        */
        //end;


        //Unsupported feature: CodeModification on ""Quantity to Assemble"(Control 21).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW17.10.05 DDR 05/09/2014 DIT-770 #675
        //CurrPage.SAVERECORD;
        CurrPage.UPDATE(true);
        // >>DITW17.10.05 DDR DIT-770 #675
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit of Measure Code"(Control 30).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW17.10.05 DDR 05/09/2014 DIT-770 #675
        //CurrPage.SAVERECORD;
        CurrPage.UPDATE(true);
        // >>DITW17.10.05 DDR DIT-770 #675
        */
        //end;


        //Unsupported feature: CodeModification on ""Location Code"(Control 28).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
        if "Location Code" <> xRec."Location Code" then
          CurrPage.UPDATE(true);
        // >>DITW18.00.06 MSF DIT-770 #1192
        CurrPage.SAVERECORD;
        */
        //end;
        /* //Bc Upgrade YADAVM09 Drink it field Commented>>
        addafter("Due Date")
        {
            field("Tax Date"; Rec."Tax Date")
            {
                Description = 'DITW17.10.05 DIT-770 #765';
            }
            field("Has Header Item Charge"; Rec."Has Header Item Charge")
            {
                CaptionML = ENU = 'Tax Charges',
                            FRA = 'Taxes d''impôt';
            }
        }
        
        addafter("Variant Code")
        {
            field("Responsibility Center"; "Responsibility Center")
            {
                Editable = IsAsmToOrderEditable;
                Importance = Promoted;

                trigger OnValidate();
                begin
                    // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1190
                    CurrPage.SAVERECORD;
                    if "Responsibility Center" <> xRec."Responsibility Center" then
                        CurrPage.UPDATE(true);
                    // >>DITW18.00.06 MSF DIT-770 #1190
                end;
            }
            field("Physical Location Group Code"; "Physical Location Group Code")
            {
                Editable = IsAsmToOrderEditable;
                Importance = Promoted;

                trigger OnValidate();
                begin
                    // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
                    if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
                        CurrPage.UPDATE(true);
                    CurrPage.SAVERECORD;
                    // >>DITW18.00.06 MSF DIT-770 #1192
                end;
            }
        }
        */ //Bc Upgrade YADAVM09 Drink it field Commented<<
        addafter("Location Code")
        {
            field("Zone Code"; Rec."Zone Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zone Code field.';
            }
        }


        /* //Bc Upgrade YADAVM09 Astro field Commented>>
        addafter(Posting)
        {
            group(Astro)
            {
                Caption = 'Astro';
                Visible = VisibleAstro;
                group("Outbound - Assembly Order Sync Info.")
                {
                    Caption = 'Outbound - Assembly Order Sync Info.';
                    field("Assembly ORDER Interface Astro"; "Assembly ORDER Interface Astro")
                    {
                        Editable = false;
                    }
                    field("Parked ORDER Astro"; "Parked ORDER Astro")
                    {
                        Editable = false;
                    }
                    field("Last Parked Date ORDER Astro"; "Last Parked Date ORDER Astro")
                    {
                        Editable = false;
                    }
                    field("Last Parked Time ORDER Astro"; "Last Parked Time ORDER Astro")
                    {
                        Editable = false;
                    }
                }
                group("Inbound - Assembly Order Line Pick Info.")
                {
                    Caption = 'Inbound - Assembly Order Line Pick Info.';
                    field("Asmbl LINEPICK Interface Astro"; "Asmbl LINEPICK Interface Astro")
                    {
                        Editable = false;
                    }
                    field("Parked LINEPICK Astro"; "Parked LINEPICK Astro")
                    {
                        Editable = false;
                    }
                    field("Last Parked Date LINEPICKAstro"; "Last Parked Date LINEPICKAstro")
                    {
                        Editable = false;
                    }
                    field("Last Parked Time LINEPICKAstro"; "Last Parked Time LINEPICKAstro")
                    {
                        Editable = false;
                    }
                    field("Posted LINEPICK Astro"; "Posted LINEPICK Astro")
                    {
                        Editable = false;
                    }
                }
                group("Inbound - Assembly Order Output Info.")
                {
                    Caption = 'Inbound - Assembly Order Output Info.';
                    field("Asmbly OUTPUT Interface Astro"; "Asmbly OUTPUT Interface Astro")
                    {
                        Editable = false;
                    }
                    field("Parked OUTPUT Astro"; "Parked OUTPUT Astro")
                    {
                        Editable = false;
                    }
                    field("Last Parked Date OUTPUT Astro"; "Last Parked Date OUTPUT Astro")
                    {
                        Editable = false;
                    }
                    field("Last Parked Time OUTPUT Astro"; "Last Parked Time OUTPUT Astro")
                    {
                        Editable = false;
                    }
                    field("Posted OUTPUT Astro"; "Posted OUTPUT Astro")
                    {
                        Editable = false;
                    }
                }
                 
            }
        }*/ //Bc Upgrade YADAVM09 Astro field Commented<<
    }
    actions
    {
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
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("Assembly BOM")
        {
            CaptionML = ENU = 'Assembly BOM', FRA = 'Nomenclature d''assemblage';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Item Tracking Lines")
        {
            CaptionML = ENU = 'Item &Tracking Lines', FRA = '&Lignes traçabilité';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        }
        modify(Action14)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        }
        modify(Warehouse)
        {
            CaptionML = ENU = 'Warehouse', FRA = 'Entrepôt';
        }
        modify("Pick Lines/Movement Lines")
        {
            CaptionML = ENU = 'Pick Lines/Movement Lines', FRA = 'Lignes prélèvement/Lignes mouvement';
        }
        modify("Registered P&ick Lines")
        {
            CaptionML = ENU = 'Registered P&ick Lines', FRA = '&Lignes prélèvement enreg.';
        }
        modify("Registered Invt. Movement Lines")
        {
            CaptionML = ENU = 'Registered Invt. Movement Lines', FRA = 'Lignes mouvement stock enreg.';
        }
        modify("Asm.-to-Order Whse. Shpt. Line")
        {
            CaptionML = ENU = 'Asm.-to-Order Whse. Shpt. Line', FRA = 'Ligne expédition entrepôt Assemblage à la commande';
        }
        modify(History)
        {
            CaptionML = ENU = 'History', FRA = 'Historique';
        }
        modify(Entries)
        {
            CaptionML = ENU = 'Entries', FRA = 'Écritures';
        }
        modify("Item Ledger Entries")
        {
            CaptionML = ENU = 'Item Ledger Entries', FRA = 'Écritures comptables article';
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
            CaptionML = ENU = 'Warehouse Entries', FRA = 'Écritures entrepôt';
        }
        modify("Reservation Entries")
        {
            CaptionML = ENU = 'Reservation Entries', FRA = 'Écritures réservation';
        }
        modify("Posted Assembly Orders")
        {
            CaptionML = ENU = 'Posted Assembly Orders', FRA = 'Ordres d''assemblage validés';
        }
        modify(Release)
        {
            CaptionML = ENU = 'Release', FRA = 'Lancer';
        }
        modify("Re&lease")
        {
            CaptionML = ENU = 'Re&lease', FRA = 'La&ncer';
        }
        modify("Re&open")
        {
            CaptionML = ENU = 'Re&open', FRA = 'R&ouvrir';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(ShowAvailability)
        {
            CaptionML = ENU = 'Show Availability', FRA = 'Afficher disponibilité';
        }
        modify("Update Unit Cost")
        {
            CaptionML = ENU = 'Update Unit Cost', FRA = 'Mettre à jour coût unitaire';
        }
        modify("Refresh Lines")
        {
            CaptionML = ENU = 'Refresh Lines', FRA = 'Actualiser lignes';
        }
        modify("&Reserve")
        {
            CaptionML = ENU = '&Reserve', FRA = '&Réserver';
        }
        modify("Copy Document")
        {
            CaptionML = ENU = 'Copy Document', FRA = 'Copier document';
        }

        modify("Create Inventor&y Movement")
        {
            CaptionML = ENU = 'Create Inventor&y Movement', FRA = 'Créer un mou&vement de stock';
        }
        modify("Order &Tracking")
        {
            CaptionML = ENU = 'Order &Tracking', FRA = '&Chaînage';
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
        modify(Print)
        {
            CaptionML = ENU = 'Print', FRA = 'Imprimer';
        }
        modify("Order")
        {
            CaptionML = ENU = 'Order', FRA = 'Commande';
        }


        //Unsupported feature: CodeInsertion on ""Re&lease"(Action 59).OnAction". Please convert manually.

        //trigger (Variable: ReleaseAssemblyDocumentL)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Re&lease"(Action 59).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"Release Assembly Document",Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"Release Assembly Document",Rec);
        //HEI.02>>
        CurrPage.UPDATE;
        if ("Document Type" = "Document Type"::Order) and (Status = Status::Released) then begin
          ReleaseAssemblyDocumentL.OnAfterReleasedAssemblyOrderforAstro(Rec,false);
        end;
        //HEI.02<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Re&open"(Action 60).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReleaseAssemblyDoc.Reopen(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.02>>
        ValidateAstroAssemblyOrderModification;
        //HEI.02<<
        ReleaseAssemblyDoc.Reopen(Rec);
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Refresh Lines"(Action 13).OnAction". Please convert manually.

        //trigger (Variable: ReleaseAssemblyDocumentL)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Refresh Lines"(Action 13).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        RefreshBOM;
        CurrPage.UPDATE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        RefreshBOM;
        CurrPage.UPDATE;
        //HEI.02>>
        if ("Document Type" = "Document Type"::Order) and (Status = Status::Released) then begin
          ReleaseAssemblyDocumentL.OnAfterReleasedAssemblyOrderforAstro(Rec,false);
        end;
        //HEI.02<<
        */
        //end;
        /* Bc Upgrade YADAVM09 Drink it Action commented>>
        addafter("Item Tracking Lines")
        {
            action("Assembly Tax Lines (Header)")
            {
                CaptionML = ENU = 'Assembly Tax Lines (Header)',
                            FRA = 'Lignes taxe assemblage (En-tête)';
                Image = SuggestLines;
                RunObject = Page "Assembly Header Lines";
                RunPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
            }
        }
        
        addafter("Copy Document")
        {
            action("Insert Tax Charges (Header)")
            {
                CaptionML = ENU = 'Insert Tax Charges (Header)',
                            FRA = 'Insérer lignes taxe (En-tête)';
                Description = 'DITW17.10.05 DIT-770 #765';
                ShortCutKey = 'Ctrl+Y';

                trigger OnAction();
                var
                    AssemblyLine2: Record "Assembly Line";
                begin
                    // <<DITW17.10.05 DDR 21/08/2014 DIT-770 #675
                    InsertHeaderChargeLines;
                    CurrPage.UPDATE(true);
                end;
            }
            */ //Bc Upgrade YADAVM09 Drink it Action commented<<
               /* //Bc Upgrade YADAVM09 Astro Action commented>>
               action(SendForAstro)
               {
                   Caption = 'Send For Astro';
                   Ellipsis = true;
                   Image = Apply;
                   Promoted = true;
                   PromotedCategory = Process;
                   Visible = VisibleAstro;

                   trigger OnAction();
                   var
                       ReleaseAssemblyDocumentL: Codeunit "Release Assembly Document";
                   begin
                       //HEI.02>>
                       CurrPage.UPDATE;
                       if (Rec."Document Type" = Rec."Document Type"::Order) and (Rec.Status = Rec.Status::Released) then begin
                           ReleaseAssemblyDocumentL.OnAfterReleasedAssemblyOrderforAstro(Rec, false);
                       end;
                       //HEI.02<<
                   end;
               }

           }*/ //Bc Upgrade YADAVM09 Drink it Action commented<<

        //BC Upgrade KAPOOV01 Created new action-Post as we have created a new codeunit- "Assembly-Post (Yes/No)_Ext" for CD-901-Assembly-Post (Yes/No) to add HEI customization and this new codeunit function is called inside this action.>>
        addfirst("P&osting")
        {
            action("Post")
            {
                ApplicationArea = Assembly;
                Caption = 'P&ost';
                Ellipsis = true;
                Enabled = IsAsmToOrderEditable;
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

    var
        //ReleaseAssemblyDocumentL: Codeunit "Release Assembly Document";//Bc Upgrade YADAVM09 Variable not used anywhere in the code
        //ReleaseAssemblyDocumentL: Codeunit "Release Assembly Document";//Bc Upgrade YADAVM09 Variable not used anywhere in the code
        //InterfaceSetupL: Record "Interface Setup";//Bc Upgrade YADAVM09 Variable not used anywhere in the code
        //AstroInterfaceSetupL: Record "Astro Interface Setup";//Bc Upgrade YADAVM09 Astro Object Commeneted
        UserMgt: Codeunit "User Setup Management";
        VisibleAstro: Boolean;


    //Unsupported feature: CodeInsertion on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //begin
    /*
    // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
    SETFILTER("Resp. Center Table Filter",UserMgt.GetRespCenterFilter(4,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Phys. Location Table Filter",UserMgt.GetRespPhysLocationFilter(4,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Location Table Filter",UserMgt.GetRespLocationFilter(4,"Responsibility Center","Physical Location Group Code","Location Code"));
    // >>DITW18.00.06 MSF DIT-770 #1192
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //begin
    /*
    //<<DITW18.00.06 MSF 04/03/2015 DIT-770 #1192
    "Responsibility Center" := UserMgt.GetAssemblyFilter;
    //>>DITW18.00.06 MSF 04/03/2015 DIT-770 #1192
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger (Variable: InterfaceSetupL)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsUnitCostEditable := true;
    IsAsmToOrderEditable := true;

    UpdateWarningOnLines;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //<<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
    SetSecurityFilterOnRespCenter();
    //>>DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
    #1..4

    //HEI.02>>
    CLEAR(VisibleAstro);
    if AstroInterfaceSetupL.GET and AstroInterfaceSetupL."Enabled Astro Integration" then begin
      if AstroInterfaceSetupL."Activate Assembly Order" then begin
        if AstroInterfaceSetupL."Assembly Order Interface" <> '' then begin
          if InterfaceSetupL.GET(AstroInterfaceSetupL."Assembly Order Interface") then
            VisibleAstro := true;
        end;
      end;
    end;
    //HEI.02<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

