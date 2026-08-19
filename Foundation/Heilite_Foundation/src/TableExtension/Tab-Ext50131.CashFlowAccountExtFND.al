tableextension 50131 CashFlowAccountExtFND extends "Cash Flow Account"
{
    // version NAVW110.0,HEI.01
    // HEI.01 FDDRTRGAP069 - Exporting and Filtering Report , IBM.NAIKH01 20.08.2017
    //   # Added a new field 50000 - "Movement Type".
    fields
    {
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Search Name")
        {
            CaptionML = ENU = 'Search Name', FRA = 'Nom de recherche';
        }
        modify("Account Type")
        {
            CaptionML = ENU = 'Account Type', FRA = 'Type compte';
            //OptionCaptionML = ENU='Entry,Heading,Total,Begin-Total,End-Total',FRA='Écriture,Titre,Total,Début total,Fin total';
        }
        modify(Comment)
        {

            //Unsupported feature: Change CalcFormula on "Comment(Field 5)". Please convert manually.

            CaptionML = ENU = 'Comment', FRA = 'Commentaire';
        }
        modify(Blocked)
        {
            CaptionML = ENU = 'Blocked', FRA = 'Bloqué';
        }
        modify("New Page")
        {
            CaptionML = ENU = 'New Page', FRA = 'Nouvelle page';
        }
        modify("No. of Blank Lines")
        {
            CaptionML = ENU = 'No. of Blank Lines', FRA = 'Nbre lignes blanches';
        }
        modify(Indentation)
        {
            CaptionML = ENU = 'Indentation', FRA = 'Indentation';
        }
        modify("Last Date Modified")
        {
            CaptionML = ENU = 'Last Date Modified', FRA = 'Date dern. modification';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify("Cash Flow Forecast Filter")
        {
            CaptionML = ENU = 'Cash Flow Forecast Filter', FRA = 'Filtre prévision de trésorerie';
        }
        modify(Amount)
        {

            //Unsupported feature: Change CalcFormula on "Amount(Field 13)". Please convert manually.

            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("Global Dimension 1 Filter")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Filter"(Field 29)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Filter', FRA = 'Filtre axe principal 1';
        }
        modify("Global Dimension 2 Filter")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Filter"(Field 30)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Filter', FRA = 'Filtre axe principal 2';
        }
        modify(Totaling)
        {
            CaptionML = ENU = 'Totaling', FRA = 'Totalisation';
        }
        modify("Source Type")
        {
            CaptionML = ENU = 'Source Type', FRA = 'Type origine';
            //OptionCaptionML = ENU=' ,Receivables,Payables,Liquid Funds,Cash Flow Manual Expense,Cash Flow Manual Revenue,Sales Orders,Purchase Orders,Fixed Assets Budget,Fixed Assets Disposal,Service Orders,G/L Budget,,,Job,Tax',FRA=' ,Clients,Fournisseurs,Fonds liquides,Dépense manuelle de trésorerie,Revenu manuel de trésorerie,Commandes vente,Commandes achat,Budget immobilisations,Cession d''immobilisations,Commandes service,Budget,,,Projet,Taxe';
        }
        modify("G/L Integration")
        {
            CaptionML = ENU = 'G/L Integration', FRA = 'Intégration compta.';
            OptionCaptionML = ENU = ' ,Balance,Budget,Both', FRA = ' ,Balance,Budget,Les deux';
        }
        modify("G/L Account Filter")
        {
            CaptionML = ENU = 'G/L Account Filter', FRA = 'Filtre compte général';
        }

        //Unsupported feature: CodeModification on "Name(Field 2).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Search Name" = UPPERCASE(xRec.Name)) OR ("Search Name" = '') THEN
          "Search Name" := Name;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Search Name" = UPPERCASE(xRec.Name)) or ("Search Name" = '') then
          "Search Name" := Name;
        */
        //end;


        //Unsupported feature: CodeModification on "Totaling(Field 34).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT ("Account Type" IN ["Account Type"::Total,"Account Type"::"End-Total"]) THEN
          FIELDERROR("Account Type");
        CALCFIELDS(Amount);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not ("Account Type" in ["Account Type"::Total,"Account Type"::"End-Total"]) then
          FIELDERROR("Account Type");
        CALCFIELDS(Amount);
        */
        //end;


        //Unsupported feature: CodeModification on ""G/L Account Filter"(Field 37).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GLAccList.LOOKUPMODE(TRUE);
        IF GLAccList.RUNMODAL = ACTION::LookupOK THEN
          "G/L Account Filter" := COPYSTR(GLAccList.GetSelectionFilter,1,MAXSTRLEN("G/L Account Filter"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GLAccList.LOOKUPMODE(true);
        if GLAccList.RUNMODAL = ACTION::LookupOK then
          "G/L Account Filter" := COPYSTR(GLAccList.GetSelectionFilter,1,MAXSTRLEN("G/L Account Filter"));
        */
        //end;
        field(50000; "Movement Type FND"; Code[20])
        {
            caption = 'Movement Type';
            Description = 'HEI.01';
            TableRelation = "Dimension Value".Code where("Dimension Code" = CONST('MVMT'));
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

