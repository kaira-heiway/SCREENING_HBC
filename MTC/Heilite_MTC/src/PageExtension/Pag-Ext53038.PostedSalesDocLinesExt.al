pageextension 53038 PostedSalesDocLinesExt extends "Posted Sales Document Lines"
{
    // version NAVW110.0,DITW110.00.11

    //   DITW110.00.11 MSF 04/10/2017 NRQ#39012 Open page From Warehouse Receipt should filter only on Posted Shipment
    //   HEI.01 CHG2009225 IBM ISYED01 5/20/2019 # Reduce labor intensive entries in 1day returns process-FDD
    //    # changed properties insert allowed, modified allowed,delete allowed.

    //*********************************************//
    //BC UPGRADE SIVA//
    //1. HEI.01 Added properties insert allowed, modified allowed,delete allowed.
    //2. Commented Drint IT code.

    //HEI.01>>
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = true;
    //HEI.01<<
    layout
    {
        modify(Options)
        {
            CaptionML = ENU = 'Options', FRA = 'Options';
        }
        modify(ShowRevLine)
        {
            CaptionML = ENU = 'Show Reversible Lines Only', FRA = 'Afficher uniquement lignes réversibles';
            ToolTipML = ENU = 'Specifies if only lines with quantities that are available to be reversed are shown. For example, on a posted sales invoice with an original quantity of 20, and 15 of the items have already been returned, the quantity that is available to be reversed on the posted sales invoice is 5.', FRA = 'Spécifie si seules les lignes présentant des quantités disponibles à contrepasser sont affichées. Par exemple, pour une facture vente enregistrée avec une quantité initiale de 20 articles et 15 articles déjà renvoyés, la quantité disponible à contrepasser sur la facture vente enregistrée est 5.';
        }
        modify(OriginalQuantity)
        {
            CaptionML = ENU = 'Return Original Quantity', FRA = 'Renvoyer quantité initiale';
            ToolTipML = ENU = 'Specifies whether to use the original quantity to receive quantities associated with specific shipments. For example, on a posted sales invoice with an original quantity of 20, you can match the 20 items with a specific shipment.', FRA = 'Spécifie s''il faut utiliser ou non la quantité originale pour recevoir les quantités associées à des expéditions spécifiques. Par exemple, sur une facture vente enregistrée avec une quantité initiale de 20, vous pouvez faire correspondre les 20 articles avec une expédition spécifique.';
        }
        modify(PostedShipmentsBtn)
        {
            OptionCaptionML = ENU = 'Posted Shipments,Posted Invoices,Posted Return Receipts,Posted Cr. Memos', FRA = 'Expéditions validées,Factures validées,Réceptions retour validées,Avoirs validés';
        }
        modify("STRSUBSTNO('(%1)',""No. of Pstd. Shipments"")")
        {
            CaptionML = ENU = '&Posted Shipments', FRA = 'Ex&péditions enregistrées';
            ToolTipML = ENU = 'Specifies the lines that represent posted shipments.', FRA = 'Spécifie les lignes qui représentent les expéditions enregistrées.';
        }
        modify(NoOfPostedInvoices)
        {
            CaptionML = ENU = 'Posted I&nvoices', FRA = 'Factures e&nregistrées';
            ToolTipML = ENU = 'Specifies the lines that represent posted invoices.', FRA = 'Spécifie les lignes qui représentent les factures validées.';
        }
        modify("STRSUBSTNO('(%1)',""No. of Pstd. Return Receipts"")")
        {
            CaptionML = ENU = 'Posted Ret&urn Receipts', FRA = 'Réceptions reto&ur enreg.';
            ToolTipML = ENU = 'Specifies the lines that represent posted return receipts.', FRA = 'Spécifie les lignes qui représentent les réceptions retour.';
        }
        modify(NoOfPostedCrMemos)
        {
            CaptionML = ENU = 'Posted Cr. &Memos', FRA = '&Avoirs enregistrés';
            ToolTipML = ENU = 'Specifies the lines that represent posted sales credit memos.', FRA = 'Spécifie les lignes qui représentent les avoirs vente validés.';
        }

        //Unsupported feature: Change SubPageLink on "PostedShpts(Control 7)". Please convert manually.

    }

    //Unsupported feature: PropertyModification on "Text000(Variable 1009)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=The document lines that have a G/L account that does not allow direct posting have not been copied to the new document.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=The document lines that have a G/L account that does not allow direct posting have not been copied to the new document.;FRA=Les lignes document avec un compte général où la comptabilisation directe n'est pas autorisée n'ont pas été copiées dans le nouveau document.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1091)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=Document Type Filter;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=Document Type Filter;FRA=Filtre de type de document;
    //Variable type has not been exported.

    var
        RunFromwhseReceipt: Boolean;
        RouteplanningNoFilter: Code[20];


    //Unsupported feature: CodeInsertion on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //begin
    /*
     //<<DITW110.00.11 MSF 04/10/2017 NRQ#39012
    SETFILTER("Route Planning No. Filter",RouteplanningNoFilter);
    //>>DITW110.00.11 MSF 04/10/2017 NRQ#39012
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrentMenuType := 1;
    ChangeSubMenu(CurrentMenuType);
    SETRANGE("No.","No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //<<DITW110.00.11 MSF 04/10/2017 NRQ#39012
    if RunFromwhseReceipt then
      CurrentMenuType := 0
    else
    //>>DITW110.00.11 MSF 04/10/2017 NRQ#39012
      CurrentMenuType := 1;
    ChangeSubMenu(CurrentMenuType);
    SETRANGE("No.","No.");
    */
    //end;

    //BC 
    // procedure SetRunFromWhseReceipt(NewRunFromWhseReceipt: Boolean);
    // begin
    //     //<<DITW110.00.11 MSF 04/10/2017 NRQ#39012
    //     RunFromwhseReceipt := NewRunFromWhseReceipt;
    // end;

    // procedure SetRoutePlanningNoFilter(NewRouteplanningNoFilter: Code[20]);
    // begin
    //     //<<DITW110.00.11 MSF 04/10/2017 NRQ#39012
    //     RouteplanningNoFilter := NewRouteplanningNoFilter;
    // end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

