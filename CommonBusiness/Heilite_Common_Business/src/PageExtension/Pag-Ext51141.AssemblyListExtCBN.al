pageextension 51141 AssemblyListExtCBN extends "Assembly List"
{
    // version NAVW110.0,DITW110.00.08
    //     DITW18.00.06 MSF 26/02/2015 DIT-770 #1192 Added fields 2014410 "Responsibility Center"
    //                                                        2014411 "Physical Location Group Code"
    // DITW18.00.06 MSF 03/03/2015 DIT-770 #1192 Bug Fix

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //***********************************************************************************
    //BC UPGRADE PATHAA02 19.11.25
    //1. Made "Description" field non editable as it can't be handled on Table 900-Assembly Header
    //2. DIT commented
    //3. Code added on "Bin Code"-Onlookup-->from Table900-"Bin Code"-Onlookup as this cannot be handled on Table Extension.

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
        //BC UPGRADE PATHAA02 DIT>>
        // addafter("Remaining Quantity")
        // {
        //     field("Physical Location Group Code"; "Physical Location Group Code")
        //     {
        //         Visible = false;
        //     }
        //     field("Responsibility Center"; "Responsibility Center")
        //     {
        //         Visible = false;
        //     }
        // }
        //BC UPGRADE PATHAA02 DIT<<
    }
    actions
    {
        modify("Show Document")
        {
            CaptionML = ENU = '&Show Document', FRA = '&Afficher document';
        }
        modify("Reservation Entries")
        {
            CaptionML = ENU = '&Reservation Entries', FRA = 'Écritures &réservation';
        }
        modify("Item Tracking Lines")
        {
            CaptionML = ENU = 'Item &Tracking Lines', FRA = '&Lignes traçabilité';
        }
    }


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //begin
    /*
    //<<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
    SetSecurityFilterOnRespCenter();
    //>>DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

