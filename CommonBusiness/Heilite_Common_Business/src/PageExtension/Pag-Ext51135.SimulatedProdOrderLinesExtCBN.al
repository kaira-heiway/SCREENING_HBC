pageextension 51135 SimulatedProdOrderLinesExtCBN extends "Simulated Prod. Order Lines"
{
    // version NAVW110.0,FINXL8.00.001,QXL9.00.001,DITW110.00.08

    //     FINXL8.00.001 BSA 02/06/2015 #178: Added field "Cross Reference No."

    // DITW15.00.00.37 PRODW14.00.00.16 DDR 23/06/2010 issue 1151 Added to remove Quarantine Quality test when delete purchase line
    // DITW18.00.06 MSF 26/02/2015 DIT-770 #1192 Added fields 2014410 "Responsibility Center"
    //                                                        2014411 "Physical Location Group Code"
    // DITW18.00.06 MSF 03/03/2015 DIT-770 #1192 Bug Fix

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // QXL9.00.001 DAT 23/03/2016 : Quality Management

    //---------------------------------------------------------------------------------------------------------------------------------------
    // BC Upgrade YADAVM09 Editable=False on Description Field


    layout
    {
        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item that is to be produced.', FRA = 'Spécifie le numéro de l''article à produire.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies a code if you have set up variant codes in the Item Variants window.', FRA = 'Spécifie un code si vous avez défini des codes variante dans la fenêtre Variantes article.';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Copies the date in this field from the corresponding field on the production order header.', FRA = 'Copie la date de ce champ à partir du champ correspondant dans l''en-tête de l''ordre de fabrication.';
        }
        modify(Description)
        {
            Editable = false; //BC Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies the value of the Description field on the item card. If you enter a variant code, the variant description is copied to this field instead.', FRA = 'Spécifie la valeur du champ Description de la fiche article. Si vous saisissez un code variante, la description de la variante est copiée dans ce champ à la place de la description.';
        }
        modify("Description 2")
        {
            ToolTipML = ENU = 'Specifies an additional description.', FRA = 'Spécifie une description supplémentaire.';
        }
        modify("Production BOM No.")
        {
            ToolTipML = ENU = 'Specifies the number of the production BOM that is the basis for creating the Prod. Order Component list for this line.', FRA = 'Spécifie le numéro de la nomenclature de production qui est utilisé comme base pour créer la liste Composant O.F. pour cette ligne.';
        }
        modify("Routing No.")
        {
            ToolTipML = ENU = 'Specifies the number of the routing used as the basis for creating the production order routing for this line.', FRA = 'Spécifie le numéro de la gamme utilisée comme base pour créer la gamme ordre de fabrication pour cette ligne.';
        }
        modify("Production BOM Version Code")
        {
            ToolTipML = ENU = 'Specifies the version code of the production BOM.', FRA = 'Spécifie le code de version de la nomenclature de production.';
        }
        modify("Routing Version Code")
        {
            ToolTipML = ENU = 'Specifies the version number of the routing.', FRA = 'Spécifie le numéro de version de la gamme.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location code, if the produced items should be stored in a specific location.', FRA = 'Spécifie le code magasin, si les articles produits doivent être stockés dans un magasin spécifique.';
        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Specifies the bin that the produced item is posted to as output, and from where it can be taken to storage or cross-docked.', FRA = 'Spécifie l''emplacement dans lequel l''article produit est validé en tant que production et d''où il peut être prélevé ou transbordé.';
        }
        modify("Starting Date-Time")
        {
            ToolTipML = ENU = 'Specifies the starting date and the starting time, which are combined in a format called "starting date-time".', FRA = 'Spécifie la date et l''heure de début combinées au format « date/heure début ».';
        }
        modify("Starting Time")
        {
            ToolTipML = ENU = 'Specifies the entry''s starting time, which is retrieved from the production order routing.', FRA = 'Spécifie l''heure de début de l''écriture, qui est copiée à partir de l''ordre de fabrication.';
        }
        modify("Starting Date")
        {
            ToolTipML = ENU = 'Specifies the entry''s starting date, which is retrieved from the production order routing.', FRA = 'Spécifie la date de début de l''écriture, qui est copiée à partir de l''ordre de fabrication.';
        }
        modify("Ending Date-Time")
        {
            ToolTipML = ENU = 'Specifies the ending date and the ending time, which are combined in a format called "ending date-time".', FRA = 'Spécifie la date et l''heure de fin combinées au format « date/heure fin ».';
        }
        modify("Ending Time")
        {
            ToolTipML = ENU = 'Specifies the entry''s ending time, which is retrieved from the production order routing.', FRA = 'Spécifie l''heure de fin de l''écriture, qui est copiée à partir de l''ordre de fabrication.';
        }
        modify("Ending Date")
        {
            ToolTipML = ENU = 'Specifies the entry''s ending date, which is retrieved from the production order routing.', FRA = 'Spécifie la date de fin de l''écriture, qui est copiée à partir de l''ordre de fabrication.';
        }
        modify("Scrap %")
        {
            ToolTipML = ENU = 'Copies the value in this field from the Scrap Percentage field on the item card when the Item No. field is filled in.', FRA = 'Copie la valeur de ce champ à partir du champ Pourcentage rebut de la fiche article lorsque le champ N° article est renseigné.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the quantity to be produced if you manually fill in this line.', FRA = 'Indique la quantité à produire si vous renseignez manuellement cette ligne.';
        }
        modify("Reserved Quantity")
        {
            ToolTipML = ENU = 'Specifies how many units of this item have been reserved.', FRA = 'Spécifie le nombre d''unités de cet article qui ont été réservées.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the base unit of measure code for the item.', FRA = 'Spécifie le code unité de l''article.';
        }
        modify("Unit Cost")
        {
            ToolTipML = ENU = 'Calculates the unit cost, based on the cost of the components in the production order component list, and the routing, if the costing method is not standard.', FRA = 'Calcule le coût unitaire, sur la base de celui des composants dans la liste de composants de l''ordre de fabrication et de la gamme si la méthode évaluation stock n''est pas standard.';
        }
        modify("Cost Amount")
        {
            ToolTipML = ENU = 'Calculates the amount by multiplying the Unit Cost by the Quantity.', FRA = 'Calcule le montant en multipliant le coût unitaire par la quantité.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies a dimension value code for a dimension.', FRA = 'Indique un code section pour un axe analytique.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies a dimension value code for a dimension.', FRA = 'Indique un code section pour un axe analytique.';
        }
        /* //BC Upgrade YADAVM09 Drink it Field commented>>
        addafter("Variant Code")
        {
            field("Cross-Reference No.";"Cross-Reference No.")
            {
            }
        }
        
        addafter("ShortcutDimCode[8]")
        {
            field("Responsibility Center"; "Responsibility Center")
            {
                QuickEntry = false;
                Visible = false;

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
                QuickEntry = false;
                Visible = false;

                trigger OnValidate();
                begin
                    // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
                    if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
                        CurrPage.UPDATE(true);
                    // >>DITW18.00.06 MSF DIT-770 #1192
                end;
                
            }
            
        }
        */ //BC Upgrade YADAVM09 Drink it code commented<<
    }
    actions
    {
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Order &Tracking")
        {
            CaptionML = ENU = 'Order &Tracking', FRA = 'C&haînage';
        }
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
        modify("Reservation Entries")
        {
            CaptionML = ENU = 'Reservation Entries', FRA = 'Écritures réservation';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Ro&uting")
        {
            CaptionML = ENU = 'Ro&uting', FRA = '&Gamme';
        }
        modify(Components)
        {
            CaptionML = ENU = 'Components', FRA = 'Composants';
        }
        modify("Item &Tracking Lines")
        {
            CaptionML = ENU = 'Item &Tracking Lines', FRA = 'Lignes &traçabilité';
        }
    }

    var
        //QualitySetup: Record "Quality Setup";//BC Upgrade YADAVM09 Drink it object
        // QualityManagement: Codeunit "Quality Management";//BC Upgrade YADAVM09 Drink it object
        UserMgt: Codeunit "User Setup Management";


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


    //Unsupported feature: CodeModification on "OnDeleteRecord". Please convert manually.

    //trigger OnDeleteRecord() : Boolean;
    //>>>> ORIGINAL CODE:
    //begin
    /*
    COMMIT;
    if not ReserveProdOrderLine.DeleteLineConfirm(Rec) then
      exit(false);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    //<<QXL9.00.001 DAT 23/03/2016
    if QualitySetup.READPERMISSION then begin
      if not QualityManagement.DeleteProdOrderLineConfirm(Rec) then
        exit(false);
    end;
    //>>QXL9.00.001 DAT 23/03/2016
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

