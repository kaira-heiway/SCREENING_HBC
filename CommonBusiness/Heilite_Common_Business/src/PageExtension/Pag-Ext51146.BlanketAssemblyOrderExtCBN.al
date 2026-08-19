pageextension 51146 BlanketAssemblyOrderExtCBN extends "Blanket Assembly Order"
{
    // version NAVW110.0,DITW110.00.08
    //******************************************************************
    //BC UPGRADE PATHAA02 19.11.25
    //1. Made "Description" field non editable as it can't be handled on Table 900-Assembly Header
    //2. DIT commented
    //3. Code added on "Bin Code"-Onlookup-->from Table900-"Bin Code"-Onlookup as this cannot be handled on Table Extension.

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
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
            ToolTipML = ENU = 'Specifies the description of the assembly item.', FRA = 'Spécifie la description de l''article d''assemblage.';
            Editable = false; //BC UPGRADE PATHAA02
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies how many units of the assembly item that you expect to assemble with the assembly order.', FRA = 'Spécifie le nombre d''unités de l''article d''assemblage que vous prévoyez d''assembler avec cet ordre d''assemblage.';
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

        //Unsupported feature: CodeInsertion on ""Location Code"(Control 28)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW18.00.06 MSF 03/03/2015 DIT-770 #1192
        if "Location Code" <> xRec."Location Code" then
          CurrPage.UPDATE(true)
        //>> DITW18.00.06 MSF 03/03/2015 DIT-770 #1192
        */
        //end;

        //BC UPGRADE PATHAA02-DIT>>
        // addafter("Variant Code")
        // {
        //     field("Responsibility Center"; "Responsibility Center")
        //     {
        //         Editable = IsAsmToOrderEditable;
        //         Importance = Promoted;
        //         QuickEntry = false;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW18.00.06 MSF 03/03/2015 DIT-770 #1192
        //             if "Responsibility Center" <> xRec."Responsibility Center" then
        //                 CurrPage.UPDATE(true)
        //             //>> DITW18.00.06 MSF 03/03/2015 DIT-770 #1192
        //         end;
        //     }
        //     field("Physical Location Group Code"; "Physical Location Group Code")
        //     {
        //         Editable = IsAsmToOrderEditable;
        //         Importance = Promoted;
        //         QuickEntry = false;

        //         trigger OnValidate();
        //         begin
        //             // <<DITW18.00.06 MSF 03/03/2015 DIT-770 #1192
        //             if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
        //                 CurrPage.UPDATE(true)
        //             //>> DITW18.00.06 MSF 03/03/2015 DIT-770 #1192
        //         end;
        //     }
        // }
        //BC UPGRADE PATHAA02-DIT<<
    }
    actions
    {
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
            CaptionML = ENU = 'Comments', FRA = 'Commentaires';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Update Unit Cost")
        {
            CaptionML = ENU = 'Update Unit Cost', FRA = 'Mettre à jour coût unitaire';
        }
        modify("Refresh Lines")
        {
            CaptionML = ENU = 'Refresh Lines', FRA = 'Actualiser lignes';
        }
        modify("Show Availability")
        {
            CaptionML = ENU = 'Show Availability', FRA = 'Afficher disponibilité';
        }
    }

    var
    //UserMgt: Codeunit "User Setup Management"; //BC UPGRADE PATHAA02-not used


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
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

