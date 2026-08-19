pageextension 54005 RoutingExt extends Routing
{
    // version NAVW110.0,DITW110.00.10,HEI.01


    //     DITW14.00.00.8 PROD: BrewIt & Quality

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1

    // HEI.01 FDD-GAPID043 IBM LAZARE02 01.09.2017 # New fields: Linked SKU

    // HEI.02 FDD-CHG2136735 IBM.PATHAA02 07.02.2022
    // # Code on Linked SKU-Onlookup
    // # Prefiltered list of Locations based on Users linked to Responsibility Center Employees (Type:Production) else show the Item Locations linked to SKU
    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the routing number.', FRA = 'Spécifie le numéro gamme.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description for the routing header.', FRA = 'Indique une description de l''en-tête gamme.';
        }
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies in which order operations in the routing are performed.', FRA = 'Spécifie l''ordre dans lequel les opérations de la gamme sont exécutées.';
        }
        modify(Status)
        {
            ToolTipML = ENU = 'Specifies the status of this routing.', FRA = 'Spécifie le statut de cette gamme.';
        }
        modify("Search Description")
        {
            ToolTipML = ENU = 'Specifies a search description.', FRA = 'Spécifie une description de recherche.';
        }
        modify("Version Nos.")
        {
            ToolTipML = ENU = 'Specifies the number series you want to use to create a new version of this routing.', FRA = 'Spécifie les souches de numéros à utiliser pour créer une nouvelle version de cette gamme.';
        }
        modify(ActiveVersionCode)
        {
            CaptionML = ENU = 'Active Version', FRA = 'Version courante';
        }
        modify("Last Date Modified")
        {
            ToolTipML = ENU = 'Specifies when the routing card was last modified.', FRA = 'Spécifie la date à laquelle la fiche gamme a été modifiée pour la dernière fois.';
        }
        addafter("Last Date Modified")
        {
            field("Linked SKU"; Rec."Linked SKU FND")
            {
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    //HEI.02>>
                    CLEAR(LocationFilter);
                    CLEAR(NewString);
                    /* //Bc Upgrade YADAVM09 Drink it RespCenterEmplLocationsRec table code commented>>
                    RespCenterEmplLocationsRec.RESET;
                    RespCenterEmplLocationsRec.SETRANGE(RespCenterEmplLocationsRec."User ID", USERID);
                    RespCenterEmplLocationsRec.SETFILTER(RespCenterEmplLocationsRec.Type, '%1', RespCenterEmplLocationsRec.Type::Production);
                    if RespCenterEmplLocationsRec.FINDSET then begin
                        repeat
                            LocationFilter := LocationFilter + '|' + RespCenterEmplLocationsRec."Location Code";
                        until RespCenterEmplLocationsRec.NEXT = 0;
                    end;
                    */ //Bc Upgrade YADAVM09 Drink it RespCenterEmplLocationsRec table code commented>>

                    if LocationFilter <> '' then begin
                        NewString := DELCHR(LocationFilter, '<', '|');
                        StockkeepingUnitRec.RESET();
                        StockkeepingUnitRec.FILTERGROUP(50);
                        StockkeepingUnitRec.SETRANGE("Item No.", Rec."Linked Item No. FND");
                        StockkeepingUnitRec.SETFILTER("Location Code", NewString);
                        if PAGE.RUNMODAL(0, StockkeepingUnitRec) = ACTION::LookupOK then
                            Text := StockkeepingUnitRec."Location Code";
                        StockkeepingUnitRec.FILTERGROUP(0);
                        exit(true);
                    end else begin
                        StockkeepingUnitRec.RESET();
                        StockkeepingUnitRec.FILTERGROUP(51);
                        StockkeepingUnitRec.SETRANGE("Item No.", Rec."Linked Item No. FND");
                        if PAGE.RUNMODAL(0, StockkeepingUnitRec) = ACTION::LookupOK then
                            Text := StockkeepingUnitRec."Location Code";
                        StockkeepingUnitRec.FILTERGROUP(0);
                        exit(true);
                    end;

                    //HEI.02<<
                end;
            }
        }
    }
    actions
    {
        modify("&Routing")
        {
            CaptionML = ENU = '&Routing', FRA = '&Gamme';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
            Promoted = true;
            PromotedCategory = Process;
        }
        modify("&Versions")
        {
            CaptionML = ENU = '&Versions', FRA = '&Versions';
        }
        modify("Where-used")
        {
            CaptionML = ENU = 'Where-used', FRA = 'Cas d''emploi';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Copy &Routing")
        {
            CaptionML = ENU = 'Copy &Routing', FRA = '&Copier gamme';
        }
        modify("Routing Sheet")
        {
            CaptionML = ENU = 'Routing Sheet', FRA = 'Gamme';
        }
        /*//Bc Upgrade YADAVM09 Drink it Action>>
        addafter("Where-used")
        {
            action(Standards)
            {
                CaptionML = ENU = 'Standards',
                            FRA = 'Standards';
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                //RunObject = Page "Routing Standards";
                //RunPageLink = "No." = FIELD("No.");
                //RunPageView = SORTING("No.");
            }
        }
        *///Bc Upgrade YADAVM09 Drink it Action<<

    }

    var
        StockkeepingUnitRec: Record "Stockkeeping Unit";
        // RespCenterEmplLocationsRec: Record "Resp. Center Empl. Locations";//Bc UPgrade YADAVM09 Drink it table
        LocationFilter: Text;
        NewString: Text;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

